import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/constants/AppColors.dart';
import 'package:mobile_repairing/controller/UnlockingController/UnlockingController.dart';
import 'package:mobile_repairing/data/drawer.dart';
import 'package:mobile_repairing/routes/RoutesNames.dart';
import 'package:mobile_repairing/widgets/custom_title_bar.dart';


class UnlockingScreen extends StatefulWidget {
  const UnlockingScreen({super.key});

  @override
  State<UnlockingScreen> createState() => _UnlockingScreenState();
}

UnlockingController unlockingController = Get.put(UnlockingController());

class _UnlockingScreenState extends State<UnlockingScreen> {
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
        width: MediaQuery.of(context).size.width,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomTitleBar(title: 'Unlockings',),
            SizedBox(
              height: height * 0.07,
            ),
            Text(
              "Password Unlockings",
              style: GoogleFonts.commissioner(
                  color: AppColors.blackClr.withOpacity(0.7),
                  fontWeight: FontWeight.w900,
                  fontSize: 27),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            GestureDetector(
              onTap: () {
                Get.offAndToNamed(RoutesNames.MobileCategoriesAndroidScreen);
              },
              child: Container(
                decoration: BoxDecoration(
                    // color: Colors.indigo.shade100,
                    color: AppColors.primaryClr,
                    borderRadius: BorderRadius.circular(10)),
                height: height * 0.1,
                width: width * 0.85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      FontAwesomeIcons.android,
                      color: AppColors.whiteClr,
                      size: 30,
                    ),
                    Text(
                      "Android",
                      style: GoogleFonts.commissioner(
                          color: AppColors.whiteClr,
                          fontWeight: FontWeight.w700,
                          fontSize: 22),
                    ),
                    SizedBox(
                      width: width * 0.2,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  Get.offAndToNamed(RoutesNames.MobileCategoriesScreen);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.indigo.shade100,
                      color: AppColors.primaryClr),
                  height: height * 0.1,
                  width: width * 0.85,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        FontAwesomeIcons.apple,
                        color: AppColors.whiteClr,
                        size: 30,
                      ),
                      Text(
                        "Iphone",
                        style: GoogleFonts.commissioner(
                            color: AppColors.whiteClr,
                            fontWeight: FontWeight.w700,
                            fontSize: 22),
                      ),
                      SizedBox(
                        width: width * 0.2,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
