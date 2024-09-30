import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/font_manager.dart';

import '../color.dart';

class OnboardFlowContainerHeading {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s13,
      color: ColorManager.blackfaint,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none,
    );
  }
}

class FormHeading{
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      color: ColorManager.blueprime,
      fontSize: FontSize.s16,
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.none,
    );
  }

}

///stepper name
class formNameText {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: ColorManager.grey,
      decoration: TextDecoration.none,
    );
  }
}

///form textfield and blue box
class onlyFormDataStyle {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: FontSize.s13,
      color: ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}



///ip address and
class onlyFormINineDataStyle {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 11,
      color: Color(0xFF605F5F).withOpacity(0.50),
      decoration: TextDecoration.none,
    );
  }
}




///