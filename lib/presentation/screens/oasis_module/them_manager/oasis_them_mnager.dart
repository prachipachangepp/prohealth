
import 'package:flutter/material.dart';
import '../../../../app/resources/color.dart';
import '../../../../app/resources/font_manager.dart';


class Normalfontstyle {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w500,
      color: ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}




class BoldfontStyle {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w600,
      color: ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}


class checkboxStyle {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: FontSize.s13,
      color: ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}



class BluebuttonStyle {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w600,
      color: ColorManager.white,
      decoration: TextDecoration.none,
    );
  }
}


class Blackfontstyle{
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w600,
      color: ColorManager.black,
      decoration: TextDecoration.none,
    );
  }
}


class Redfontstyle{
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w600,
      color: ColorManager.EMbrightred,
      decoration: TextDecoration.none,
    );
  }
}