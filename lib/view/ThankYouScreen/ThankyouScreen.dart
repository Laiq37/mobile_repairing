import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/constants/AppColors.dart';
import 'package:mobile_repairing/routes/RoutesNames.dart';
import 'package:mobile_repairing/widgets/custom_title_bar.dart';

import '../../data/drawer.dart';

class ThankyouScreen extends StatefulWidget {
  const ThankyouScreen({super.key});

  @override
  State<ThankyouScreen> createState() => _ThankyouScreenState();
}

class _ThankyouScreenState extends State<ThankyouScreen> {

  var orderNo = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((val) {
      // Navigation Here
      print("Clear stackkkkk");
      Get.offAllNamed(RoutesNames.SelectServiceScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
     extendBodyBehindAppBar: true,
        drawer: MyDrawer(),
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
                title: 'Thank You',
              ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/image 26.png",
                      height: height * 0.23,
                      width: width * 0.3,
                    ),
                    Text(
                      "Thank You!",
                      style: GoogleFonts.commissioner(
                          color: AppColors.primaryClr,
                          fontWeight: FontWeight.w700,
                          fontSize: 33),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      "Order Placed Successfully!",
                      style: GoogleFonts.commissioner(
                          color: AppColors.blackClr,
                          fontWeight: FontWeight.w500,
                          fontSize: 25),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Your order is successfully processed! \n",
                              style: GoogleFonts.commissioner(
                                  color: AppColors.blackClr,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                            TextSpan(
                              text: "Order number $orderNo",
                              style: GoogleFonts.commissioner(
                                  color: AppColors.blackClr,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            ),
                            TextSpan(
                              text: " Check your email for shipping instruction. ",
                              style: GoogleFonts.commissioner(
                                  color: AppColors.blackClr,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            )
                          ])),
                    ),
                    SizedBox(
                      height: height * 0.07,
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(RoutesNames.SelectServiceScreen);
                        },
                        child: ContinueShippingButton(height: height, width: width))
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

class ContinueShippingButton extends StatelessWidget {
  const ContinueShippingButton({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Continue Shipping",
          style: GoogleFonts.commissioner(
              color: AppColors.whiteClr,
              fontWeight: FontWeight.w700,
              fontSize: 18),
        ),
      ),
      height: height * 0.06,
      decoration: BoxDecoration(
          color: AppColors.primaryClr, borderRadius: BorderRadius.circular(10)),
      width: width * 0.85,
    );
  }
}
