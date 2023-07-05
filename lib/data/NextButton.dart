import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/constants/AppColors.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Next",
          style: GoogleFonts.commissioner(
              color: AppColors.whiteClr,
              fontWeight: FontWeight.w700,
              fontSize: 24),
        ),
      ),
      height: height * 0.06,
      decoration: BoxDecoration(
          color: AppColors.primaryClr, borderRadius: BorderRadius.circular(10)),
      width: width * 0.85,
    );
  }
}
