import 'package:flutter/material.dart';

class ThemeManager {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 150;
    return TextStyle(
      fontFamily: 'FiraSans',
      fontSize: fontSize,
      color: Color(0xFF686464),
      fontWeight: FontWeight.w400,
    );
  }
}

class ThemeManagerDark {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 150;
    return TextStyle(
      fontFamily: 'FiraSans',
      fontSize: fontSize,
      color: Color(0xFF2A2827),
      fontWeight: FontWeight.w400,
    );
  }
}

class ThemeManagerLightblue {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 99;
    return TextStyle(
      fontFamily: 'FiraSans',
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
      fontFamily: 'FiraSans',
      fontSize: fontSize,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }
}

class ThemeManagerBlack {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 130;
    return TextStyle(
      fontFamily: 'FiraSans',
      fontSize: fontSize,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
  }
}

class ThemeManagerAccentblue {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 130;
    return TextStyle(
      fontFamily: 'FiraSans',
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
      fontFamily: 'FiraSans',
      fontSize: fontSize,
      color: Color(0xff2B647F),
      fontWeight: FontWeight.w700,
    );
  }
}

class ThemeManageWhitebold {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 99;
    return TextStyle(
      fontFamily: 'FiraSans',
      fontSize: fontSize,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }
}

class RegisterTableHead {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width / 99;
    return TextStyle(
      fontFamily: 'FiraSans',
      fontSize: fontSize,
      color: Colors.white,
      fontWeight: FontWeight.w700,
    );
  }
}
