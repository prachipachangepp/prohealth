import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';

import '../../../app/resources/theme_manager.dart';

class FourNotFourPopup extends StatelessWidget {
  const FourNotFourPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
        width: 550, height: 450,
        body: [
          Padding(padding: EdgeInsets.symmetric(vertical: 0,horizontal: 50),
          child: Center(
            child: Column(children: [
              Text('Whoops, that page is gone.',
              style: CustomTextStylesCommon.commonStyle(fontSize: 20,
                  color: ColorManager.mediumgrey,fontWeight: FontWeight.w600),),
              SizedBox(height: 20,),
              Container(
                  height: 250,
                  width: 350,
                  child: Image.asset('images/error/pana.png',fit: BoxFit.contain))
            ],),
          ),)
      ], bottomButtons: Container(), title: 'Error');
  }
}
