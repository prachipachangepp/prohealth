import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      children: [
        Icon(icon, size: 24),
        SizedBox(width: 8),
        Text(
          text1,
          style: GoogleFonts.firaSans(fontSize: 10, fontWeight: FontWeight.w400),
        ),
        SizedBox(width: 87),
        Text(
          text2,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}