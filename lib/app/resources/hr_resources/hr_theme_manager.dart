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
      fontSize: FontSize.s18,
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
      fontWeight: FontWeight.w600,
      fontSize: FontSize.s12,
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
      fontSize: 13,
      color: Color(0xFF605F5F).withOpacity(0.50),
      decoration: TextDecoration.none,
    );
  }
}


class FileuploadString {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w500,
      color: ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}


///  Employment #1
class HeadingFormStyle {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s16,
      fontWeight: FontWeight.w700,
      color: ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}
/// hr dashboard
class TableHeadHRDashboard {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s14p,
      fontWeight: FontWeight.w700,
      color: ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}
class TableDataHRDashboard {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s15,
      fontWeight: FontWeight.w400,
      color: ColorManager.dashListviewData,
      decoration: TextDecoration.none,
    );
  }
}