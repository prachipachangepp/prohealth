import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';

class CustomRadioListTile extends StatelessWidget {
  final String value;
  final String groupValue;
  final ValueChanged onChanged;
  final String title;

  const CustomRadioListTile({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      title: Text(title,style: GoogleFonts.firaSans(
        fontSize: FontSize.s10,
        fontWeight: FontWeightManager.medium,
        color: ColorManager.mediumgrey,
        decoration: TextDecoration.none,
      ),),
    );
  }
}