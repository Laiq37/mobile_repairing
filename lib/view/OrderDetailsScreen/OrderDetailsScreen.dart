import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_repairing/constants/AppColors.dart';
import 'package:mobile_repairing/data/drawer.dart';
import 'package:mobile_repairing/widgets/custom_title_bar.dart';
import 'package:get/get.dart';
import 'package:mobile_repairing/widgets/loader.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  var orderId = Get.arguments;
  late final LottieComposition _composition;
  late final String? orderStatus;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    // _composition = NetworkLottie("https://assets8.lottiefiles.com/packages/lf20_3WsNKy.json").load();
  }

  getData() async {
    _composition = await NetworkLottie(
            "https://assets8.lottiefiles.com/packages/lf20_3WsNKy.json")
        .load();
    var data = await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .get();
    orderStatus = data.data()?["status"];
    setState(() {
      isLoading = false;
    });
  }

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
          children: [
            const CustomTitleBar(
              title: 'Order Status',
            ),
            isLoading
                ? Padding(
                    padding: EdgeInsets.only(top: height * 0.3),
                    child: const Loader(),
                  )
                : orderStatus == null
                    ? Padding(
                        padding: EdgeInsets.only(top: height * 0.3),
                        child: Text(
                          "Order not Found!",
                          style: GoogleFonts.commissioner(
                              color: AppColors.primaryClr,
                              fontWeight: FontWeight.w700,
                              fontSize: 25),
                        ),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Lottie(composition: _composition)),

                              RichText(
                                  text: TextSpan(
                                      style: GoogleFonts.commissioner(
                                          color: AppColors.blackClr,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 25),
                                      children: [
                                    TextSpan(text: "Your Order Is "),
                                    TextSpan(
                                      text: orderStatus!.capitalizeFirst,
                                      style: GoogleFonts.commissioner(
                                          color: AppColors.primaryClr,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 25),
                                    ),
                                  ])),
                              // SizedBox(
                              //   height: height * 0.05,
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(bottom: 20),
                              //   child: Container(
                              //     height: height * 0.24,
                              //     width: width * 0.77,
                              //     decoration: BoxDecoration(
                              //         color: AppColors.primaryClr.withOpacity(0.3),
                              //         borderRadius: BorderRadius.circular(9)),
                              //     child: Padding(
                              //       padding:
                              //           const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                              //       child: Column(
                              //         children: [
                              //           Text("Notes",
                              //               style: GoogleFonts.commissioner(
                              //                   color: AppColors.blackClr,
                              //                   fontWeight: FontWeight.w700,
                              //                   fontSize: 22)),
                              //           SizedBox(
                              //             height: height * 0.015,
                              //           ),
                              //           Expanded(
                              //             child: Text(
                              //               "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                              //               textAlign: TextAlign.center,
                              //               style: GoogleFonts.commissioner(
                              //                   color: AppColors.blackClr,
                              //                   fontWeight: FontWeight.w400,
                              //                   fontSize: 15.5),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
