import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/font_manager.dart';

import 'color.dart';

/// listview table heading
class TableHeadingStyle{
  static const TextStyle firaSansWhite12Bold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontFamily: 'FiraSans',
  );
}


class TableListTextStyle{
  static final TextStyle firaSansGray10Bold = GoogleFonts.firaSans(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: Color(0xff686464),
  );
}





















///done by saloni and prachi
class ThemeManager {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 140;
    return GoogleFonts.firaSans(
      fontSize: fontSize,
      color: Color(0xFF686464),
      fontWeight: FontWeight.w400,
    );
  }
}

class ThemeManagerDark {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width/140;
    return GoogleFonts.firaSans(
      fontSize: fontSize,
      color: Color(0xFF2A2827),
      fontWeight: FontWeight.w600,
    );
  }
}

class ThemeManagerLightblue {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 120;
    return GoogleFonts.firaSans(
      fontSize: fontSize,
      color: Color(0xff2B647F),
      fontWeight: FontWeightManager.semiBold,
    );
  }
}

class ThemeManagerWhite {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 130;
    return GoogleFonts.firaSans(
      fontSize: fontSize,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }
}

class ThemeManagerBlack {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 130;
    return GoogleFonts.firaSans(
      fontSize: fontSize,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
  }
}

class ThemeManagerAccentblue {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 130;
    return GoogleFonts.firaSans(
      fontSize: fontSize,
      color: Colors.blueAccent,
      fontWeight: FontWeight.w200,
    );
  }
}

class ThemeManagerblue {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 120;
    return GoogleFonts.firaSans(
      fontSize: fontSize,
      color: Color(0xff2B647F),
      fontWeight: FontWeight.w700,
    );
  }
}

class ThemeManageWhitebold {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 99;
    return GoogleFonts.firaSans(
      fontSize: fontSize,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }
}

class RegisterTableHead {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = 12;
    return GoogleFonts.firaSans(
      fontSize: fontSize,
      color: Colors.white,
      fontWeight: FontWeight.w700,
    );
  }
}

class AknowledgementStyleConst {
  static TextStyle customTextStyle(BuildContext context) {
    return GoogleFonts.firaSans(
      fontSize: 10,
      color: Color(0xFF000000),
      fontWeight: FontWeight.w500,
    );
  }
}

///profile bar
class ProfileBarConst {
  static TextStyle profileTextStyle(BuildContext context) {
    return GoogleFonts.firaSans(
      fontSize: FontSize.s8,
      color: ColorManager.primary,
      decoration: TextDecoration.underline,
      decorationColor: Colors.blueAccent,
    );
  }
}

class ProfileBarConstText {
  static TextStyle profileTextStyle(BuildContext context) {
    return GoogleFonts.firaSans(
      fontSize: FontSize.s10,
      color: ColorManager.mediumgrey,
      fontWeight: FontWeightManager.semiBold,
    );
  }
}

class ProfileBarLastColText {
  static TextStyle profileTextStyle(BuildContext context) {
    return GoogleFonts.firaSans(
      fontSize: FontSize.s10,
      color: ColorManager.bluelight,
      fontWeight: FontWeightManager.semiBold,
    );
  }
}

class ProfileBarClipText {
  static TextStyle profileTextStyle(BuildContext context) {
    return GoogleFonts.firaSans(
      fontSize: MediaQuery.of(context).size.width / 140,
      color: ColorManager.white,
      fontWeight: FontWeightManager.semiBold,
    );
  }
}

///common theme
class CustomTextStylesCommon {
  static TextStyle commonStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return GoogleFonts.firaSans(
      fontSize: fontSize ?? 15,
      color: color ?? Color(0xff4B89BA),
      fontWeight: fontWeight ?? FontWeight.bold,
    );
  }
}

///menu screen
class MenuScreenHeadStyle {
  static TextStyle menuHead(BuildContext context) {
    return GoogleFonts.firaSans(
        color: ColorManager.darkgrey,
        fontSize: 14.0,
        fontWeight: FontWeightManager.bold);
  }
}

///email theme
class EmailTextStyle {
  static TextStyle enterEmail(BuildContext context) {
    return GoogleFonts.firaSans(
      color: Color(0xff000000).withOpacity(0.3),
      fontSize: FontSize.s14,
      fontWeight: FontWeightManager.lightbold,
    );
  }
}

///didnt receive code
class CodeVerficationText {
  static TextStyle VerifyCode(BuildContext context) {
    return GoogleFonts.firaSans(
      color: ColorManager.darkgrey,
      //fontSize: FontSize.s10,
      fontSize: MediaQuery.of(context).size.width / 120,
      fontWeight: FontWeightManager.semiBold,
    );
  }
}

///mobile menu screen text head
class MobileMenuText {
  static TextStyle MenuTextConst(BuildContext context) {
    return GoogleFonts.firaSans(
      color: ColorManager.mediumgrey,
      fontSize: FontSize.s12,
      fontWeight: FontWeightManager.semiBold,
    );
  }
}
