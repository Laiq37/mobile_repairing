import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/constants/AppColors.dart';

class CustomTitleBar extends StatelessWidget {
  final String title;
  const CustomTitleBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        alignment: Alignment.center,
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
        child: Text(
          title,
          style: GoogleFonts.commissioner(
              color: AppColors.whiteClr,
              fontWeight: FontWeight.w700,
              fontSize: 36),
        ));
  }
}

extension HexColor on Color {
  static fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', "");
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString';
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
