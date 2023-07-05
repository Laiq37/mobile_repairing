import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/constants/AppColors.dart';
import 'package:mobile_repairing/controller/SelectServiceController/SelectServiceController.dart';
import 'package:mobile_repairing/dartFunctions/auth_methods.dart';
import 'package:mobile_repairing/data/data.dart';
import 'package:mobile_repairing/data/drawer.dart';
import 'package:mobile_repairing/routes/RoutesNames.dart';
import 'package:mobile_repairing/widgets/custom_title_bar.dart';

import '../../controller/SelectServiceController/ServicesContainer/ServicesContainer.dart';

class SelectServiceScreen extends StatefulWidget {
  const SelectServiceScreen({super.key});

  @override
  State<SelectServiceScreen> createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  SelectServiceController servicesController =
      Get.put(SelectServiceController());
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: MyDrawer(),
      appBar: AppBar(
         actions: [
          IconButton(onPressed: (){
            AuthMethods().logout();
          }, icon: const Icon(Icons.logout_outlined))
        ],
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.whiteClr),
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomTitleBar(title: 'Select Service',),
            // SizedBox(
            //   height: height * 0.2,
            // ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
              height: height * 0.05,
            ),
                    GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesNames.UnlockingScreen);
                  },
                  child: ServiceContainers(
                    color: AppColors.primaryClr,
                    height: height,
                    width: width,
                    icon: Icon(
                      FontAwesomeIcons.unlock,
                      size: 24,
                      color: AppColors.whiteClr,
                    ),
                    text: "Unlocking",
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesNames.RepairScreen);
                  },
                  child: ServiceContainers(
                    color: AppColors.primaryClr,
                    height: height,
                    width: width,
                    icon: Icon(
                      FontAwesomeIcons.screwdriverWrench,
                      size: 24,
                      color: AppColors.whiteClr,
                    ),
                    text: "Repairs",
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesNames.NetworkUnlockingScreen);
                  },
                  child: ServiceContainers(
                    color: AppColors.primaryClr,
                    height: height,
                    width: width,
                    icon: Icon(
                      FontAwesomeIcons.globe,
                      size: 30,
                      color: AppColors.whiteClr,
                    ),
                    text: "Network Unlockings",
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesNames.ContactUsScreen);
                  },
                  child: ServiceContainers(
                    color: Colors.teal.shade800,
                    height: height,
                    width: width,
                    icon: Icon(
                      FontAwesomeIcons.phone,
                      size: 30,
                      color: AppColors.whiteClr,
                    ),
                    text: "Contact Us",
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesNames.TrackOrderScreen);
                  },
                  child: ServiceContainers(
                    color: Colors.yellow.shade800,
                    height: height,
                    width: width,
                    icon: Icon(
                      FontAwesomeIcons.locationDot,
                      size: 30,
                      color: AppColors.whiteClr,
                    ),
                    text: "Track your order",
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
