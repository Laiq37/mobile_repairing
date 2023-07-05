import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/constants/AppColors.dart';
import 'package:mobile_repairing/data/data.dart';
import 'package:mobile_repairing/routes/RoutesNames.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
           decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  // HexColor.fromHex("#9370DB"),
                  // HexColor.fromHex("#583EF2"),
                  Color(0xFF583EF2),
                  Color(0xff9D59FF),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.35, 0.82]),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28))),
          child: AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title:  const Text('Developers', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),),
          content:  Text('Areeb Uddin Shaikh\n'
                'Syed Junaid Hussain\n', 
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryClr),),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
          textStyle: Theme.of(context).textTheme.labelLarge,
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Ok', style: TextStyle(color: Colors.white, fontSize: 18),),
              onPressed: () {
          Navigator.of(context).pop();
              },
            ),
          ],
        ),
        );
 
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: AppColors.whiteClr,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          SizedBox(
            // decoration:
            // BoxDecoration(border: Border.all(color: AppColors.blackClr)),
            height: height * 0.26,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: height * 0.15,
                    child: Image.asset("assets/images/app_logo.png",
                        width: MediaQuery.of(context).size.width / 2.5)),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "Select Service",
                  style: GoogleFonts.commissioner(
                      color: AppColors.blackClr,
                      fontWeight: FontWeight.w700,
                      fontSize: 22),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Constants.drawerData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: GestureDetector(
                    onTap: () {
                      // print(index);
                      index == 5 ?
                      _dialogBuilder(context)
                      :
                      Get.offAndToNamed(Constants.drawerData[index]['screen']);
                    },
                    child: Card(
                      color: index == Constants.drawerData.length - 1
                          ? Colors.black
                          : index == Constants.drawerData.length - 2
                              ? 
                              Colors.yellow.shade800
                              :
                              index == Constants.drawerData.length - 3 ?
                              
                              Colors.teal.shade800
                              : AppColors.primaryClr,
                      child: ListTile(
                        leading: Icon(Constants.drawerData[index]['icon'],color: AppColors.whiteClr,),
                          title: Text(
                        Constants.drawerData[index]['name'].toString(),
                        style: GoogleFonts.commissioner(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.whiteClr),
                      )),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
