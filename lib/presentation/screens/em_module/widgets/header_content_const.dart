import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/value_manager.dart';

class HeaderContentConst extends StatelessWidget {
  final String heading;
  final Widget content;
  const HeaderContentConst(
      {super.key, required this.heading, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: GoogleFonts.firaSans(
              fontSize: FontSize.s12,
              fontWeight: FontWeight.w700,
              color: ColorManager.textPrimaryColor,
            ),
          ),
          SizedBox(height: AppSize.s5),

          /// upload  doc
          content,
        ],
      ),
    );
  }
}
