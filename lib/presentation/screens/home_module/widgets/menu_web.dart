import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/desktop_module/widgets/login_screen/desk_dashboard_hrm.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/const_string.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/theme_manager.dart';
import '../../desktop_module/hr_module/manage/widgets/bottom_row.dart';
import '../../desktop_module/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../desktop_module/sm_module/responsive_screen_sm.dart';
import '../../desktop_module/widgets/login_screen/widgets/child_container_constant_login.dart';
import '../../login_module/login/login_screen.dart';
import '../home_screen.dart';

class HomeScreenWeb extends StatelessWidget {
  const HomeScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 0,
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(
                  'images/menu_vector.svg',
                  height: MediaQuery.of(context).size.height / 1.28,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SvgPicture.asset('images/vector1.svg',
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width //1,
                ),
              ),
              Column(
                children: [
                  Center(
                    child: Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height / 30,
                          right: MediaQuery.of(context).size.height / 30,
                          top: MediaQuery.of(context).size.width / 40,
                        ),
                        child: SingleChildScrollView(
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 9, sigmaY: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                      Color(0xff000000).withOpacity(0.045),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: Offset(1, 4),
                                    ),
                                  ],
                                  color: Color(0xffFFFFFF).withOpacity(0.35),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                    MediaQuery.of(context).size.width / 90,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  90,
                                              vertical: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  100),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ///head text
                                              // Row(
                                              //   mainAxisAlignment:
                                              //   MainAxisAlignment
                                              //       .spaceBetween,
                                              //   children: [
                                                  Text(
                                                    'Select a Module',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.firaSans(
                                                      fontSize: 14,
                                                      fontWeight: FontWeightManager.bold,
                                                      color: ColorManager.darkgrey,
                                                    ),
                                                  ),
                                                  // CustomButton(
                                                  //   borderRadius: 14,
                                                  //   text: AppString.logout,
                                                  //   onPressed: () {
                                                  //     Navigator.push(
                                                  //       context,
                                                  //       MaterialPageRoute(
                                                  //           builder: (context) =>
                                                  //               LoginScreen()),
                                                  //     );
                                                  //   },
                                                  //   width:
                                                  //   MediaQuery.of(context)
                                                  //       .size
                                                  //       .width /
                                                  //       15,
                                                  //   height:
                                                  //   MediaQuery.of(context)
                                                  //       .size
                                                  //       .height /
                                                  //       22,
                                                  // ),
                                              //   ],
                                              // ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                child: Text(
                                                  'Administration',
                                                  textAlign: TextAlign.center,
                                                  style: MenuScreenHeadStyle.menuHead(context),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  ResponsiveContainer(
                                                    'Referral Resource Manager',
                                                    AssetImage(
                                                        "images/r_r_m.png"),
                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        25,
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ResponsiveScreenSM()));
                                                      },
                                                      child: ResponsiveContainer(
                                                        'Establishment Manager',
                                                        AssetImage(
                                                            "images/e_m.png"),
                                                      )),
                                                  SizedBox(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        25,
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    HomeScreenHRM()));
                                                      },
                                                      child: ResponsiveContainer(
                                                        'Human Resource Manager',
                                                        AssetImage(
                                                            "images/h_r_m.png"),
                                                      )),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                child: Text(
                                                  'Business',
                                                  textAlign: TextAlign.center,
                                                  style: MenuScreenHeadStyle.menuHead(context),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  ResponsiveContainer(
                                                    'Business Intelligence & Reports',
                                                    AssetImage(
                                                        "images/b_i_r.png"),
                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        25,
                                                  ),
                                                  ResponsiveContainer(
                                                    'Finance',
                                                    AssetImage(
                                                        "images/finance.png"),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                child: Text(
                                                  'Patient Related',
                                                  textAlign: TextAlign.center,
                                                  style:MenuScreenHeadStyle.menuHead(context),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  ResponsiveContainer(
                                                    'Intake & Scheduler',
                                                    AssetImage("images/i_s.png"),
                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        25,
                                                  ),
                                                  ResponsiveContainer(
                                                    'Rehab',
                                                    AssetImage(
                                                        "images/rehab.png"),
                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        25,
                                                  ),
                                                  ResponsiveContainer(
                                                    'Home Care',
                                                    AssetImage("images/h_c.png"),
                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        25,
                                                  ),
                                                  ResponsiveContainer(
                                                    'Home Health EMR',
                                                    AssetImage(
                                                        "images/h_h_emr.png"),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              ResponsiveContainer(
                                                'Hospice EMR',
                                                AssetImage("images/h_emr.png"),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                  ),
                  BottomBarRow()
                ],
              ),
            ],
          ),
        ));

      // Material(
      //   elevation: 0,
      //   child: Container(
      //     height: double.maxFinite,
      //     width: double.maxFinite,
      //     child: Stack(
      //       fit: StackFit.expand,
      //       children: [
      //         Align(
      //           alignment: Alignment.bottomRight,
      //           child: SvgPicture.asset(
      //             'images/menu_vector.svg',
      //             height: MediaQuery.of(context).size.height / 1.28,
      //           ),
      //         ),
      //         Align(
      //           alignment: Alignment.topLeft,
      //           child: SvgPicture.asset('images/vector1.svg',
      //               height: MediaQuery.of(context).size.height / 1.5,
      //               width: MediaQuery.of(context).size.width //1,
      //               ),
      //         ),
      //         Column(
      //           children: [
      //             Center(
      //               child: Padding(
      //                   padding: EdgeInsets.only(
      //                     left: MediaQuery.of(context).size.height / 30,
      //                     right: MediaQuery.of(context).size.height / 30,
      //                     top: MediaQuery.of(context).size.width / 40,
      //                   ),
      //                   child: SingleChildScrollView(
      //                     child: ClipRect(
      //                       child: BackdropFilter(
      //                         filter: ImageFilter.blur(sigmaX: 9, sigmaY: 5),
      //                         child: Container(
      //                           decoration: BoxDecoration(
      //                             boxShadow: [
      //                               BoxShadow(
      //                                 color:
      //                                     Color(0xff000000).withOpacity(0.045),
      //                                 spreadRadius: 1,
      //                                 blurRadius: 4,
      //                                 offset: Offset(1, 4),
      //                               ),
      //                             ],
      //                             color: Color(0xffFFFFFF).withOpacity(0.35),
      //                             borderRadius:
      //                                 BorderRadius.all(Radius.circular(25)),
      //                           ),
      //                           child: Padding(
      //                             padding: EdgeInsets.symmetric(
      //                               horizontal:
      //                                   MediaQuery.of(context).size.width / 90,
      //                             ),
      //                             child: Column(
      //                               mainAxisAlignment: MainAxisAlignment.center,
      //                               children: [
      //                                 Padding(
      //                                   padding: EdgeInsets.symmetric(
      //                                       horizontal: MediaQuery.of(context)
      //                                               .size
      //                                               .width /
      //                                           90,
      //                                       vertical: MediaQuery.of(context)
      //                                               .size
      //                                               .height /
      //                                           100),
      //                                   child: Column(
      //                                     crossAxisAlignment:
      //                                         CrossAxisAlignment.start,
      //                                     mainAxisAlignment:
      //                                         MainAxisAlignment.spaceEvenly,
      //                                     children: [
      //                                       ///head text
      //                                       Row(
      //                                         mainAxisAlignment:
      //                                             MainAxisAlignment
      //                                                 .spaceBetween,
      //                                         children: [
      //                                           Text(
      //                                             'Select a Module',
      //                                             textAlign: TextAlign.center,
      //                                             style: GoogleFonts.firaSans(
      //                                               fontSize: 14,
      //                                               fontWeight:
      //                                                   FontWeightManager.bold,
      //                                               color:
      //                                                   ColorManager.darkgrey,
      //                                             ),
      //                                           ),
      //                                           CustomButton(
      //                                             borderRadius: 14,
      //                                             text: AppString.logout,
      //                                             onPressed: () {
      //                                               Navigator.push(
      //                                                 context,
      //                                                 MaterialPageRoute(
      //                                                     builder: (context) =>
      //                                                         LoginScreen()),
      //                                               );
      //                                             },
      //                                             width: MediaQuery.of(context)
      //                                                     .size
      //                                                     .width /
      //                                                 15,
      //                                             height: MediaQuery.of(context)
      //                                                     .size
      //                                                     .height /
      //                                                 22,
      //                                           ),
      //                                         ],
      //                                       ),
      //                                       Text(
      //                                         'Administration',
      //                                         textAlign: TextAlign.center,
      //                                         style:
      //                                             MenuScreenHeadStyle.menuHead(
      //                                                 context),
      //                                       ),
      //                                       Row(
      //                                         children: [
      //                                           ResponsiveContainer(
      //                                             'Referral Resource Manager',
      //                                             AssetImage(
      //                                                 "images/r_r_m.png"),
      //                                           ),
      //                                           SizedBox(
      //                                             width: MediaQuery.of(context)
      //                                                     .size
      //                                                     .width /
      //                                                 25,
      //                                           ),
      //                                           InkWell(
      //                                               onTap: () {
      //                                                 Navigator.push(
      //                                                     context,
      //                                                     MaterialPageRoute(
      //                                                         builder: (context) =>
      //                                                             ResponsiveScreenSM()));
      //                                               },
      //                                               child: ResponsiveContainer(
      //                                                 'Establishment Manager',
      //                                                 AssetImage(
      //                                                     "images/e_m.png"),
      //                                               )),
      //                                           SizedBox(
      //                                             width: MediaQuery.of(context)
      //                                                     .size
      //                                                     .width /
      //                                                 25,
      //                                           ),
      //                                           InkWell(
      //                                               onTap: () {
      //                                                 Navigator.push(
      //                                                     context,
      //                                                     MaterialPageRoute(
      //                                                         builder: (context) =>
      //                                                             HomeScreen()));
      //                                               },
      //                                               child: ResponsiveContainer(
      //                                                 'Human Resource Manager',
      //                                                 AssetImage(
      //                                                     "images/h_r_m.png"),
      //                                               )),
      //                                         ],
      //                                       ),
      //                                       Text(
      //                                         'Business',
      //                                         textAlign: TextAlign.center,
      //                                         style:
      //                                             MenuScreenHeadStyle.menuHead(
      //                                                 context),
      //                                       ),
      //                                       Row(
      //                                         children: [
      //                                           ResponsiveContainer(
      //                                             'Business Intelligence & Reports',
      //                                             AssetImage(
      //                                                 "images/b_i_r.png"),
      //                                           ),
      //                                           SizedBox(
      //                                             width: MediaQuery.of(context)
      //                                                     .size
      //                                                     .width /
      //                                                 25,
      //                                           ),
      //                                           ResponsiveContainer(
      //                                             'Finance',
      //                                             AssetImage(
      //                                                 "images/finance.png"),
      //                                           ),
      //                                         ],
      //                                       ),
      //                                       Text(
      //                                         'Patient Related',
      //                                         textAlign: TextAlign.center,
      //                                         style:
      //                                             MenuScreenHeadStyle.menuHead(
      //                                                 context),
      //                                       ),
      //                                       Row(
      //                                         children: [
      //                                           ResponsiveContainer(
      //                                             'Intake & Scheduler',
      //                                             AssetImage("images/i_s.png"),
      //                                           ),
      //                                           SizedBox(
      //                                             width: MediaQuery.of(context)
      //                                                     .size
      //                                                     .width /
      //                                                 25,
      //                                           ),
      //                                           ResponsiveContainer(
      //                                             'Rehab',
      //                                             AssetImage(
      //                                                 "images/rehab.png"),
      //                                           ),
      //                                           SizedBox(
      //                                             width: MediaQuery.of(context)
      //                                                     .size
      //                                                     .width /
      //                                                 25,
      //                                           ),
      //                                           ResponsiveContainer(
      //                                             'Home Care',
      //                                             AssetImage("images/h_c.png"),
      //                                           ),
      //                                           SizedBox(
      //                                             width: MediaQuery.of(context)
      //                                                     .size
      //                                                     .width /
      //                                                 25,
      //                                           ),
      //                                           ResponsiveContainer(
      //                                             'Home Health EMR',
      //                                             AssetImage(
      //                                                 "images/h_h_emr.png"),
      //                                           ),
      //                                         ],
      //                                       ),
      //                                       SizedBox(
      //                                         height: 5,
      //                                       ),
      //                                       ResponsiveContainer(
      //                                         'Hospice EMR',
      //                                         AssetImage("images/h_emr.png"),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 )
      //                               ],
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   )),
      //             ),
      //             BottomBarRow()
      //           ],
      //         ),
      //       ],
      //     ),
      //   ));
  }
}
