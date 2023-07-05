import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/constants/AppColors.dart';
import 'package:mobile_repairing/controller/LoginController/LoginController.dart';
import 'dart:io';

import 'package:mobile_repairing/dartFunctions/auth_methods.dart';
import 'package:mobile_repairing/routes/RoutesNames.dart';
import 'package:mobile_repairing/utils/utils.dart';
import 'package:mobile_repairing/widgets/custom_title_bar.dart';
import 'package:mobile_repairing/widgets/loader.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());

  bool _isLoading = false;

  final auth = AuthMethods();

  var _textStyleBlack = TextStyle(fontSize: 12.0, color: Colors.black);
  var _textStyleGrey = TextStyle(fontSize: 12.0, color: Colors.grey);
  var _textStyleBlueGrey = TextStyle(fontSize: 12.0, color: Colors.blueGrey);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (FirebaseAuth.instance.currentUser == null) return;
    auth.checkIfVendor();
  }

  @override
  void dispose() {
    super.dispose();
    // _emailIdController.dispose();
    // _passwordController.dispose();
    loginController.emailcontroller.value.dispose();
    loginController.passwordcontroller.value.dispose();
  }

  showSnackBar(String content, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  void _logInUser() async {
    // FirebaseFirestore.instance.collection("repairs").doc("Apple").update({
    //   'iPhone 14 Pro Max': {
    //     "Screen": 400,
    //     "Back Repair": 500,
    //     "Charging Port": 200,
    //     "Battery": 200,
    //     "Front Camera": 120,
    //     "Back Camera": 400,
    //     "Mic": 100,
    //     "EarPc": 100,
    //     "LoudSpearker": 100,
    //     "Diagnostics": 100,
    //   },
    //     'iPhone 14 Pro': {
    //       "Screen": 350,
    //       "Back Repair": 400,
    //       "Charging Port": 200,
    //       "Battery": 200,
    //       "Front Camera": 110,
    //       "Back Camera": 350,
    //       "Mic": 100,
    //       "EarPc": 100,
    //       "LoudSpearker": 100,
    //       "Diagnostics": 100,
    //     },
    //     'iPhone 13 Pro Max': {
    //       "Screen": 300,
    //       "Back Repair": 300,
    //       "Charging Port": 150,
    //       "Battery": 200,
    //       "Front Camera": 100,
    //       "Back Camera": 300,
    //       "Mic": 100,
    //       "EarPc": 100,
    //       "LoudSpearker": 100,
    //       "Diagnostics": 100,
    //     },
    //     "iPhone 13 Pro": {
    //       "Screen": 250,
    //       "Back Repair": 200,
    //       "Charging Port": 150,
    //       "Battery": 200,
    //       "Front Camera": 80,
    //       "Back Camera": 280,
    //       "Mic": 90,
    //       "EarPc": 90,
    //       "LoudSpearker": 90,
    //       "Diagnostics": 90,
    //     },
    //     "iPhone 12 Pro Max": {
    //       "Screen": 200,
    //       "Back Repair": 200,
    //       "Charging Port": 150,
    //       "Battery": 150,
    //       "Front Camera": 70,
    //       "Back Camera": 220,
    //       "Mic": 90,
    //       "EarPc": 90,
    //       "LoudSpearker": 90,
    //       "Diagnostics": 90,
    //     },
    //     "iPhone 12 Pro": {
    //       "Screen": 150,
    //       "Back Repair": 200,
    //       "Charging Port": 100,
    //       "Battery": 150,
    //       "Front Camera": 70,
    //       "Back Camera": 200,
    //       "Mic": 80,
    //       "EarPc": 80,
    //       "LoudSpearker": 80,
    //       "Diagnostics": 80,
    //     },
    //     "iPhone 11": {
    //       "Screen": 100,
    //       "Back Repair": 200,
    //       "Charging Port": 100,
    //       "Battery": 150,
    //       "Front Camera": 70,
    //       "Back Camera": 150,
    //       "Mic": 80,
    //       "EarPc": 80,
    //       "LoudSpearker": 80,
    //       "Diagnostics": 80,
    //     },
    //     "iPhone X": {
    //       "Screen": 80,
    //       "Back Repair": 150,
    //       "Charging Port": 100,
    //       "Battery": 150,
    //       "Front Camera": 70,
    //       "Back Camera": 100,
    //       "Mic": 80,
    //       "EarPc": 80,
    //       "LoudSpearker": 80,
    //       "Diagnostics": 80,
    //     }
    // });
    if(!_formKey.currentState!.validate())return;
    setState(() {
      _isLoading = true;
    });
    String result = await auth.logInUser(
      email: loginController.emailcontroller.value.text,
      password: loginController.passwordcontroller.value.text,
    );
    if (result == 'success') {
        await auth.checkIfVendor(loginController.emailcontroller.value.text);
    } else {
      print("Error");
      showSnackBar(result, context);
    }
    if(!mounted)return;
    setState(() {
      _isLoading = false;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const CustomTitleBar(
              title: 'Login',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Text(
                "Please enter your details to sign up and create an account.",
                textAlign: TextAlign.center,
                style: GoogleFonts.commissioner(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackClr),
              ),
            ),
            // SizedBox(
            //   height: height * 0.05,
            // ),
            Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: _userIDEditContainer(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: _passwordEditContainer(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Get.toNamed(RoutesNames.ForgotPasswordScreen);
                            },
                            child: Text(
                              "Forgot your password?",
                              style: GoogleFonts.commissioner(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryClr),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: _loginContainer(),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(RoutesNames.SignupScreen);
              },
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Don’t have an account?  ",
                    style: GoogleFonts.commissioner(
                        color: AppColors.blackClr,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500)),
                TextSpan(
                    text: " Create one",
                    style: GoogleFonts.commissioner(
                        color: AppColors.primaryClr,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500)),
              ])),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget _userIDEditContainer() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "Name",
            style: GoogleFonts.commissioner(
                color: AppColors.blackClr,
                fontWeight: FontWeight.w600,
                fontSize: 16),
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        TextFormField(
          controller: loginController.emailcontroller.value,
          focusNode: loginController.emailFocusNode.value,
          cursorColor: AppColors.blackClr,
          validator: (input) => input!.trim().isEmpty
              ? 'email is required!'
              : !auth.isEmailValid(input)
                  ? 'Please enter a valid email address'
                  : null,
          onFieldSubmitted: (value) {
            utils.fieldChange(context, loginController.emailFocusNode.value,
                loginController.passwordFocusNode.value);
          },
          decoration: InputDecoration(
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(width: 1, color: Colors.red)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(width: 1, color: AppColors.TextFieldClr)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(width: 1, color: AppColors.TextFieldClr)),
            filled: true,
            fillColor: AppColors.TextFieldClr,
            hintText: "Enter your email",
            hintStyle: GoogleFonts.commissioner(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ],
    )
        // TextField(
        //   controller: _emailIdController,
        //   decoration: InputDecoration(
        //       hintText: 'Phone number, email or username',
        //       border:  OutlineInputBorder(
        //         borderSide:  BorderSide(color: Colors.black),
        //       ),
        //       isDense: true),
        //   style: _textStyleBlack,
        // ),
        );
  }

  Widget _passwordEditContainer() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
        padding: EdgeInsets.only(top: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "Password",
                style: GoogleFonts.commissioner(
                    color: AppColors.blackClr,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Obx(() {
              return TextFormField(
                obscureText: loginController.isObsecure.value,
                controller: loginController.passwordcontroller.value,
                focusNode: loginController.passwordFocusNode.value,
                cursorColor: AppColors.blackClr,
                validator: (input) =>
                    input!.trim().isEmpty ? "password is required!" : null,
                onFieldSubmitted: (value) {},
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(width: 1, color: Colors.red)),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      loginController.isObsecure.value =
                          !loginController.isObsecure.value;
                    },
                    child: Icon(Icons.remove_red_eye,
                        color: loginController.isObsecure.value == false
                            ? AppColors.primaryClr
                            : Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(width: 1, color: AppColors.TextFieldClr)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(width: 1, color: AppColors.TextFieldClr)),
                  filled: true,
                  fillColor: AppColors.TextFieldClr,
                  hintText: "Enter your password",
                  hintStyle: GoogleFonts.commissioner(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              );
            })
          ],
        ));
  }

  Widget _loginContainer() {
    return GestureDetector(
      // onTap: _logInUser,
      onTap: () {
        _logInUser();
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.primaryClr,
            borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.06,
        child: _isLoading
            ? const Loader(
                color: Colors.white,
              )
            : Text(
                'Log in',
                style: GoogleFonts.commissioner(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700),
              ),
      ),
    );
  }

  _showEmptyDialog(String title) {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          content: Text("$title can't be empty"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                  style: GoogleFonts.commissioner(color: AppColors.primaryClr),
                ))
          ],
        ),
      );
    } else if (Platform.isIOS) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
          content: Text("$title can't be empty"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK",
                    style:
                        GoogleFonts.commissioner(color: AppColors.primaryClr)))
          ],
        ),
      );
    }
  }
}
