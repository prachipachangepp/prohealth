import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/font_manager.dart';

import 'color.dart';

/// listview table heading
class TableHeadingStyle{
  static const TextStyle firaSansWhite12Bold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}


class TableListTextStyle{
  static final TextStyle firaSansGray10Bold = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: Color(0xff686464),
  );
}


///done by saloni and prachi
class ThemeManager {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 140;
    return TextStyle(
      fontSize: fontSize,
      color: ColorManager.mediumgrey,
      fontWeight: FontWeight.w400,
    );
  }
}


///prajwal
class ThemeManagerBold {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 140;
    return TextStyle(
      fontSize: fontSize,
      //color: Color(0xFF686464),
      color: Colors.black,
      //fontWeight: FontWeight.w400,
      fontWeight: FontWeight.w400,
    );
  }
}



class ThemeManagerDark {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width/140;
    return TextStyle(
      fontSize: fontSize,
      color: ColorManager.black,
      fontWeight: FontWeight.w400,
    );
  }
}
class ThemeManagerDarkFont {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width/140;
    return TextStyle(
      fontSize: fontSize,
      color: ColorManager.black,
      fontWeight: FontWeight.w400,
    );
  }
}

class ThemeManagerLightblue {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 120;
    return TextStyle(
      fontSize: fontSize,
      color: Color(0xff2B647F),
      fontWeight: FontWeight.w600,
    );
  }
}

class ThemeManagerWhite {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 130;
    return TextStyle(
      fontSize: fontSize,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    );
  }
}

class ThemeManagerBlack {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 130;
    return TextStyle(
      fontSize: fontSize,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    );
  }
}

class ThemeManagerAccentblue {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 130;
    return TextStyle(
      fontSize: fontSize,
      color: Colors.blueAccent,
      fontWeight: FontWeight.w200,
    );
  }
}

class ThemeManagerblue {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 120;
    return TextStyle(
      fontSize: fontSize,
      color: Color(0xff2B647F),
      fontWeight: FontWeight.w600,
    );
  }
}

class ThemeManageWhitebold {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 99;
    return TextStyle(
      fontSize: fontSize,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    );
  }
}

class RegisterTableHead {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = 12;
    return TextStyle(
      fontSize: fontSize,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    );
  }
}

class AknowledgementStyleConst {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: 10,
      color: Color(0xFF000000),
      fontWeight: FontWeight.w400,
    );
  }
}

///profile bar
class ProfileBarConst {
  static TextStyle profileTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s10,
      color: ColorManager.primary,
      decoration: TextDecoration.underline,
      decorationColor: Colors.blueAccent,
    );
  }
}

class ProfileBarConstText {
  static TextStyle profileTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s10,
      color: ColorManager.mediumgrey,
      fontWeight: FontWeight.w600,
    );
  }
}

class ProfileBarLastColText {
  static TextStyle profileTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s10,
      color: ColorManager.bluelight,
      fontWeight: FontWeight.w600,
    );
  }
}

class ProfileBarClipText {
  static TextStyle profileTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width / 140,
      color: ColorManager.white,
      fontWeight: FontWeight.w600,
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
    return TextStyle(
      fontSize: fontSize ?? 15,
      color: color ?? Color(0xff4B89BA),
      fontWeight: fontWeight ?? FontWeight.w600,
    );
  }
}

///menu screen
class MenuScreenHeadStyle {
  static TextStyle menuHead(BuildContext context) {
    return TextStyle(
        color: ColorManager.darkgrey,
        fontSize: 14.0,
        fontWeight: FontWeight.w600);
  }
}



///Human Resource screen textField email only
class MobileMenuText {
  static TextStyle MenuTextConst(BuildContext context) {
    return TextStyle(
      color: ColorManager.mediumgrey,
      fontSize: FontSize.s12,
      fontWeight:FontWeight.w500,
    );
  }
}
