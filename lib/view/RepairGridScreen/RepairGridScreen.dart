import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/constants/AppColors.dart';
import 'package:mobile_repairing/data/NextButton.dart';
import 'package:mobile_repairing/data/data.dart';
import 'package:mobile_repairing/routes/RoutesNames.dart';
import 'package:mobile_repairing/widgets/custom_dropdown.dart';
import 'package:mobile_repairing/widgets/custom_title_bar.dart';
import 'package:mobile_repairing/widgets/loader.dart';

class RepairGridScreen extends StatefulWidget {
  const RepairGridScreen({super.key});

  @override
  State<RepairGridScreen> createState() => _RepairGridScreenState();
}

class _RepairGridScreenState extends State<RepairGridScreen> {
  var brand = Get.arguments;
  bool isLoading = true;
  String selectedModel = 'select model';
  List<String> models = [];
  Map selectedRepairs = {};
  dynamic data;
  Map prices = {};

  Future getModels() async {
    try {
      data = await FirebaseFirestore.instance
          .collection('repairs')
          .doc(brand)
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
      prices = data.data()[selectedModel];
      setState(() {});
    } catch (e) {
      print(e);
    }
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
              title: 'Mobile Repair',
            ),
            Expanded(
                child: isLoading
                    ? const Loader()
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.03,
                            ),
                            CustomDropDown(
                                items: models,
                                dropDownTitle: 'Model',
                                hint: 'select Model',
                                selectedItem: selectedModel,
                                onChanged: onModelChanged),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: gridItems.length%3==1 ? gridItems.length-1 : gridItems.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisExtent: 115,
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if(selectedModel == 'select model'){
                                          ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(const SnackBar(content: Text("Please select model")));
                                          return;
                                        }
                                        if (selectedRepairs.containsKey(gridItems[index]['function'])) {
                                          selectedRepairs.remove(gridItems[index]['function']);
                                        } else {
                                          selectedRepairs.addAll({gridItems[index]['function']:prices[gridItems[index]['function']]??98});
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        // height: height * 0.11,
                                        // width: width * 0.25,
                                        decoration: BoxDecoration(
                                          border: selectedRepairs.containsKey(gridItems[index]["function"])
                                              ? Border.all(
                                                  color: AppColors.primaryClr,
                                                  width: 2,
                                                )
                                              : null,
                                          color: Colors.indigo.shade100,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  '${prices[gridItems[index]['function']]?? 98}\$'
                                                      .toString(),
                                                  style:
                                                      GoogleFonts.commissioner(
                                                          color: AppColors
                                                              .blackClr,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 14),
                                                ),
                                                Image.asset(
                                                  height:50,
                                                  gridItems[index]['icon']!),
                                                Text(
                                                  gridItems[index]['function']
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      GoogleFonts.commissioner(
                                                          color: AppColors
                                                              .blackClr,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                ),
                                              ].reversed.toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            if(gridItems.length%3==1)
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  if(selectedModel == 'select model'){
                                          ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(const SnackBar(content: Text("Please select model")));
                                          return;
                                        }
                                        if (selectedRepairs.containsKey(gridItems.last['function'])) {
                                          selectedRepairs.remove(gridItems.last['function']);
                                        } else {
                                          selectedRepairs.addAll({gridItems.last['function']:prices[gridItems.last['function']]??98});
                                        }
                                        setState(() {});
                                      },
                                child: Container(
                                  height: 115,
                                  width: width * 0.5,
                                  decoration: BoxDecoration(
                                    border: selectedRepairs.containsKey(
                                      gridItems.last["function"]
                                    )
                                        ? Border.all(
                                            color: AppColors.primaryClr,
                                            width: 2,
                                          )
                                        : null,
                                    color: Colors.indigo.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          '${prices[gridItems.last['function']]?? 98}\$',
                                          style: GoogleFonts.commissioner(
                                              color: AppColors.blackClr,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14),
                                        ),
                                        Image.asset(
                                          height:50,
                                          gridItems.last['icon']!,
                                        ),
                                        Text(
                                                  gridItems.last['function']
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      GoogleFonts.commissioner(
                                                          color: AppColors
                                                              .blackClr,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                ),
                                      ].reversed.toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),

            // SizedBox(
            //   height: height * 0.05,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    if (selectedModel == "select model") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please select a model")));
                      return;
                    }
                    if (selectedRepairs.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text("Please select what needs to be fixed!")));
                      return;
                    }
                    var prices = selectedRepairs.values.toList();
                    var amount = 0.0;
                    for(var price in prices){
                      amount += price;
                    }
                    Get.offAndToNamed(RoutesNames.SummaryScreen, arguments: {
                      "type": "repair",
                      "brand": brand,
                      "model": selectedModel,
                      "itemToRepair": selectedRepairs,
                      "amount":amount,
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
}
