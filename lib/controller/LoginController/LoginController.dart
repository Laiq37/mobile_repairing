import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginController extends GetxController {
  RxBool isObsecure = true.obs;
  final emailcontroller = TextEditingController().obs;
  final passwordcontroller = TextEditingController().obs;
  final phonecontroller = TextEditingController().obs;
  final zipcontroller = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  final phoneFocusNode = FocusNode().obs;
  final zipFocusNode = FocusNode().obs;
}
