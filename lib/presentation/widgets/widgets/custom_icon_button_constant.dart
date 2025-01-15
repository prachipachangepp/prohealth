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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      child: InkWell(
        onTap: onPressed,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: ColorManager.blueprime,
              borderRadius: BorderRadius.circular(12),
            ),
            child:
            Row(
              children: [
              icon != null
                      ? Icon(icon!,
                      color: ColorManager.white, size: AppSize.s20)
                      : Container(height: 20,),
                 SizedBox(width: 5,),
                 Text(
                    text!,
                    style: BlueButtonTextConst.customTextStyle(context)
                  ),
              ],
            )

            // ElevatedButton.icon(
            //   onPressed: onPressed,
            //
            //   // style: ElevatedButton.styleFrom(
            //   //   padding: EdgeInsets.symmetric(horizontal: AppSize.s10, vertical: AppSize.s10),
            //   //   backgroundColor: ColorManager.blueprime,
            //   //   shape: RoundedRectangleBorder(
            //   //     borderRadius: BorderRadius.circular(12),
            //   //   ),
            //   //   // elevation: 4,
            //   //   // shadowColor: ColorManager.black.withOpacity(0.4),
            //   // ),
            // ),
          ),
        ),
      ),
    );
  }
}

