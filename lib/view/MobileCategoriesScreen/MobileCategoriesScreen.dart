import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/constants/AppColors.dart';
import 'package:mobile_repairing/controller/MobileCategoriesController/MobileCategoriesController.dart';
import 'package:mobile_repairing/dartFunctions/auth_methods.dart';
import 'package:mobile_repairing/data/NextButton.dart';
import 'package:mobile_repairing/data/drawer.dart';
import 'package:mobile_repairing/utils/utils.dart';
import 'package:mobile_repairing/widgets/custom_dropdown.dart';
import 'package:mobile_repairing/widgets/custom_title_bar.dart';
import 'package:mobile_repairing/widgets/loader.dart';
import '../../routes/RoutesNames.dart';

class MobileCategoriesScreen extends StatefulWidget {
  const MobileCategoriesScreen({super.key});

  @override
  State<MobileCategoriesScreen> createState() => _MobileCategoriesScreenState();
}

class _MobileCategoriesScreenState extends State<MobileCategoriesScreen> {
  final notesController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final NotesFocusNode = FocusNode();
  MobilecategoriesController mobilecategoriesController =
      Get.put(MobilecategoriesController());
  bool isLoading = true;
  String selectedModel = 'select model';
  List<String> models = [];
  final _formKey = GlobalKey<FormState>();

  Future getModels() async {
    try {
      var data = await FirebaseFirestore.instance
          .collection('repairs')
          .doc("Apple")
          .get();
      models.addAll([selectedModel, ...data.data()!["brands"]]);
      print(data);
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getModels();
  }

  onModelChanged(String? value) async {
    try {
      if (value! == "select model") return;
      selectedModel = value;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: AppColors.whiteClr),
            backgroundColor: Colors.transparent,
          ),
          body: SizedBox(
              width: width,
              child: Column(children: [
                const CustomTitleBar(
                  title: 'Unlocking',
                ),
                Expanded(
                  child: isLoading
                      ? const Loader()
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.06,
                              ),
                              CustomDropDown(
                                  items: models,
                                  dropDownTitle: 'Model',
                                  hint: 'select Model',
                                  selectedItem: selectedModel,
                                  onChanged: onModelChanged),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 33,
                                        ),
                                        child: Text(
                                          "Email or Apple ID",
                                          style: GoogleFonts.commissioner(
                                              color: AppColors.blackClr,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 33, vertical: 10),
                                        child: TextFormField(
                                          controller: emailController,
                                          focusNode: emailFocusNode,
                                          cursorColor: AppColors.blackClr,
                                          validator: (input) => input!
                                                  .trim()
                                                  .isEmpty
                                              ? 'email is required!'
                                              : !AuthMethods().isEmailValid(input)
                                                  ? 'Please enter a valid email address'
                                                  : null,
                                          onFieldSubmitted: (value) {
                                            utils.fieldChange(
                                                context,
                                                emailFocusNode,
                                                passwordFocusNode);
                                          },
                                          decoration: InputDecoration(
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
                                                    color:
                                                        AppColors.TextFieldClr)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        AppColors.TextFieldClr)),
                                            filled: true,
                                            fillColor: AppColors.TextFieldClr,
                                            hintText:
                                                "Enter your email address or apple ID",
                                            hintStyle: GoogleFonts.commissioner(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 33,
                                        ),
                                        child: Text(
                                          "Password",
                                          style: GoogleFonts.commissioner(
                                              color: AppColors.blackClr,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 33, vertical: 10),
                                          child: Obx(() {
                                            return TextFormField(
                                              controller: passwordController,
                                              focusNode: passwordFocusNode,
                                              validator: (input) =>
                                                  input!.trim().isEmpty
                                                      ? "password is required!"
                                                      : null,
                                              onFieldSubmitted: (value) {
                                                utils.fieldChange(
                                                    context,
                                                    passwordFocusNode,
                                                    NotesFocusNode);
                                              },
                                              obscureText:
                                                  mobilecategoriesController
                                                      .isObsecure.value,
                                              cursorColor: AppColors.blackClr,
                                              decoration: InputDecoration(
                                                suffixIcon: GestureDetector(
                                                  onTap: () {
                                                    mobilecategoriesController
                                                            .isObsecure.value =
                                                        !mobilecategoriesController
                                                            .isObsecure.value;
                                                  },
                                                  child: Icon(
                                                      Icons.remove_red_eye,
                                                      color:
                                                          mobilecategoriesController
                                                                      .isObsecure
                                                                      .value ==
                                                                  false
                                                              ? AppColors
                                                                  .primaryClr
                                                              : Colors.grey),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.red)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: AppColors
                                                            .TextFieldClr)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: AppColors
                                                            .TextFieldClr)),
                                                filled: true,
                                                fillColor: AppColors.TextFieldClr,
                                                hintText: "Enter your password",
                                                hintStyle:
                                                    GoogleFonts.commissioner(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            );
                                          })),
                                    ],
                                  )),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 33,
                                ),
                                child: Text(
                                  "Notes",
                                  style: GoogleFonts.commissioner(
                                      color: AppColors.blackClr,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 33, vertical: 10),
                                child: TextFormField(
                                  maxLines: 4,
                                  controller: notesController,
                                  focusNode: NotesFocusNode,
                                  cursorColor: AppColors.blackClr,
                                  // onFieldSubmitted: (value) {
                                  //   utils.fieldChange(context, emailFocusNode, passwordFocusNode);
                                  // },
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
                                    hintText: "Enter Notes",
                                    hintStyle: GoogleFonts.commissioner(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 33, vertical: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    if (selectedModel == "select model") {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text("Please select a model")));
                                      return;
                                    }
                                    if (!_formKey.currentState!.validate())return;
                                    Get.offAndToNamed(RoutesNames.SummaryScreen,
                                        arguments: {
                                          "type": "unlocking",
                                          "brand": "Apple/Iphone",
                                          "model": selectedModel,
                                          "email": emailController.text,
                                          "password": passwordController.text,
                                          "notes": notesController.text,
                                          "status": "pending"
                                        });
                                  },
                                  child: NextButton(
                                    height: height,
                                    width: width,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                            ],
                          ),
                        ),
                )
              ]))),
    );
  }
}

class DropDownTexts extends StatelessWidget {
  const DropDownTexts({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.commissioner(
          color: AppColors.blackClr, fontWeight: FontWeight.w700, fontSize: 18),
    );
  }
}
