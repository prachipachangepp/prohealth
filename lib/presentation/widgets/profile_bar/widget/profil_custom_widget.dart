import 'package:flutter/material.dart';
import '../../../../resources/theme_manager.dart';


///saloni
class MyConstants {
  static List<Widget> personalInfoTexts(BuildContext context) {
    final textStyle = ThemeManagerDark.customTextStyle(context);
    return [
      Text(
        "Age",
        style: textStyle,
      ),
      Text(
        "Gender",
        style: textStyle,
      ),
      Text(
        "Social Security No.",
        style: textStyle,
      ),
      Text(
        "Phone No.",
        style: textStyle,
      ),
      Text(
        "Personal No.",
        style: textStyle,
      ),
      Text(
        "Work No.",
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
      "Personal Email",
      style: textStyle
    ),
      Text(
        "Work Email",
        style: textStyle,
      ),
      Text(
        "Zone",
        style: textStyle,
      ),
      Text(
        "Speciality ",
        style: textStyle,
      ),
      Text(
        "Service",
        style: textStyle,
      ),
      Text(
        "Work No.",
        style: textStyle,
      ),];
  }
}
