import 'package:flutter/material.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';


class ProfileBarClipConst extends StatelessWidget {
  final String text;
  final String textOval;
  final Color containerColor;

  const ProfileBarClipConst({
    Key? key,
    required this.text,
    required this.containerColor,
    required this.textOval,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: ProfileBarLastColText.profileTextStyle(context),
        ),
        SizedBox(width: MediaQuery.of(context).size.width/160),
        ClipOval(
          child: Container(
            height: MediaQuery.of(context).size.height / 55,
            width: MediaQuery.of(context).size.width / 99,
            decoration: BoxDecoration(
              color: containerColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade600,
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Text(
              textOval,
              textAlign: TextAlign.center,
              style: ProfileBarClipText.profileTextStyle(context),
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileBarPhoneCmtConst extends StatelessWidget {
  const ProfileBarPhoneCmtConst({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Text(
          AppString.text,
          style: ThemeManagerDark.customTextStyle(context),
        ),
        SizedBox(
          width: AppSize.s15,
        ),
        Icon(
          Icons.phone,
          color: ColorManager.green,
          size: AppSize.s13,
        ),
        Icon(
          Icons.comment,
          color: ColorManager.blueprime,
          size: AppSize.s13,
        )
      ],
    );
  }
}

