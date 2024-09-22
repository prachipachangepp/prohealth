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