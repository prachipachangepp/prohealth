import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';

class CustomRow extends StatelessWidget {
  final IconData icon;
  final String text1;
  final String text2;

  const CustomRow({
    Key? key,
    required this.icon,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15,color: ColorManager.mediumgrey),
        SizedBox(width: MediaQuery.of(context).size.width/40),
        Text(
          text1,
          style: GoogleFonts.firaSans(fontSize: 10, fontWeight: FontWeight.w400,color: ColorManager.mediumgrey),
        ),
        SizedBox(width: MediaQuery.of(context).size.width/20),
        Text(
          text2,
          textAlign: TextAlign.start,
          style: GoogleFonts.firaSans(fontSize: 10, fontWeight: FontWeight.w400,color: ColorManager.mediumgrey),
        ),
      ],
    );
  }
}