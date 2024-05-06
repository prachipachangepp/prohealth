import 'package:flutter/material.dart';
import '../../../../app/resources/const_string.dart';
import '../../../../app/resources/theme_manager.dart';

///saloni
class MyConstants {
  static List<Widget> personalInfoTexts(BuildContext context) {
    final textStyle = ThemeManagerDark.customTextStyle(context);
    return [
      Text(
        AppString.age,
        style: textStyle,
      ),
      Text(
        AppString.gender,
        style: textStyle,
      ),
      Text(
        AppString.ssn,
        style: textStyle,
      ),
      Text(
        AppString.phone,
        style: textStyle,
      ),
      Text(
        AppString.personalno,
        style: textStyle,
      ),
      Text(
        AppString.workno,
        style: textStyle,
      ),
    ];
  }
}

class MyConstantsColumn {
  static List<Widget> personalInfoTexts(BuildContext context) {
    final textStyle = ThemeManagerDark.customTextStyle(context);
    return [
      Text(
          AppString.personalEmail,
      style: textStyle
    ),
      Text(
        AppString.workemail,
        style: textStyle,
      ),
      Text(
        AppString.zone,
        style: textStyle,
      ),
      Text(
        AppString.speciality,
        style: textStyle,
      ),
      Text(
        AppString.service,
        style: textStyle,
      ),
      Text(
        AppString.workno,
        style: textStyle,
      ),];
  }
}
