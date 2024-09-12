import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';

///listview table data
class AllHRTableData {
  static TextStyle customTextStyle(BuildContext context) {
    return GoogleFonts.firaSans(
      fontSize: FontSize.s10,
      fontWeight: FontWeightManager.medium,
      color: ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}

///listview table heading
class AllHRTableHeading {
  static TextStyle customTextStyle(BuildContext context) {
    return GoogleFonts.firaSans(
      fontSize: FontSize.s12,
      fontWeight: FontWeightManager.bold,
      color: ColorManager.white,
      decoration: TextDecoration.none,
    );
  }
}

class CompanyIdentityManageHeadings {
  static TextStyle customTextStyle(BuildContext context) {
    return GoogleFonts.firaSans(
      fontSize: FontSize.s15,
      color: ColorManager.black,
      fontWeight: FontWeightManager.bold,
    );
  }
}
///document defination
class DocDefination {
  static TextStyle customTextStyle(BuildContext context) {
    return GoogleFonts.firaSans(
      fontSize: FontSize.s10,
      fontWeight: FontWeightManager.medium,
      color: ColorManager.mediumgrey,
    );
  }
}

class RadioButtonHeadStyle {
  static TextStyle customTextStyle(BuildContext context) {
    return GoogleFonts.firaSans(
      fontSize: FontSize.s12,
      fontWeight: FontWeight.w700,
      color: ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}

class DocumentTypeDataStyle {
  static TextStyle customTextStyle(BuildContext context) {
    return GoogleFonts.firaSans(
      fontWeight: FontWeightManager.medium,
      fontSize: FontSize.s12,
      color: ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}
///document definition
class DocDefineTableData {
  static TextStyle customTextStyle(BuildContext context) {
    return GoogleFonts.firaSans(
      fontWeight: FontWeightManager.bold,
      fontSize: FontSize.s10,
      color: ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}

