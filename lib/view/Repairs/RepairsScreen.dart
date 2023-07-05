import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/constants/AppColors.dart';
import 'package:mobile_repairing/data/data.dart';
import 'package:mobile_repairing/data/drawer.dart';
import 'package:mobile_repairing/routes/RoutesNames.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_repairing/widgets/custom_title_bar.dart';

import '../../data/NextButton.dart';

class RepairScreen extends StatefulWidget {
  const RepairScreen({super.key});

  @override
  State<RepairScreen> createState() => _RepairScreenState();
}

class _RepairScreenState extends State<RepairScreen> {
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
                title: 'Mobile Repairs',
              ),
              Expanded(
                child: FutureBuilder<QuerySnapshot>(
  future: FirebaseFirestore.instance.collection('repairs').get(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFF583EF2)));
    }
    final List<DocumentSnapshot> documents = snapshot.data!.docs;
    return ListView.builder(
      padding: EdgeInsets.only(top: height*0.06),
      physics: BouncingScrollPhysics(),
      itemCount: documents.length,
      itemBuilder: (BuildContext context, int index) {
        final DocumentSnapshot document = documents[index];
        final String id = document.id;
        final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30, vertical: 10),
          child: GestureDetector(
            onTap: ()=>Get.offAndToNamed(RoutesNames.RepairGridScreen, arguments: document.id),
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.indigo.shade100,
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(10)),
              height: height * 0.1,
              width: width * 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: height * 0.1,
                      width: width * 0.15,
                      child: index < 11 ?
                      Image.asset(repairs_logo[index])
                      :
                       null),
                  Text(
                    id,
                    style: GoogleFonts.commissioner(
                      color: AppColors.blackClr.withOpacity(0.7),
                      fontWeight: FontWeight.w700,
                      fontSize: 22),
                  ),
                  SizedBox(
                    width: width * 0.2,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  },
),

              ),
      
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Get.offAndToNamed(RoutesNames.RepairGridScreen);
                },
                child: NextButton(
                  height: height,
                  width: width,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
