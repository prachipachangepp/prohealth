import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';

class CompanyIdentityManageHeadings {
  static TextStyle customTextStyle(BuildContext context) {
    return GoogleFonts.firaSans(
      fontSize: 12,
      color: ColorManager.black,
      fontWeight: FontWeightManager.semiBold,
    );
  }
}
