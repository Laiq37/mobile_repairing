import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/data/drawer.dart';
import 'package:mobile_repairing/utils/utils.dart';
import 'package:mobile_repairing/widgets/custom_title_bar.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_email_sender/flutter_email_sender.dart';
import '../../constants/AppColors.dart';
import '../../routes/RoutesNames.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

final _formKey = GlobalKey<FormState>();

class _ContactUsScreenState extends State<ContactUsScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final msgController = TextEditingController();
  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final msgFocusNode = FocusNode();

  showSnackBar(String content, BuildContext context) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(content),
          ),
        );
      }

  Future sendEmail(
      {required String name,
      required String emaill,
      required String subject,
      required String phone, 
      required String message}) async {    
    
    final Email email = Email(
  body: '$message \n $name \n $emaill \n $phone',
  subject: subject,
  recipients: ['test@gmail.com'],
  // cc: ['cc@example.com'],
  // bcc: ['bcc@example.com'],
  // attachmentPaths: ['/path/to/attachment.zip'],
  isHTML: false,
);

await FlutterEmailSender.send(email);
        
    // final serviceId = 'service_xqrkndo';
    // final templateId = 'template_lm2pfkm';
    // final userId = 'EbutZx21JUBQQgC7J';
    // final accessToken = "NI5WZytnDOAI6XTYKl18s";
    // final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    // final response = await http.post(url,
    //     headers: {
    //       'Content-Type': 'application/json',
    //     },
    //     body: json.encode({
    //       'service_id': serviceId,
    //       'template_id': templateId,
    //       'user_id': userId,
    //       'accessToken': accessToken,
    //       'template_params': {
    //         'user_name': name,
    //         'user_email': email,
    //         'user_subject': subject,
    //         'message': "$name \n $email \n $phone \n $message"
    //       }
    //     }));
    // print("Response body ${response.body} and status code ${response.statusCode}");
    // if (response.statusCode == 200) {
    //   showSnackBar("Email sent successfully!", context);
    //   Get.offAndToNamed(RoutesNames.SelectServiceScreen);  
    // } else {
    //   print('Error sending email: ${response.body}');
    // }
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
              title: 'Contact Us',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * 0.02,
                              ),
                              NameTextField(
                                  height: height,
                                  nameController: nameController,
                                  nameFocusNode: nameFocusNode,
                                  emailFocusNode: emailFocusNode),
                              SizedBox(
                                height: height * 0.025,
                              ),
                              EmailTextField(
                                  height: height,
                                  emailController: emailController,
                                  emailFocusNode: emailFocusNode,
                                  phoneFocusNode: phoneFocusNode),
                              SizedBox(
                                height: height * 0.025,
                              ),
                              PhoneTextField(
                                  height: height,
                                  phoneController: phoneController,
                                  phoneFocusNode: phoneFocusNode,
                                  msgFocusNode: msgFocusNode),
                              SizedBox(
                                height: height * 0.025,
                              ),
                              MessageTextField(
                                  height: height,
                                  msgController: msgController,
                                  msgFocusNode: msgFocusNode)
                            ],
                          ),
                        )),
                    SizedBox(
                      height: height * 0.10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: GestureDetector(
                          onTap: () {
                            if(emailController.text.isNotEmpty && msgController.text.isNotEmpty && phoneController.text.isNotEmpty && nameController.text.isNotEmpty){
                            sendEmail(
                                emaill: emailController.text,
                                message: msgController.text,
                                phone: phoneController.text,
                                name: nameController.text,
                                subject: "iMobile Repairing App");
                            }else{
                              showSnackBar("Please fill the all input", context);
                            }
                          },
                          child: SendButton(height: height, width: width)),
                    )
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

class SendButton extends StatelessWidget {
  const SendButton({
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
          "Send",
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

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    super.key,
    required this.height,
    required this.phoneController,
    required this.phoneFocusNode,
    required this.msgFocusNode,
  });

  final double height;
  final TextEditingController phoneController;
  final FocusNode phoneFocusNode;
  final FocusNode msgFocusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "Phone no",
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
          controller: phoneController,
          focusNode: phoneFocusNode,
          cursorColor: AppColors.blackClr,
          keyboardType: TextInputType.phone,
          onFieldSubmitted: (value) {
            utils.fieldChange(context, phoneFocusNode, msgFocusNode);
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
            hintText: "Enter your phone no",
            hintStyle: GoogleFonts.commissioner(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ));
  }
}

class MessageTextField extends StatelessWidget {
  const MessageTextField({
    super.key,
    required this.height,
    required this.msgController,
    required this.msgFocusNode,
  });

  final double height;
  final TextEditingController msgController;
  final FocusNode msgFocusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "Message",
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
          maxLines: 4,
          controller: msgController,
          focusNode: msgFocusNode,
          cursorColor: AppColors.blackClr,
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
            hintText: "Enter your message",
            hintStyle: GoogleFonts.commissioner(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ));
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    required this.height,
    required this.emailController,
    required this.emailFocusNode,
    required this.phoneFocusNode,
  });

  final double height;
  final TextEditingController emailController;
  final FocusNode emailFocusNode;
  final FocusNode phoneFocusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "Email",
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
          controller: emailController,
          focusNode: emailFocusNode,
          cursorColor: AppColors.blackClr,
          onFieldSubmitted: (value) {
            utils.fieldChange(context, emailFocusNode, phoneFocusNode);
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
    ));
  }
}

class NameTextField extends StatelessWidget {
  const NameTextField({
    super.key,
    required this.height,
    required this.nameController,
    required this.nameFocusNode,
    required this.emailFocusNode,
  });

  final double height;
  final TextEditingController nameController;
  final FocusNode nameFocusNode;
  final FocusNode emailFocusNode;

  @override
  Widget build(BuildContext context) {
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
          controller: nameController,
          focusNode: nameFocusNode,
          cursorColor: AppColors.blackClr,
          onFieldSubmitted: (value) {
            utils.fieldChange(context, nameFocusNode, emailFocusNode);
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
            hintText: "Enter your name",
            hintStyle: GoogleFonts.commissioner(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ));
  }
}
