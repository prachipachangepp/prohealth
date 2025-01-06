import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';

class TextInkwellButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
   TextInkwellButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: ColorManager.white,
      splashColor: ColorManager.white,
      onTap: onTap,
      child: Text(text,style: TextStyle(
        fontFamily: 'FiraSans',
        fontWeight: FontWeight.w700,
        fontSize: FontSize.s12,
        color: ColorManager.blueprime,
      ),),
    );
  }
}
