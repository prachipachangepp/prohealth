import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import '../../../app/resources/color.dart';
import '../../../app/resources/font_manager.dart';

class MobMenuScreenConst extends StatelessWidget {
  final String text;
  final ImageProvider imageProvider;
  const MobMenuScreenConst(
      {super.key, required this.text, required this.imageProvider});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.all(Radius.circular(11.2)),
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height / 10,
          width: MediaQuery.of(context).size.width / 2.7,
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12,),
          decoration:  BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.all(Radius.circular(11.2)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: imageProvider,
                width: 19.39,
                height: 20.39,
              ),
              SizedBox(height:  AppSize.s5),
              Flexible(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorManager.mediumgrey,
                   // fontSize: MediaQuery.of(context).size.height / 90,
                    fontSize: FontSize.s10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
