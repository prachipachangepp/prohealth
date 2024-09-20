import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';

///Tabbar with Blue BG
class BlueBgTabbar {
  static TextStyle customTextStyle(int selectedIndex, int currentIndex) {
    return TextStyle(
      fontSize: FontSize.s12,
      fontWeight: selectedIndex == currentIndex
          ? FontWeight.w700
          : FontWeight.w500,
      color: selectedIndex == currentIndex
          ? ColorManager.mediumgrey
          : ColorManager.white,
      decoration: TextDecoration.none,
    );
  }
}

///Tabbar with transparent BG
class TransparentBgTabbar {
  static TextStyle customTextStyle(int selectedIndex, int currentIndex) {
    return TextStyle(
      fontSize: FontSize.s12,
      fontWeight: selectedIndex == currentIndex
          ? FontWeight.w700
          : FontWeight.w500,
      color: selectedIndex == currentIndex
          ? ColorManager.blueprime
          : ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}

///listview table listview heading
class AllHRTableHeading {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s12,
      fontWeight: FontWeight.w500,
      color: ColorManager.white,
      decoration: TextDecoration.none,
    );
  }
}
///apply most of the places for each listview data
class DocumentTypeDataStyle {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: FontSize.s11,
      color: ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}

///details screen office name
class CompanyIdentityManageHeadings {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s15,
      color: ColorManager.black,
      fontWeight: FontWeight.w700,
    );
  }
}



///listview table data used for HR
class AllHRTableData {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s10,
      fontWeight: FontWeight.w500,
      color: ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}

///document defination
class DefineWorkWeekStyle {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s12,
      fontWeight: FontWeight.w700,
      color: ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}



// class RadioButtonHeadStyle {
//   static TextStyle customTextStyle(BuildContext context) {
//     return GoogleFonts.firaSans(
//       fontSize: FontSize.s12,
//       fontWeight: FontWeight.w700,
//       color: ColorManager.mediumgrey,
//       decoration: TextDecoration.none,
//     );
//   }
// }


///document definition
// class DocDefineTableData {
//   static TextStyle customTextStyle(BuildContext context) {
//     return GoogleFonts.firaSans(
//       fontWeight: FontWeight.w400,
//       fontSize: FontSize.s11,
//       color: ColorManager.mediumgrey,
//       decoration: TextDecoration.none,
//     );
//   }
// }

