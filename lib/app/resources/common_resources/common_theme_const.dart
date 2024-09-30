import 'package:flutter/material.dart';
import '../color.dart';
import '../font_manager.dart';
///AppBar custom buttons
class AppbarCustomDropdownStyle {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w700,
      color: ColorManager.textPrimaryColor,
      decoration: TextDecoration.none,
    );
  }
}

///AppBar custom buttons
class AppbarCustomDropdownSubItem {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w400,
      color: ColorManager.textPrimaryColor,
      decoration: TextDecoration.none,
    );
  }
}

///common const text form field
class ConstTextFieldStyles {
  static TextStyle customTextStyle({required Color textColor}) {
    return TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w700,
      color: textColor,
      decoration: TextDecoration.none,
    );
  }
}

class ConstTextFieldRegister {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w500,
      color: ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}

///all PopupBlue BarText
class PopupBlueBarText {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s15,
      fontWeight: FontWeight.w700,
      color: ColorManager.white,
      decoration: TextDecoration.none,
    );
  }
}

///all Popupgray BarText
class DropdownItemStyle {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w500,
      color: ColorManager.greylight,
      decoration: TextDecoration.none,
    );
  }
}

///all button Text
class BlueButtonTextConst {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w600,
      color: ColorManager.white,
      decoration: TextDecoration.none,
    );
  }
}

///all transparentButton  and pick location text
class TransparentButtonTextConst {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w600,
      color: ColorManager.blueprime,
      decoration: TextDecoration.none,
    );
  }
}

// ///all iconbutton
// class IconButtonTextConst {
//   static TextStyle customTextStyle(BuildContext context) {
//     return TextStyle(
//       fontSize: FontSize.s12,
//       fontWeight: FontWeight.w600,
//       color: ColorManager.white,
//       decoration: TextDecoration.none,
//     );
//   }
// }

///all popu heading
class AllPopupHeadings {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w700,
      color: ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}

///all menu container heading
class MenuContainerTextStylling {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w600,
      color: ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}

///all no data msg
class AllNoDataAvailable {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w500,
      color: ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}

///error msg
class CommonErrorMsg {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      color: ColorManager.red,
      fontSize: FontSize.s10,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none,
    );
  }
}
///popup text const
class PopupTextConst {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      color: ColorManager.mediumgrey,
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none,
    );
  }
}

