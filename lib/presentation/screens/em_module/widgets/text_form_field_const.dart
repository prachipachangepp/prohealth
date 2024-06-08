import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/theme_manager.dart';

import '../../../../../app/resources/font_manager.dart';

class SMTextFConst extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String text;
  final Color textColor;
  final Icon? icon;
  final VoidCallback? onChange;

   SMTextFConst({
     Key? key,
    required this.controller,
    required this.keyboardType,
     required this.text,
     this.textColor = const Color(0xff686464), this.icon,  this.onChange,
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

            autofocus: true,
            controller: controller,
            keyboardType: keyboardType,
            cursorHeight: 17,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              suffixIcon: icon,
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: 18,left: 15),
            ),
            style: CustomTextStylesCommon.commonStyle(
              fontWeight: FontWeightManager.medium,
              fontSize: FontSize.s12,
              color: ColorManager.mediumgrey
            ),
            onTap: onChange,
          ),
        ),
      ],
    );
  }
}
