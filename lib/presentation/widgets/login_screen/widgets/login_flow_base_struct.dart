import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';

class LoginBaseConstant extends StatelessWidget {
  final Widget child;
  final String titleText;
  final VoidCallback onTap;
  final String textAction;
  final EdgeInsetsGeometry? textActionPadding;
  final SvgPicture backImg = SvgPicture.asset("images/background.svg");
  LoginBaseConstant(
      {required this.child,
      required this.onTap,
      // required this.child2,
      required this.titleText,
      required this.textAction,
      this.textActionPadding});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      child: Stack(
        children: [
          Container(
              //height: double.maxFinite,
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
                          height: MediaQuery.of(context).size.height / 1.25,
                          // width: MediaQuery.of(context).size.width / 1,
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
                          child: SvgPicture.asset('images/vector1.svg',
                              height: MediaQuery.of(context).size.height / 1,
                              width: MediaQuery.of(context).size.width),
                        ),
                      ]),
                ],
              )),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height / 30,
                  vertical: MediaQuery.of(context).size.width / 30),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 9, sigmaY: 5),
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(0.045),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(1, 4),
                          ),
                        ],
                        color: Color(0xffFFFFFF).withOpacity(0.35),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 90,
                            vertical: MediaQuery.of(context).size.height / 100),
                        child: Column(
                          children: [
                            ///logo
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      right:
                                          MediaQuery.of(context).size.height /
                                              3),
                                  child: Image.asset(
                                    'images/logo_login.png',
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ///head text
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  28),
                                          child: Text(
                                            titleText,
                                            style: GoogleFonts.firaSans(
                                              color: ColorManager.mediumgrey,
                                              fontSize: 40,
                                              fontWeight:
                                                  FontWeightManager.extrabold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              30,
                                        ),
                                        ///todo prachi
                                        ///main container
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0xff000000)
                                                      .withOpacity(0.1),
                                                  spreadRadius: 0,
                                                  blurRadius: 0,
                                                  offset: Offset(0, 0),
                                                ),
                                                BoxShadow(
                                                  color: Color(0xff000000)
                                                      .withOpacity(0.1),
                                                  spreadRadius: 1,
                                                  blurRadius: 4,
                                                  offset: Offset(0, 3),
                                                ),
                                              ]),
                                          child: child,
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              60,
                                        ),
                                      ],
                                    ),
                                    ///forget password text
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: onTap,
                                            child: Text(
                                              textAction,
                                              textAlign: TextAlign.end,
                                              style: GoogleFonts.firaSans(
                                                color: Color(0xff1696C8),
                                                fontSize: FontSize.s14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Image.asset(
                                    'images/amico.png',
                                    width: MediaQuery.of(context).size.width / 3,
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Powered By",
                  style: GoogleFonts.firaSans(
                    color: ColorManager.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Image.asset('images/powered_logo.png', width: 25, height: 25)
              ],
            ),
          )
        ],
      ),
    );
  }
}