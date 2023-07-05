import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/AppColors.dart';

class ServiceContainers extends StatelessWidget {
  const ServiceContainers(
      {super.key,
      required this.height,
      required this.color,
      required this.width,
      required this.text,
      required this.icon});

  final double height;
  final double width;
  final String text;
  final Icon icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.1,
      width: width * 0.85,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.2,
          ),
          icon,
          SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: GoogleFonts.commissioner(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.whiteClr),
          )
        ],
      ),
    );
  }
}
