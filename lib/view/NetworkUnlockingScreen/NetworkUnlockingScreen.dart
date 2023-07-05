import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/constants/AppColors.dart';
import 'package:mobile_repairing/data/data.dart';
import 'package:mobile_repairing/data/drawer.dart';
import 'package:mobile_repairing/routes/RoutesNames.dart';
import 'package:mobile_repairing/widgets/custom_title_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class NetworkUnlockingScreen extends StatefulWidget {
  const NetworkUnlockingScreen({super.key});

  @override
  State<NetworkUnlockingScreen> createState() => _NetworkUnlockingScreenState();
}

class _NetworkUnlockingScreenState extends State<NetworkUnlockingScreen> {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomTitleBar(
              title: 'Network Unlocking',
            ),
            SizedBox(
              height: height * 0.06,
            ),
            Text(
              "Select Your Current Service",
              style: GoogleFonts.commissioner(
                  color: AppColors.blackClr.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Expanded(
                child: FutureBuilder<QuerySnapshot>(
    future: FirebaseFirestore.instance.collection('services').get(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF583EF2)));
        }
        final List<DocumentSnapshot> documents = snapshot.data!.docs;
        return ListView.builder(
            padding: EdgeInsets.only(top: height*0.03),
            physics: BouncingScrollPhysics(),
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
                final DocumentSnapshot document = documents[index];
                final String service = document.id;
                return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: GestureDetector(
                        onTap: ()=>Get.offAndToNamed(RoutesNames.FromToScreen, arguments: {"service":service, "services": documents}),
                        child: Container(
                            decoration: BoxDecoration(
                                // color: Colors.indigo.shade100,
                                color: Colors.indigo.shade100,
                                borderRadius: BorderRadius.circular(10)),
                            height: height * 0.1,
                            width: width * 0.85,
                            child: Row(
                                children: [
                                  
                        const SizedBox(width: 50,),
                                    SizedBox(
                      height: height * 0.1,
                      width: width * 0.15,
                      child: index < 8 ?
                      Image.asset(network_unlocking_logo[index])
                      :
                       null),
                        SizedBox(width: 20,),
                                    Text(
                                        service,
                                        style: GoogleFonts.commissioner(
                                            color:
                                            AppColors.blackClr.withOpacity(0.7),
                                            fontWeight: FontWeight.w700,
                                            fontSize: index == 2 ? 20: 22),
                                    ),
                                ],
                            ),
                        ),
                    ),
                );
            },
        );
    },
)

              ),
          ],
        ),
      ),
    );
  }
}
