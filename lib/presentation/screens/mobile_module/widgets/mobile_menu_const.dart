import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/font_manager.dart';

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
          height: MediaQuery.of(context).size.height / 6,
          width: MediaQuery.of(context).size.width / 3.5,
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
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
              SizedBox(height: 5),
              Flexible(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.firaSans(
                    color: ColorManager.mediumgrey,
                    fontSize: MediaQuery.of(context).size.height / 90,
                    fontWeight: FontWeightManager.medium,
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
