import 'package:flutter/material.dart';

import 'package:prohealth/app/resources/color.dart';

import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../app/resources/theme_manager.dart';

class CustomRow extends StatelessWidget {
  final IconData icon;
  final String text1;
  final String text2;

  const CustomRow({
    Key? key,
    required this.icon,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Icon(icon, size: 15,color: ColorManager.mediumgrey),
        ),
        SizedBox(width: MediaQuery.of(context).size.width/40),
        Text(
          text1,
          style:DocumentTypeDataStyle.customTextStyle(context)
        ),
        SizedBox(width: MediaQuery.of(context).size.width/20),
        Text(
          text2,
          textAlign: TextAlign.start,
            style:DocumentTypeDataStyle.customTextStyle(context)
        ),
      ],
    );
  }
}


class CustomRownew extends StatelessWidget {
  //final IconData icon;
  final String text1;
  final String text2;

  const CustomRownew({
    Key? key,
   // required this.icon,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(top: 5.0),
        //   child: Icon(icon, size: 15,color: ColorManager.mediumgrey),
        // ),
        // SizedBox(width: MediaQuery.of(context).size.width/40),
        Text(
            text1,
            style:DocumentTypeDataStyle.customTextStyle(context)
        ),
        SizedBox(width: MediaQuery.of(context).size.width/70),
        Flexible(
          child: Text(
              text2,
              textAlign: TextAlign.start,
              style:ThemeManagerDark.customTextStyle(context)
          ),
        ),
      ],
    );
  }
}


class CustomRowname extends StatelessWidget {
  //final IconData icon;
  final String text1;
  final String text2;

  const CustomRowname({
    Key? key,
    // required this.icon,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(top: 5.0),
        //   child: Icon(icon, size: 15,color: ColorManager.mediumgrey),
        // ),
        // SizedBox(width: MediaQuery.of(context).size.width/40),
        Text(
            text1,
            style: DefineWorkWeekStyle.customTextStyle(context),
        ),
        SizedBox(
          width: 5,
        ),
      //  SizedBox(width: MediaQuery.of(context).size.width/70),
        Text(
            text2,
            textAlign: TextAlign.start,
            style: DefineWorkWeekStyle.customTextStyle(context),
        ),
      ],
    );
  }
}