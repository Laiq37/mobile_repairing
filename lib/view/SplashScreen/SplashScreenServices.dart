import 'dart:async';

import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../routes/RoutesNames.dart';

class SplashServices {
  timer() {
    Timer(Duration(seconds: 4), () {
      Get.offAndToNamed(RoutesNames.LoginScreen);
    });
  }
}
