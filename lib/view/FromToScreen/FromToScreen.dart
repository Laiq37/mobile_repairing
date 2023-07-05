import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/constants/AppColors.dart';
import 'package:mobile_repairing/data/NextButton.dart';
import 'package:mobile_repairing/data/data.dart';
import 'package:mobile_repairing/data/drawer.dart';
import 'package:mobile_repairing/widgets/custom_dropdown.dart';
import 'package:mobile_repairing/widgets/custom_title_bar.dart';

import '../../routes/RoutesNames.dart';

class FromToScreen extends StatefulWidget {
  const FromToScreen({super.key});

  @override
  State<FromToScreen> createState() => _FromToScreenState();
}


class _FromToScreenState extends State<FromToScreen> {
final imeicontroller = TextEditingController();
  var data = Get.arguments;
  String selectService = 'select service';
  late final List<String> services;
  late final String fromService;
  final _formKey = GlobalKey<FormState>();

  setServices() {
    fromService = data['service'];
    services = [selectService, ...data['services'].map((item) => item.id)];
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setServices();
  }

  onServiceChanged(String? value) async {
    try {
      if (value! == "select service") return;
      selectService = value;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Data from previous screen $data");
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.whiteClr),
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTitleBar(
              title: 'Unlocking',
            ),
            SizedBox(
              height: height * 0.06,
            ),
            CustomDropDown(
                items: const [],
                dropDownTitle: "From",
                hint: fromService,
                selectedItem: fromService,
                onChanged: (value) {}),
            SizedBox(
              height: height * 0.04,
            ),
            CustomDropDown(
                items: services,
                dropDownTitle: "To",
                hint: 'select service',
                selectedItem: selectService,
                onChanged: onServiceChanged),
            SizedBox(
              height: height * 0.04,
            ),
            const Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: 33,
              ),
              child: CustomTexts(txt: "IMEI"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 33, vertical: 10),
              child: Form(key: _formKey,child: imeiTextfield()),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 33, vertical: 10),
              child: GestureDetector(
                  onTap: () {
                                if (selectService == "select service") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Please select a service")));
                                    return;
                                  }
                                  if (!_formKey.currentState!.validate())return;
                                  Get.offAndToNamed(RoutesNames.SummaryScreen,
                                      arguments: {
                                        "type": "network",
                                        "from": fromService,
                                        "to": selectService,
                                        "imei_no.": imeicontroller.text,
                                        "status": "pending"
                                      });
                  },
                  child: NextButton(height: height, width: width)),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField imeiTextfield() {
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 14,
      controller: imeicontroller,
      validator: (input)=>input == null || input.trim() == "" || input.length < 14 || int.tryParse(input) == null ?  "Please enter a valid IMEI number": null,
      // focusNode: emailFocusNode,
      // cursorColor: AppColors.blackClr,

      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1, color: Colors.red)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1, color: AppColors.TextFieldClr)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1, color: AppColors.TextFieldClr)),
        filled: true,
        fillColor: AppColors.TextFieldClr,
        hintText: "Enter 14 digit number",
        hintStyle: GoogleFonts.commissioner(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}

class CustomTexts extends StatelessWidget {
  const CustomTexts({required this.txt});
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: GoogleFonts.commissioner(
          color: AppColors.blackClr, fontWeight: FontWeight.w600, fontSize: 16),
    );
  }
}
