import 'package:flutter/material.dart';

import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import '../../../../app/resources/font_manager.dart';

///saloni///
class CustomIconButtonConst extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback onPressed;
  final double? width;
  final bool? enabled;

  const CustomIconButtonConst({
    this.text,
    this.icon,
    required this.onPressed,
    this.width,
    Key? key, this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width / 15, //11
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon != null
            ? Icon(icon!, color: ColorManager.white, size: AppSize.s20)
            : Offstage(),
        label: Text(
          text!,
          style: BlueButtonTextConst.customTextStyle(context)
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: AppSize.s10, vertical: AppSize.s10),
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

