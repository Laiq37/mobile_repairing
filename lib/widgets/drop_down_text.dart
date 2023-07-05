import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/constants/AppColors.dart';

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