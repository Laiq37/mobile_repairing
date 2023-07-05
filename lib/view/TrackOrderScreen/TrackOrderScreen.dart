import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/constants/AppColors.dart';
import 'package:mobile_repairing/data/drawer.dart';
import 'package:mobile_repairing/routes/RoutesNames.dart';
import 'package:mobile_repairing/widgets/custom_title_bar.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  final ordercontroller = TextEditingController();
 final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                title: 'Track your Order',
              ),
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Text(
                      "Enter your order number to track your order",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.commissioner(
                          color: AppColors.blackClr,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              "Order Number",
                              style: GoogleFonts.commissioner(
                                  color: AppColors.blackClr,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: ordercontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(width: 1, color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.TextFieldClr)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.TextFieldClr)),
                                filled: true,
                                fillColor: AppColors.TextFieldClr,
                                hintText: "Enter your order number",
                                hintStyle: GoogleFonts.commissioner(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                
                              ),
                              validator: (input) => input == null || input.trim() == "" || int.tryParse(input) == null ? 'Please enter a valid Order no.' : null,
                            ),
                          ),
                        ],
                      )),
                    ),
                    SizedBox(
                      height: height * 0.3,
                    ),
                    GestureDetector(
                        onTap: () {
                          if(!_formKey.currentState!.validate())return;
                          Get.toNamed(RoutesNames.OrderDetailsScreen, arguments: ordercontroller.text);
                        },
                        child: CheckButton(height: height, width: width))
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

class CheckButton extends StatelessWidget {
  const CheckButton({
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
          "Check",
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
