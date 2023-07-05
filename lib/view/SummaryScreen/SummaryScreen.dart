import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/constants/AppColors.dart';
import 'package:mobile_repairing/data/drawer.dart';
import 'package:mobile_repairing/routes/RoutesNames.dart';
import 'package:mobile_repairing/widgets/custom_title_bar.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_repairing/widgets/loader.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  // For Stripe Payment
  Map<String, dynamic>? paymentIntent;
  var orderDetail = Get.arguments;
  late double tax;
  late double amount;
  late double payable;
  late double shipping;
  bool isLoading = true;

  getCharges() async {
    var charges = await FirebaseFirestore.instance
        .collection("charges")
        .doc('charges')
        .get()
        .catchError((err) {
      print(err);
      Get.back();
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
            const SnackBar(content: Text("Something went wrong, try again!")));
    });
    tax = charges.data()!["tax"].toDouble();
    shipping = charges.data()!['shipping_charges'].toDouble();
    amount = orderDetail['amount'] ??
        charges.data()![orderDetail["type"] == "network"
            ? "network"
            : orderDetail["type"] == "Apple"
                ? "apple"
                : "android"].toDouble();

    payable = amount + tax + shipping;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
   getCharges();
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent(payable.toInt().toString(), 'USD');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
                  // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Adnan'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  // Display payment popup after successfull transaction
  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));
        paymentIntent = null;
        final lastOrderId = await FirebaseFirestore.instance
            .collection('lastOrder')
            .doc('id')
            .get();
        final orderNo = lastOrderId.data()?["last_order_no"] == null
            ? 0001
            : lastOrderId.data()!["last_order_no"] + 1;
        await FirebaseFirestore.instance
            .collection('orders')
            .doc('$orderNo')
            .set(orderDetail)
            .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Order has been successully place, your order no. is $orderNo"))));
        await FirebaseFirestore.instance
            .collection('lastOrder')
            .doc('id')
            .set({"last_order_no": orderNo});
        Get.offAndToNamed(RoutesNames.ThankyouScreen, arguments: orderNo);
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  // create payment intent
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51I5tHmIgEohNnSipJbYfmHfnUJSqEtzCaCw8eloBqc06FMkoSXq42V9P893Tlg9N7eklV5SapGSfwZ8Un1fxvLtq00KcqlPqF4',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  // Calculate amount
  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  // For Stripe Payment
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.whiteClr),
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        width: width,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomTitleBar(
              title: 'Order Summary',
            ),
            isLoading ? Padding(padding: EdgeInsets.only(top: height * 0.2), child: const Loader(),)
            :Expanded(child: Column(children: [

            SizedBox(
              height: height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: PaymentMethod(height, width),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: OrderSummary(height, width),
            ),
            Spacer(),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: PayNowButton(height, width))
            ],))
          ],
        ),
      ),
    );
  }

  GestureDetector PayNowButton(double height, double width) {
    return GestureDetector(
      onTap: () async {
        await makePayment();
      },
      child: Container(
        height: height * 0.06,
        decoration: BoxDecoration(
            color: AppColors.primaryClr,
            borderRadius: BorderRadius.circular(10)),
        width: width * 0.85,
        child: Center(
          child: Text(
            "Pay Now",
            style: GoogleFonts.commissioner(
                color: AppColors.whiteClr,
                fontWeight: FontWeight.w700,
                fontSize: 24),
          ),
        ),
      ),
    );
  }

  Container PaymentMethod(double height, double width) {
    return Container(
      height: height * 0.1,
      width: width * 0.85,
      color: Colors.white,
      child: Center(
        child: ListTile(
          leading: Image.asset("assets/images/wallet 1.png"),
          title: Text(
            "Payment Method",
            style: GoogleFonts.commissioner(
                color: AppColors.blackClr,
                fontWeight: FontWeight.w500,
                fontSize: 17),
          ),
          subtitle: Text(
            "Visa/Master Card",
            style: GoogleFonts.commissioner(
                color: AppColors.blackClr.withOpacity(0.6),
                fontWeight: FontWeight.w400,
                fontSize: 13),
          ),
        ),
      ),
    );
  }

  Container OrderSummary(double height, double width) {
    return Container(
      // height: height * 0.3,
      width: width * 0.85,
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            ListTile(
              leading: Image.asset("assets/images/order 1.png"),
              title: Text(
                "Order Summary",
                style: GoogleFonts.commissioner(
                    color: AppColors.blackClr,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Service Charges",
                        style: GoogleFonts.commissioner(
                            color: AppColors.blackClr.withOpacity(0.6),
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                      Text(
                        "$amount\$",
                        style: GoogleFonts.commissioner(
                            color: AppColors.blackClr.withOpacity(0.6),
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shipping Charges",
                        style: GoogleFonts.commissioner(
                            color: AppColors.blackClr.withOpacity(0.6),
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                      Text(
                        "$shipping\$",
                        style: GoogleFonts.commissioner(
                            color: AppColors.blackClr.withOpacity(0.6),
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tax Charges",
                        style: GoogleFonts.commissioner(
                            color: AppColors.blackClr.withOpacity(0.6),
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                      Text(
                        "$tax\$",
                        style: GoogleFonts.commissioner(
                            color: AppColors.blackClr.withOpacity(0.6),
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: GoogleFonts.commissioner(
                            color: AppColors.blackClr.withOpacity(0.8),
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                      Text(
                        "$payable\$",
                        style: GoogleFonts.commissioner(
                            color: AppColors.blackClr.withOpacity(0.8),
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "Card No",
                  //       style: GoogleFonts.commissioner(
                  //           color: AppColors.blackClr.withOpacity(0.8),
                  //           fontWeight: FontWeight.w700,
                  //           fontSize: 14),
                  //     ),
                  //     Text(
                  //       "1 3 12 20311 714 120690",
                  //       style: GoogleFonts.commissioner(
                  //           color: AppColors.primaryClr,
                  //           fontWeight: FontWeight.w700,
                  //           fontSize: 14),
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "CVV",
                  //       style: GoogleFonts.commissioner(
                  //           color: AppColors.blackClr.withOpacity(0.8),
                  //           fontWeight: FontWeight.w700,
                  //           fontSize: 14),
                  //     ),
                  //     Text(
                  //       "1234",
                  //       style: GoogleFonts.commissioner(
                  //           color: AppColors.primaryClr,
                  //           fontWeight: FontWeight.w700,
                  //           fontSize: 14),
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "Expiry Date",
                  //       style: GoogleFonts.commissioner(
                  //           color: AppColors.blackClr.withOpacity(0.8),
                  //           fontWeight: FontWeight.w700,
                  //           fontSize: 14),
                  //     ),
                  //     Text(
                  //       "07-04-2023",
                  //       style: GoogleFonts.commissioner(
                  //           color: AppColors.primaryClr,
                  //           fontWeight: FontWeight.w700,
                  //           fontSize: 14),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
