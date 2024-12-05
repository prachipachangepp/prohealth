import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';

class LinearCardWidget extends StatelessWidget {
  final String headingText;
  final String totalCount;
  final IconData icon;
  final int totalValue;
   LinearCardWidget({super.key, required this.headingText, required this.totalCount, required this.totalValue, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8,vertical: AppPadding.p2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(headingText,
                    style: CustomTextStylesCommon.commonStyle(
                      fontSize: FontSize.s16,
                      color: ColorManager.mediumgrey,
                      fontWeight: FontWeight.w500),),
                SizedBox(height: AppSize.s15,),
                  Text(totalCount,style: TextStyle(fontSize: FontSize.s20,color: ColorManager.blueprime,fontWeight: FontWeight.w700),)
                ],
              ),
              Icon(icon,color: ColorManager.bluebottom,size: IconSize.I40,)
            ],
          ),
          LinearProgressIndicator(
            backgroundColor: ColorManager.white,
            color: ColorManager.blueprime,
            value: totalValue/100,
          )
        ],
      ),
    );
  }
}
