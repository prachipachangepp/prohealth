import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../app/resources/theme_manager.dart';

class BottomsheetPopup extends StatelessWidget {
  const BottomsheetPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
        width: AppSize.s450,
        height: AppSize.s330,
        body: [
          Column(
            children: [

              Row(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  Container(
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        "About to Expire",
                        style: TextStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeight.w500,
                          color:  ColorManager.bluebottom,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),

                  Container(width:150,
                    decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),),
                      child: Divider(color: ColorManager.bluebottom,height: 4,thickness: 4,)),
                ],),
                SizedBox(width: 20,),
                Column(children: [
                  Container(
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        "Expire",
                        style: TextStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeight.w500,
                          color:  ColorManager.bluebottom,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                  Container(width:150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),),
                      child: Divider(color: ColorManager.bluebottom,height: 4,thickness: 4,)),
                ],),
              ],),
              ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 50),
                      child: Container(
                       // color: Colors.purple,
                       height: 130,
                        // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        'Birth Certificate',
                                        style: CustomTextStylesCommon.commonStyle(
                                            color: ColorManager.mediumgrey,
                                            fontSize: FontSize.s12,
                                            fontWeight: FontWeight.w500)),
                                    Text(
                                      'Driving License',
                                      style: CustomTextStylesCommon.commonStyle(
                                          color: ColorManager.mediumgrey,
                                          fontSize: FontSize.s12,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    )),
              )
            ],
          )
        ],
        bottomButtons: Offstage(),
        title: "Documents");
  }
}
