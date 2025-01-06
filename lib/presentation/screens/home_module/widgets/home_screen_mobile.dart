import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../app/resources/color.dart';
import '../../../../app/resources/const_string.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/theme_manager.dart';
import '../../../../app/resources/value_manager.dart';
import '../../../widgets/mobile_constant/mobile_menu_const.dart';

class HomeScreenMobile extends StatelessWidget {
  const HomeScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
          ClipRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 9, sigmaY: 5),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
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
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: AppPadding.p20),
                          height: MediaQuery.of(context).size.height,
                          // color: Colors.pink,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset(
                                        'images/logo_login.png',
                                        width: 210,
                                        height: 60,
                                        // width: MediaQuery.of(context).size.width / 3,
                                        // height: MediaQuery.of(context).size.height / 15,
                                      ),
                                      //SizedBox(height: 10,),
                                      Text(
                                        'Select a Module',
                                        style: CustomTextStylesCommon.commonStyle(
                                          color: ColorManager.mediumgrey,
                                          fontSize: FontSize.s16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )),

                              ///containers
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text('Administration',
                                            style: MobileMenuText.MenuTextConst(
                                                context))
                                      ],
                                    ),

                                    ///1st row
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        MobMenuScreenConst(
                                          text: 'Referral Resource Manager',
                                          imageProvider:
                                          AssetImage("images/r_r_m.png"),
                                        ),
                                        MobMenuScreenConst(
                                          text:
                                          'Business Intelligence & Reports',
                                          imageProvider:
                                          AssetImage("images/b_i_r.png"),
                                        ),
                                      ],
                                    ),

                                    ///2nd
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        MobMenuScreenConst(
                                          text: 'Intake & Scheduler',
                                          imageProvider:
                                          AssetImage("images/i_s.png"),
                                        ),
                                        // SizedBox(
                                        //   height: 77,
                                        //   width: 128,
                                        // )
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              ///business
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text('Business',
                                            style: MobileMenuText.MenuTextConst(
                                                context))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        MobMenuScreenConst(
                                          text: 'Rehab',
                                          imageProvider:
                                          AssetImage("images/rehab.png"),
                                        ),
                                        MobMenuScreenConst(
                                          text: 'Home Care',
                                          imageProvider:
                                          AssetImage("images/h_c.png"),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        MobMenuScreenConst(
                                          text: 'Establishment Manager',
                                          imageProvider:
                                          AssetImage("images/e_m.png"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              ///patient related
                              Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text('Patient Related',
                                            style: MobileMenuText.MenuTextConst(
                                                context))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        MobMenuScreenConst(
                                          text: 'Human Resource Manager',
                                          imageProvider:
                                          AssetImage("images/h_r_m.png"),
                                        ),
                                        MobMenuScreenConst(
                                          text: 'Home Health EMR',
                                          imageProvider:
                                          AssetImage("images/h_h_emr.png"),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MobMenuScreenConst(
                                          text: 'Hospice EMR',
                                          imageProvider:    AssetImage(
                                              "images/h_emr.png"),
                                        ),
                                        MobMenuScreenConst(
                                          text: 'Finance',
                                          imageProvider:    AssetImage(
                                              "images/finance.png"),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MobMenuScreenConst(
                                          text: 'Other',
                                          imageProvider:    AssetImage(
                                              "images/other.png"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ))),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppString.poweredby,
                  style: CustomTextStylesCommon.commonStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeight.w400,
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
        ],
      ),
    );
  }
}
