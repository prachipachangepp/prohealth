// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/color.dart';
// import 'package:prohealth/app/resources/value_manager.dart';
// import '../../../../../app/resources/font_manager.dart';

import 'package:flutter/material.dart';

import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';

///saloni///
class SchedularIconButtonConst extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback onPressed;
  final double? width;

  const SchedularIconButtonConst({
    this.text,
    this.icon,
    required this.onPressed,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(


      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon != null
            ? Icon(icon!, color: ColorManager.white, size: AppSize.s20)
            : SizedBox.shrink(),
        label: Text(
          text!,
          style: TextStyle(
            fontSize: AppSize.s12,
            fontWeight: FontWeight.w500,
            color: ColorManager.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.s10, vertical: AppSize.s10),
          backgroundColor: ColorManager.blueprime,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          shadowColor: ColorManager.black.withOpacity(0.4),
        ),
      ),
    );
  }
}

