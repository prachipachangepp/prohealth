import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app/resources/color.dart';
import '../../../app/resources/const_string.dart';
import '../../../app/resources/font_manager.dart';
import '../../../app/resources/value_manager.dart';

class LoginBaseConst extends StatelessWidget {
  final Widget child;
  final String titleText;
  final VoidCallback onTap;
  final String bottomText;
  final EdgeInsetsGeometry? textActionPadding;

  const LoginBaseConst({
    required this.child,
    required this.titleText,
    required this.onTap,
    required this.bottomText,
    this.textActionPadding});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/mobile_images/mobile_login.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height / 30,
                vertical: MediaQuery.of(context).size.width / 8,
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff000000).withOpacity(0.045),
                          blurRadius: 4.27,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                      color: ColorManager.white.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(11.1),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/logo_login.png',
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: MediaQuery.of(context).size.height / 5,
                            )
                          ],
                        ),
                        //SizedBox(height: AppSize.s10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              titleText,
                              style: GoogleFonts.firaSans(
                                color: ColorManager.mediumgrey,
                                fontSize: FontSize.s25,
                                fontWeight: FontWeightManager.extrabold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSize.s5,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Material(
                            elevation: 9,
                            borderRadius: BorderRadius.circular(24),
                            child: Container(
                              // width: MediaQuery.of(context).size.width / 1.5,
                              height: MediaQuery.of(context).size.height / 3.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(19.99),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x1A000000), // 0px 0px 0px 0px #0000001A
                                    blurRadius: 0,
                                    spreadRadius: 0,
                                    offset: Offset(0, 0),
                                  ),
                                  BoxShadow(
                                    color: Color(0x1A000000), // 3.33px 8.33px 18.32px 0px #0000001A
                                    blurRadius: 18.32,
                                    spreadRadius: 3.33,
                                    offset: Offset(0, 8.33),
                                  ),
                                //   BoxShadow(
                                //     color: Color(0x26000000), // 3.33px 3.33px 80.79px 0px #00000026
                                //     blurRadius: 80.79,
                                //     spreadRadius: 3.33,
                                //     offset: Offset(0, 3.33),
                                //   ),
                                 ],
                              ),
                              child: child,
                            ),

                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                              textActionPadding ?? EdgeInsets.zero,
                              child: GestureDetector(
                                onTap: onTap,
                                child: Text(
                                  bottomText,
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.firaSans(
                                    color: Color(0xff1696C8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
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
          Positioned(
            bottom: 10,
            left: 135.0,
            child: Row(
              children: [
                Text(
                  AppStringMobile.poweredBy,
                  textAlign: TextAlign.end,
                  style: GoogleFonts.firaSans(
                      fontSize: AppSize.s10,
                      fontWeight: FontWeightManager.regular,
                      color: ColorManager.black),
                ),
                SizedBox(
                  width: AppSize.s8,
                ),
                Image.asset(
                  'images/powered_logo.png',
                  height: AppSize.s20,
                  width: AppSize.s20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
