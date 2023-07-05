import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/constants/AppColors.dart';
import 'package:mobile_repairing/utils/utils.dart';

class ForgotPasword extends StatefulWidget {
  @override
  _ForgotPaswordState createState() => _ForgotPaswordState();
}

class _ForgotPaswordState extends State<ForgotPasword> {
  final emailIdController = TextEditingController();

showSnackBar(String content, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailIdController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.blackClr),
        backgroundColor: Color(0xFFFAFAFA),
        centerTitle: true,
        title: Text(
          "Forgot Password",
          style: GoogleFonts.commissioner(
              color: AppColors.blackClr,
              fontWeight: FontWeight.w700,
              fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Text(
                "Recieved an email to reset your password.",
                textAlign: TextAlign.center,
                style: GoogleFonts.commissioner(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackClr),
              ),
            ),
             Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: TextFormField(
                controller: emailIdController,
                decoration:const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            GestureDetector(
      // onTap: _logInUser,
      onTap: resetPassword,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.primaryClr,
              borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 10.0),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.06,
          child: Center(
                  child: Text(
                  'Reset',
                  style: GoogleFonts.commissioner(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700),
                ),
                )
          // : Text(
          //     "Log In",
          //     style: TextStyle(color: Colors.white),
          //   ),
          // color: Colors.blue,
        ),
      ),
    ),
          ],
        ),
      ),
    );
  }
  Future resetPassword() async {
    try{
  await FirebaseAuth.instance.sendPasswordResetEmail(email: emailIdController.text.trim());

  showSnackBar("Password Reset Email sent", context);
    }on FirebaseAuthException catch(e){
      print(e);
      showSnackBar("${e.message}", context);
    }
}
}
 