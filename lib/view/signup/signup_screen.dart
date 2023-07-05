import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/constants/AppColors.dart';
import 'package:mobile_repairing/controller/SignUpController/SignUpController.dart';
import 'package:mobile_repairing/dartFunctions/auth_methods.dart';
import 'package:mobile_repairing/routes/RoutesNames.dart';
import 'package:mobile_repairing/utils/utils.dart';
import 'package:mobile_repairing/widgets/custom_dropdown.dart';
import 'package:mobile_repairing/widgets/custom_title_bar.dart';

class SignupScreen extends StatefulWidget {
  static final String id = 'signup_screen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  bool _isLoading = false;
  List<String> roles = ["select role","repair", "unlocking","network"];
  String selectedRole = "select role";

  showSnackBar(String content, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  void _signUp() async {
    if (!_formKey.currentState!.validate() || (signupController.isVendor.value && selectedRole == 'select role')) return;
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      // Logging in the user w/ Firebase
      String result = await AuthMethods()
          .signUpUser(_email!, _password!, signupController.isVendor.value, signupController.isVendor.value ? selectedRole : null);
      if (result != 'success') {
        showSnackBar(result, context);
      } else {
        Navigator.pop(context);
      }
      setState(() {
        _isLoading = false;
      });
    
  }

  SignupController signupController = Get.put(SignupController());

  onRoleChanged(String? value) async {
    try {
      if(value! == "select role")return;
      selectedRole = value;
     setState(() {
       
     });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const CustomTitleBar(
              title: 'Sign Up',
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 25),
                      child: Text(
                        "Please enter your details to sign up and create an account.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.commissioner(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blackClr),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                  vertical: 10.0,
                                ),
                                child:
                                    // email field
                                    TextFormField(
                                  controller:
                                      signupController.emailcontroller.value,
                                  focusNode:
                                      signupController.emailFocusNode.value,
                                  cursorColor: AppColors.blackClr,
                                  onFieldSubmitted: (value) {
                                    utils.fieldChange(
                                        context,
                                        signupController.emailFocusNode.value,
                                        signupController
                                            .passwordFocusNode.value);
                                  },
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.red)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: AppColors.TextFieldClr)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: AppColors.TextFieldClr)),
                                    filled: true,
                                    fillColor: AppColors.TextFieldClr,
                                    hintText: "Enter your email address",
                                    hintStyle: GoogleFonts.commissioner(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  validator: (input) => input!.trim().isEmpty
                                      ? 'email is required!'
                                      : !AuthMethods().isEmailValid(input)
                                          ? 'Please enter a valid email address'
                                          : null,
                                  onSaved: (input) => _email = input!,
                                ),
                              ),

                              // password field
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0,
                                    vertical: 10.0,
                                  ),
                                  child: Obx(() {
                                    return TextFormField(
                                      controller: signupController
                                          .passwordcontroller.value,
                                      focusNode: signupController
                                          .passwordFocusNode.value,
                                      onFieldSubmitted: (value) {
                                        utils.fieldChange(
                                            context,
                                            signupController
                                                .passwordFocusNode.value,
                                            signupController
                                                .phoneFocusNode.value);
                                      },
                                      obscureText: signupController.isObsecure.value,
                                      cursorColor: AppColors.blackClr,
                                      decoration: InputDecoration(
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            signupController.isObsecure.value =
                                                !signupController
                                                    .isObsecure.value;
                                          },
                                          child: Icon(Icons.remove_red_eye,
                                              color: signupController
                                                          .isObsecure.value ==
                                                      false
                                                  ? AppColors.primaryClr
                                                  : Colors.grey),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.red)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: AppColors.TextFieldClr)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: AppColors.TextFieldClr)),
                                        filled: true,
                                        fillColor: AppColors.TextFieldClr,
                                        hintText: "Enter your password",
                                        hintStyle: GoogleFonts.commissioner(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      validator: (input) => input!
                                              .trim()
                                              .isEmpty
                                          ? 'password is required!'
                                          : input.length < 4
                                              ? 'password must contain atleast 4 character long'
                                              : null,
                                      onSaved: (input) => _password = input!,
                                    );
                                  })),

                              // Phone field
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                  vertical: 10.0,
                                ),
                                child: TextFormField(
                                  onFieldSubmitted: (value) {
                                    utils.fieldChange(
                                        context,
                                        signupController.phoneFocusNode.value,
                                        signupController.zipFocusNode.value);
                                  },
                                  controller:
                                      signupController.phonecontroller.value,
                                  focusNode:
                                      signupController.phoneFocusNode.value,
                                  keyboardType: TextInputType.phone,
                                  cursorColor: AppColors.blackClr,
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.red)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: AppColors.TextFieldClr)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: AppColors.TextFieldClr)),
                                    filled: true,
                                    fillColor: AppColors.TextFieldClr,
                                    hintText: "Enter your phone number",
                                    hintStyle: GoogleFonts.commissioner(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  validator: (input) => input!.trim().isEmpty
                                      ? 'Please enter a valid phone number'
                                      : null,
                                  // onSaved: (input) => _name = input!,
                                ),
                              ),
                              // zip code field
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                  vertical: 10.0,
                                ),
                                child: TextFormField(
                                  controller:
                                      signupController.zipcontroller.value,
                                  focusNode:
                                      signupController.zipFocusNode.value,
                                  onFieldSubmitted: (value) {},
                                  keyboardType: TextInputType.number,
                                  cursorColor: AppColors.blackClr,
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.red)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: AppColors.TextFieldClr)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: AppColors.TextFieldClr)),
                                    filled: true,
                                    fillColor: AppColors.TextFieldClr,
                                    hintText: "Enter zip code",
                                    hintStyle: GoogleFonts.commissioner(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  validator: (input) => input!.trim().isEmpty
                                      ? 'Please enter a zip code'
                                      : null,
                                  // onSaved: (input) => _name = input!,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  child: Obx(
                                    () {
                                      return SwitchListTile(
                                        contentPadding: EdgeInsets.zero,
                                        activeColor: AppColors.primaryClr,
                                        title: Text(
                                          "Vendor ",
                                          style: GoogleFonts.commissioner(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.blackClr),
                                        ),
                                        value: signupController.isVendor.value,
                                        onChanged: (value) {
                                          signupController.isVendor.value =
                                              value;
                                        },
                                      );
                                    },
                                  )),
                              // SizedBox(height: height * 0.08),
                              Obx(() {
                                return signupController.isVendor.value
                                    ? Padding(
                                        padding: const EdgeInsets.only(bottom: 20
                                            ),
                                        child: CustomDropDown(
                                            items: roles,
                                            hint: "select role",
                                            selectedItem: selectedRole,
                                            onChanged: onRoleChanged),
                                      )
                                    : const SizedBox();
                              }),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 40,
                                  right: 40,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryClr,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: double.infinity,
                                  child: _isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : TextButton(
                                          onPressed: () => _signUp(),
                                          child: Text(
                                            'Register',
                                            style: GoogleFonts.commissioner(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(height: height * 0.03),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(RoutesNames.LoginScreen);
                                },
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: "Already have an account? ",
                                      style: GoogleFonts.commissioner(
                                          color: AppColors.blackClr,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500)),
                                  TextSpan(
                                      text: " Log in",
                                      style: GoogleFonts.commissioner(
                                          color: AppColors.primaryClr,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500)),
                                ])),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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
