import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mobile_repairing/constants/AppColors.dart';
import 'package:mobile_repairing/view/SplashScreen/SplashScreenServices.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    splashServices.timer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(colors: [
        //     Color(0xFF583EF2),
        //     Color(0xff9D59FF),
        //   ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        // ),
        color: AppColors.whiteClr,
        child: Center(
            child: Image.asset(
          "assets/images/app_logo.png",
          width: MediaQuery.of(context).size.width / 1.5,
        )),
      ),
    );
  }
}
