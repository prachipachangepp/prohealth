import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../../app/resources/color.dart';
import '../../../../../../../../../app/resources/font_manager.dart';

class CIRoleContainerConstant extends StatelessWidget {
  final String text;
  final ImageProvider imageProvider;
  final Color borderColor;
  const CIRoleContainerConstant(this.text, this.imageProvider,
  { this.borderColor = Colors.transparent,});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.all(Radius.circular(24)),
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height / 5.3,
          width: MediaQuery.of(context).size.width / 6.5,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 70,
            vertical: MediaQuery.of(context).size.height / 90,
          ),
          decoration: BoxDecoration(

            boxShadow: [
              BoxShadow(
                color: ColorManager.black.withOpacity(0.1),
                spreadRadius: 8,
                blurRadius: 10,
                offset: Offset(2, 2),
              ),
            ],
            color: Colors.white,
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: imageProvider,
                width: 30,
                height: 30,
              ),
              SizedBox(height: 10),
              Flexible(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.firaSans(
                    color: ColorManager.mediumgrey,
                    fontSize: 12,
                    fontWeight: FontWeightManager.extrabold,
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
