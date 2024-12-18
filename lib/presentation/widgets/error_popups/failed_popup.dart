import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';

import '../../../app/resources/font_manager.dart';

class FailedPopup extends StatelessWidget {
  final String text;
  const FailedPopup({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
        width: 450,
        height: 250,
        body: [
          Center(
            child: Icon(
              Icons.cancel,
              color: Colors.red, // Icon color
              size: 30,
            ),
          ),
          SizedBox(height: 5,),
          Text(text,
            textAlign: TextAlign.center,
            style: CustomTextStylesCommon.commonStyle(
            fontWeight: FontWeight.w600,
            fontSize: FontSize.s15,
            color: ColorManager.mediumgrey
          ),),

        ],
        bottomButtons: CustomElevatedButton(onPressed: (){
          Navigator.pop(context);
        },text: 'OK',height: 30,width: 90,), title: 'Error');
  }
}
