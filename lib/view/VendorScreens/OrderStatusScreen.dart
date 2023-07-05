import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/widgets/custom_title_bar.dart';
import 'package:mobile_repairing/widgets/loader.dart';

import '../../constants/AppColors.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  // final controller = Get.put(OrderStatusController());
  final notesController = TextEditingController();
  var lastStatus = Get.arguments["status"];
  var selectedStatus = Get.arguments["status"];
  var orderId = Get.arguments["id"];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;
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
              title: 'Order Detail',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      radioButtons(),
                      SizedBox(
                        height: height * 0.07,
                      ),
                      // Notes(height: height, width: width),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
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
                                horizontal: 8, vertical: 10),
                            child: TextFormField(
                              maxLines: 5,
                              controller: notesController,
                              // focusNode: NotesFocusNode,
                              cursorColor: AppColors.blackClr,
                              // onFieldSubmitted: (value) {
                              //   utils.fieldChange(context, emailFocusNode, passwordFocusNode);
                              // },
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
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
                        ],
                      ),
                    ],
                  ),
                )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () async {
                  if (selectedStatus == lastStatus) return;
                  setState(() {
                  isLoading = true;
                  });
                  String msg = "Status has been updated!";
                  try {
                    await _firestore
                        .collection("orders")
                        .doc(orderId)
                        .update({'status': selectedStatus});
                    Get.back(result:true);
                  } catch (err) {
                    msg = "Failed to update order Status";
                  }
                  finally{
                    if(mounted){
                      setState(() {
                        isLoading = false;
                      });
                    }
                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                        content: Text(msg)));
                  }
                },
                child: isLoading ? const Loader():  SaveButton(height: height, width: width),),
                const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget radioButtons() {
    return Column(
      children: [
        if(selectedStatus == "pending")
        customRadioButton(
          "pending",
        ),
        customRadioButton(
          "Approval Request",
        ),
        customRadioButton(
          "Recieved",
        ),
        customRadioButton(
          "Sent",
        ),
        customRadioButton(
          "Shipped",
        ),
      ],
    );
  }

  Widget customRadioButton(String status) {
    return Row(
      children: [
        Radio(
            activeColor: AppColors.primaryClr,
            value: status.toLowerCase(),
            groupValue: selectedStatus,
            onChanged: (status) {
              setState(() {
                selectedStatus = status!;
              });
            }),
        const SizedBox(
          width: 10,
        ),
        Text(
          status,
          style: GoogleFonts.commissioner(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.06,
      decoration: BoxDecoration(
          color: AppColors.primaryClr, borderRadius: BorderRadius.circular(10)),
      width: width * 0.85,
      child: Center(
        child: Text(
          "Save",
          style: GoogleFonts.commissioner(
              color: AppColors.whiteClr,
              fontWeight: FontWeight.w700,
              fontSize: 18),
        ),
      ),
    );
  }
}
