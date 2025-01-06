import 'package:flutter/material.dart';
import '../../../app/resources/color.dart';
import '../../../app/resources/font_manager.dart';
import '../../../app/resources/value_manager.dart';

class TabMenuConst extends StatelessWidget {
  final String text;
  final ImageProvider imageProvider;

  const TabMenuConst({required this.text, required this.imageProvider});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.all(Radius.circular(24)),
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height / 6.5,
          width: MediaQuery.of(context).size.width / 5,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 100,
            vertical: MediaQuery.of(context).size.height / 100,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: imageProvider,
                width:  AppSize.s20,
                height:  AppSize.s20,
              ),
              SizedBox(height: 8),
              Flexible(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorManager.mediumgrey,
                    fontSize: FontSize.s10,
                    fontWeight: FontWeight.w800,
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
