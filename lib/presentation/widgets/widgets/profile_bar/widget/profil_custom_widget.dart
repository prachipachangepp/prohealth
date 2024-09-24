import 'package:flutter/material.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/profile_bar.dart';

import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/theme_manager.dart';

///saloni
class MyConstants {
  static List<Widget> personalInfoTexts(BuildContext context) {
    final textStyle = ThemeManager.customTextStyle(context);
    return [
      Text(
        AppString.age,
          style: ProfileBarTextBoldStyle.customEditTextStyle()
      ),
      SizedBox(height: 1,),
      Text(
        AppString.gender,
          style: ProfileBarTextBoldStyle.customEditTextStyle()
      ),
      SizedBox(height: 1,),
      Text(
        AppString.ssn,
          style: ProfileBarTextBoldStyle.customEditTextStyle()
      ),
      SizedBox(height: 1,),
      Text(
        AppString.phone,
          style: ProfileBarTextBoldStyle.customEditTextStyle()
      ),
      SizedBox(height: 1,),
      Text(
        AppString.personalno,
          style: ProfileBarTextBoldStyle.customEditTextStyle()
      ),
      SizedBox(height: 1,),
      Text(
        AppString.workno,
          style: ProfileBarTextBoldStyle.customEditTextStyle()
      ),
    ];
  }
}

class MyConstantsColumn {
  static List<Widget> personalInfoTexts(BuildContext context) {
    final textStyle = ThemeManager.customTextStyle(context);
    return [
      Text(
          AppString.personalEmail,
      style: ProfileBarTextBoldStyle.customEditTextStyle()
    ),
      SizedBox(height: 1,),
      Text(
        AppString.workemail,
          style: ProfileBarTextBoldStyle.customEditTextStyle()
      ),
      SizedBox(height: 1,),
      Text(
        AppString.zonee,
          style: ProfileBarTextBoldStyle.customEditTextStyle()
      ),
      // SizedBox(height: 1,),
      Text(
        AppString.speciality,
          style: ProfileBarTextBoldStyle.customEditTextStyle()
      ),
      SizedBox(height: 1,),
      Text(
        AppString.service,
          style: ProfileBarTextBoldStyle.customEditTextStyle()
      ),
      SizedBox(height: 1,),
      Text(
        AppString.reportingOffice,
          style: ProfileBarTextBoldStyle.customEditTextStyle()
      ),
      SizedBox(height: 1,),
      Text(
        AppString.summary,
          style: ProfileBarTextBoldStyle.customEditTextStyle()
      ),];
  }
}
