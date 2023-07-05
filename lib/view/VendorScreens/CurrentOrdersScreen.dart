import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/constants/AppColors.dart';
import 'package:mobile_repairing/dartFunctions/auth_methods.dart';
import 'package:mobile_repairing/data/drawer.dart';
import 'package:mobile_repairing/routes/RoutesNames.dart';
import 'package:mobile_repairing/widgets/custom_title_bar.dart';
import 'package:mobile_repairing/widgets/loader.dart';

import '../../data/data.dart';

class CurrentOrdersScreen extends StatefulWidget {
  const CurrentOrdersScreen({super.key});

  @override
  State<CurrentOrdersScreen> createState() => _CurrentOrdersScreenState();
}

class _CurrentOrdersScreenState extends State<CurrentOrdersScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var type = Get.arguments;
  final List orders = [];
  bool isLoading = false;

  getOrders() async {
    setState(() {
      isLoading = true;
    });
    var orderData = await _firestore
        .collection("orders")
        .where('type', isEqualTo: type)
        .get();
    orders.clear();
    orders.addAll(orderData.docs);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders();
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
        actions: [
          IconButton(onPressed: (){
            AuthMethods().logout();
          }, icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: SizedBox(
        width: width,
        child: Column(
          children: [
            const CustomTitleBar(
              title: 'Orders',
            ),
            isLoading
                ? Padding(
                  padding: EdgeInsets.only(top:height*0.5),
                  child: const Loader(),
                )
                : Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      physics: BouncingScrollPhysics(),
                      itemCount: orders.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            var statusUpdated = await Get.toNamed(
                                RoutesNames.OrderStatusScreen,
                                arguments: {
                                  'id': orders[index].id,
                                  "status": orders[index]
                                      .data()["status"]
                                      .toLowerCase()
                                });
                            if (statusUpdated == null || !statusUpdated) return;
                            getOrders();
                          },
                          child: Container(
                              height: height * 0.1,
                              width: width * 0.85,
                              // color: AppColors.primaryClr,
                              decoration: BoxDecoration(
                                  // color: Colors.indigo.shade100,
                                  color: Colors.indigo.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  type == "network" ? "${orders[index].data()?["from"]} -> ${orders[index].data()?["to"]}": orders[index].data()?["model"],
                                  style: GoogleFonts.commissioner(
                                      color:
                                          AppColors.blackClr.withOpacity(0.7),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
