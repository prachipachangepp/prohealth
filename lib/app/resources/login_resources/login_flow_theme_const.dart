import 'package:flutter/widgets.dart';
import '../color.dart';
import '../font_manager.dart';
///all login flow head
class LoginFlowHeading {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: FontSize.s30,
      fontWeight: FontWeight.w700,
      color: ColorManager.mediumgrey,
      decoration: TextDecoration.none,
    );
  }
}

/// all login flow base text
class LoginFlowBase {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      color: ColorManager.bluebottom,
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none,
    );
  }
}

///bottom bar powered by
class LoginFlowBottomBar {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      color: ColorManager.black,
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none,
    );
  }
}

///login flow textFormField
class LoginFlowTextField {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      color: ColorManager.blackForLoginTexts,
      fontWeight: FontWeight.w500,
      fontSize: FontSize.s14,
      decoration: TextDecoration.none,
    );
  }
}

/// all login flow base text
/// offer later screen
class LoginFlowText {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      color: ColorManager.blueprime,
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none,
    );
  }
}

///error msg
class LoginFlowErrorMsg {
  static TextStyle customTextStyle(BuildContext context) {
    return TextStyle(
      color: ColorManager.red,
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none,
    );
  }
}

///email theme
class EmailTextStyle {
  static TextStyle enterEmail(BuildContext context) {
    return TextStyle(
      color: Color(0xff000000).withOpacity(0.3),
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w300,
    );
  }
}
///
class LoginFlowTheme {
  static TextStyle enterEmail(BuildContext context) {
    return TextStyle(
      color: ColorManager.darkgrey,
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w400,
    );
  }
}

/// having letter spacing
class LoginFlowLetterSpacing {
  static TextStyle enterEmail(BuildContext context, {bool applyLetterSpacing = true}) {
    return TextStyle(
      letterSpacing: applyLetterSpacing ? 0.5 : 0.0,
      color: ColorManager.mediumgrey,
      fontSize: FontSize.s10,
      fontWeight: FontWeight.w600,
    );
  }
}


///didnt receive code
class CodeVerficationText {
  static TextStyle VerifyCode(BuildContext context) {
    return TextStyle(
      color: ColorManager.darkgrey,
      // fontSize: FontSize.s10,
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w600,
    );
  }
}