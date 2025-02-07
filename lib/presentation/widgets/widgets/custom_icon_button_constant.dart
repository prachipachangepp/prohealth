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
  final double? height;
  final bool? enabled;

  const CustomIconButtonConst({
    this.text,
    this.icon,
    required this.onPressed,
    this.width,
    Key? key, this.enabled, this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: width ?? AppSize.s145,
          height: height ?? 32,
          // padding: EdgeInsets.symmetric(horizontal: AppPadding.p15, vertical: AppPadding.p5),
          decoration: BoxDecoration(
            color: ColorManager.blueprime,
            borderRadius: BorderRadius.circular(12),
          ),
          child:
          Padding(
            padding: EdgeInsets.only(left: AppPadding.p8,right: AppPadding.p15, top: AppPadding.p5,bottom: AppPadding.p5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              icon != null
                      ? Icon(icon!,
                      color: ColorManager.white, size: IconSize.I20)
                      : Offstage(),
                 SizedBox(width: 2,),
                 Text(
                    text!,
                    style: BlueButtonTextConst.customTextStyle(context)
                  ),
              ],
            ),
          )
        ),
      ),
    );
  }
}

