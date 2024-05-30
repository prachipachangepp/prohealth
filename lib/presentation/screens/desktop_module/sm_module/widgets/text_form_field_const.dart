import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/resources/font_manager.dart';

class SMTextFConst extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String text;
  final Color textColor;

   SMTextFConst({
     Key? key,
    required this.controller,
    required this.keyboardType,
     required this.text,
     this.textColor = const Color(0xff686464),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.firaSans(
            fontSize: FontSize.s12,
            fontWeight: FontWeight.w700,
            color: textColor,
            decoration: TextDecoration.none,
          ),
        ),
        Container(
          width: 354,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFB1B1B1), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: 15,left: 15),
            ),
            style: TextStyle(
              height: 1,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
