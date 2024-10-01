import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';


class ProfileBarClipConst extends StatelessWidget {
  final String text;
  final String textOval;
  final Color containerColor;
  final VoidCallback? onTap;

  const ProfileBarClipConst({
    Key? key,
    required this.text,
    required this.containerColor,
    required this.textOval, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Row(
        children: [
          Text(
            text,
            style: ProfileBarLastColText.profileTextStyle(context),
          ),
          SizedBox(width: 20),
          ClipOval(
            child: Container(
              height: 20,
              width: 21,
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
              child: Center(
                child: Text(
                  textOval,
                  textAlign: TextAlign.center,
                  style: ProfileBarClipText.profileTextStyle(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
///
class ProfileBarPhoneCmtConst extends StatelessWidget {
  final String? phoneNo;
  List<TextInputFormatter>? inputFormatters;

  ProfileBarPhoneCmtConst({super.key, required this.phoneNo});

  // Method to format the phone number
  String formatPhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return "---------------   ";
    }

    // Example of formatting (XXX) XXX-XXXX
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6, 10)}';
    } else {
      return phoneNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 13,
          width: 72,
          child: Text(
            formatPhoneNumber(phoneNo),
            style: ThemeManagerDark.customTextStyle(context),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Container(
          height: 12,
          width: 15,
          child: Icon(
            Icons.phone,
            color: ColorManager.green,
            size: 13,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          height: 12,
          width: 15,
          child: Icon(
            Icons.comment,
            color: ColorManager.blueprime,
            size: 13,
          ),
        )
      ],
    );
  }
}
