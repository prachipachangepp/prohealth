import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import '../../../../app/resources/font_manager.dart';

class MobileConst extends StatelessWidget {
  final Widget mobileChild;
  final String titleText;
  // final String text;
  // final String? text2;
  final VoidCallback;
  final String textAction;
  const MobileConst({
    Key? key,
    required this.mobileChild,
    required this.titleText,
    required this.textAction,
    required this.VoidCallback,
    // required this.text,
    //  required   this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            width: double.maxFinite,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SvgPicture.asset(
                        'images/vector.svg',
                        height: MediaQuery.of(context).size.height / 3.5,
                        width: MediaQuery.of(context).size.width / 3.5,
                      ),
                    ),
                  ],
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: SvgPicture.asset(
                          'images/vector1.svg',
                          height: MediaQuery.of(context).size.height / 2.6,
                          width: MediaQuery.of(context).size.width / 3,
                        ),
                      ),
                    ]),
              ],
            )),
        Center(
          child: ClipRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 9, sigmaY: 5),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.9,
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff000000).withOpacity(0.045),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(1, 4),
                        ),
                      ],
                      color: ColorManager.white.withOpacity(0.35),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                              child: Image.asset(
                                'images/logo_login.png',
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.height / 5,
                              ),
                            )),
                        ///titletext
                        Expanded(
                            flex: 1,
                            child: Text(titleText,
                              style: GoogleFonts.firaSans(
                                color: ColorManager.mediumgrey,
                                // fontSize: FontSize.s38,
                                fontSize: MediaQuery.of(context).size.width / 13,
                                fontWeight: FontWeightManager.extrabold,
                              ),)),
                        Expanded(
                            flex: 2,
                            child: Container(
                              child: mobileChild,
                            )),
                        Expanded(flex: 1, child: Text(textAction,
                        )),
                      ],
                    ),
                  ))),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppString.poweredby,
                style: GoogleFonts.firaSans(
                  color: ColorManager.black,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
              SizedBox(
                width: AppSize.s2,
              ),
              Image.asset('images/powered_logo.png',
                  width: AppSize.s20, height: AppSize.s20)
            ],
          ),
        )
      ]),
    );
  }
}
