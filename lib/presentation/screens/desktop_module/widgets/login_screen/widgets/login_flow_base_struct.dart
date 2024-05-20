import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import '../../../../../../app/resources/color.dart';

/// new code

class LoginBaseConstant extends StatelessWidget {
  LoginBaseConstant(
      {Key? key,
      required this.child,
      required this.onTap,
      required this.titleText,
      required this.textAction,
      this.textActionPadding})
      : super(key: key);
  final Widget child;
  final String titleText;
  final VoidCallback onTap;
  final String textAction;
  final EdgeInsetsGeometry? textActionPadding;
  final SvgPicture backImg = SvgPicture.asset("images/background.svg");

  @override
  Widget build(BuildContext context) {
    ///desk
    if (MediaQuery.of(context).size.width > 870) {
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
        Padding(
          padding: const EdgeInsets.all(AppPadding.p30),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 9, sigmaY: 5),
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
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            //color: Colors.green,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                topLeft: Radius.circular(25)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 20,
                                top: MediaQuery.of(context).size.width / 11),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  titleText,
                                  style: GoogleFonts.firaSans(
                                    color: ColorManager.mediumgrey,
                                    // fontSize: FontSize.s38,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 42,
                                    fontWeight: FontWeightManager.extrabold,
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        60),
                                child,
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        70),

                                ///bottom text
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: onTap,
                                        child: Text(
                                          textAction,
                                          textAlign: TextAlign.end,
                                          style: CustomTextStylesCommon
                                              .commonStyle(
                                            color: ColorManager.bluebottom,
                                            //fontSize: FontSize.s12,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                55,
                                            fontWeight:
                                                FontWeightManager.medium,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),

                    ///logo, amico image
                    Expanded(
                      flex: 1,
                      child: Container(
                          decoration: BoxDecoration(
                            // color: Colors.red,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomRight: Radius.circular(25)),
                          ),
                          // color: Colors.yellow,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'images/logo_login.png',
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.height / 5,
                              ),
                              Expanded(
                                child: Image.asset(
                                  'images/amico.png',
                                ),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: AppSize.s2,
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
                  width: AppSize.s25, height: AppSize.s25)
            ],
          ),
        )
      ]));
    }
    ///tablet
    else
      if (MediaQuery.of(context).size.width > 600) {
      return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height, color: Colors.purple,
          child: Center(child: Text("Tablet Screen"),)
        ),
      );
    }
    ///mobile
    else if (MediaQuery.of(context).size.width > 450) {
      return Scaffold(
          body: Container(
              height: MediaQuery.of(context).size.height, color: Colors.green,
              child: Center(child: Text("Mobile Screen"),)
          ));
    }
    else {
      return Scaffold(
        body: Container(color: Colors.yellow),
      );
    }
  }
}


///old code
// class LoginBaseConstant extends StatelessWidget {
//   final Widget child;
//   final String titleText;
//   final VoidCallback onTap;
//   final String textAction;
//   final EdgeInsetsGeometry? textActionPadding;
//   final SvgPicture backImg = SvgPicture.asset("images/background.svg");
//   LoginBaseConstant(
//       {required this.child,
//       required this.onTap,
//       required this.titleText,
//       required this.textAction,
//       this.textActionPadding});
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: 0,
//       child: Stack(children: [
//         Container(
//             width: double.maxFinite,
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Align(
//                       alignment: Alignment.bottomRight,
//                       child: SvgPicture.asset(
//                         'images/vector.svg',
//                         height: MediaQuery.of(context).size.height / 1.25,
//                         // width: MediaQuery.of(context).size.width / 1,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Align(
//                         alignment: Alignment.topLeft,
//                         child: SvgPicture.asset('images/vector1.svg',
//                             height: MediaQuery.of(context).size.height / 1,
//                             width: MediaQuery.of(context).size.width),
//                       ),
//                     ]),
//               ],
//             )),
//         Padding(
//           padding: const EdgeInsets.all(30),
//           child: ClipRect(
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 9, sigmaY: 5),
//               child: Container(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color(0xff000000).withOpacity(0.045),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: Offset(1, 4),
//                     ),
//                   ],
//                   color: Color(0xffFFFFFF).withOpacity(0.35),
//                   borderRadius: BorderRadius.all(Radius.circular(30)),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                         flex: 1,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             //color: Colors.green,
//                             borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(25),
//                                 topLeft: Radius.circular(25)),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.only(
//                                 left: MediaQuery.of(context).size.width / 20,
//                                 top: MediaQuery.of(context).size.width / 11),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   titleText,
//                                   style: GoogleFonts.firaSans(
//                                     color: ColorManager.mediumgrey,
//                                     // fontSize: FontSize.s38,
//                                     fontSize:
//                                         MediaQuery.of(context).size.width / 42,
//                                     fontWeight: FontWeightManager.extrabold,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                     height: MediaQuery.of(context).size.height /
//                                         60),
//                                 child,
//                                 SizedBox(
//                                     height: MediaQuery.of(context).size.height /
//                                         70),
//
//                                 ///bottom text
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Container(
//                                       alignment: Alignment.centerRight,
//                                       child: InkWell(
//                                         onTap: onTap,
//                                         child: Text(
//                                           textAction,
//                                           textAlign: TextAlign.end,
//                                           style: CustomTextStylesCommon
//                                               .commonStyle(
//                                             color: ColorManager.bluebottom,
//                                             //fontSize: FontSize.s12,
//                                             fontSize: MediaQuery.of(context)
//                                                     .size
//                                                     .height /
//                                                 55,
//                                             fontWeight:
//                                                 FontWeightManager.medium,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )),
//
//                     ///logo, amico image
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                           decoration: BoxDecoration(
//                             // color: Colors.red,
//                             borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(25),
//                                 bottomRight: Radius.circular(25)),
//                           ),
//                           // color: Colors.yellow,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Image.asset(
//                                 'images/logo_login.png',
//                                 width: MediaQuery.of(context).size.width / 5,
//                                 height: MediaQuery.of(context).size.height / 5,
//                               ),
//                               Expanded(
//                                 child: Image.asset(
//                                   'images/amico.png',
//                                 ),
//                               ),
//                             ],
//                           )),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: AppSize.s2,
//         ),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 AppString.poweredby,
//                 style: GoogleFonts.firaSans(
//                   color: ColorManager.black,
//                   fontSize: FontSize.s14,
//                   fontWeight: FontWeightManager.regular,
//                 ),
//               ),
//               SizedBox(
//                 width: AppSize.s2,
//               ),
//               Image.asset('images/powered_logo.png',
//                   width: AppSize.s25, height: AppSize.s25)
//             ],
//           ),
//         )
//       ]),
//     );
//     //   Material(
//     //   elevation: 0,
//     //   child: Stack(
//     //     children: [
//     //       Container(
//     //           //height: double.maxFinite,
//     //           width: double.maxFinite,
//     //           child: Stack(
//     //             fit: StackFit.expand,
//     //             children: [
//     //               Column(
//     //                 mainAxisAlignment: MainAxisAlignment.end,
//     //                 crossAxisAlignment: CrossAxisAlignment.end,
//     //                 children: [
//     //                   Align(
//     //                     alignment: Alignment.bottomRight,
//     //                     child: SvgPicture.asset(
//     //                       'images/vector.svg',
//     //                       height: MediaQuery.of(context).size.height / 1.25,
//     //                       // width: MediaQuery.of(context).size.width / 1,
//     //                     ),
//     //                   ),
//     //                 ],
//     //               ),
//     //               Column(
//     //                   mainAxisAlignment: MainAxisAlignment.start,
//     //                   crossAxisAlignment: CrossAxisAlignment.start,
//     //                   children: [
//     //                     Align(
//     //                       alignment: Alignment.topLeft,
//     //                       child: SvgPicture.asset('images/vector1.svg',
//     //                           height: MediaQuery.of(context).size.height / 1,
//     //                           width: MediaQuery.of(context).size.width),
//     //                     ),
//     //                   ]),
//     //             ],
//     //           )),
//     //       Center(
//     //         child: Padding(
//     //           padding: EdgeInsets.symmetric(
//     //               horizontal: MediaQuery.of(context).size.height / 30,
//     //               vertical: MediaQuery.of(context).size.width / 30),
//     //           child: ClipRect(
//     //             child: BackdropFilter(
//     //               filter: ImageFilter.blur(sigmaX: 9, sigmaY: 5),
//     //               child: SingleChildScrollView(
//     //                 child: Container(
//     //                   decoration: BoxDecoration(
//     //                     boxShadow: [
//     //                       BoxShadow(
//     //                         color: Color(0xff000000).withOpacity(0.045),
//     //                         spreadRadius: 1,
//     //                         blurRadius: 4,
//     //                         offset: Offset(1, 4),
//     //                       ),
//     //                     ],
//     //                     color: Color(0xffFFFFFF).withOpacity(0.35),
//     //                     borderRadius: BorderRadius.all(Radius.circular(25)),
//     //                   ),
//     //                   child: Padding(
//     //                     padding: EdgeInsets.symmetric(
//     //                         horizontal: MediaQuery.of(context).size.width / 90,
//     //                         vertical: MediaQuery.of(context).size.height / 100),
//     //                     child: Column(
//     //                       children: [
//     //                         ///logo
//     //                         Row(
//     //                           mainAxisAlignment: MainAxisAlignment.end,
//     //                           children: [
//     //                             Padding(
//     //                               padding: EdgeInsets.only(
//     //                                   right: MediaQuery.of(context).size.height / 3),
//     //                               child: Image.asset(
//     //                                 'images/logo_login.png',
//     //                                 width:
//     //                                     MediaQuery.of(context).size.width / 5,
//     //                                 height:
//     //                                     MediaQuery.of(context).size.height / 5,
//     //                               ),
//     //                             )
//     //                           ],
//     //                         ),
//     //                         Row(
//     //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//     //                           children: [
//     //                             Column(
//     //                               crossAxisAlignment: CrossAxisAlignment.end,
//     //                               children: [
//     //                                 Column(
//     //                                   crossAxisAlignment:
//     //                                       CrossAxisAlignment.start,
//     //                                   children: [
//     //                                     ///head text
//     //                                     Padding(
//     //                                       padding: EdgeInsets.only(
//     //                                           left: MediaQuery.of(context)
//     //                                                   .size
//     //                                                   .width /
//     //                                               20),
//     //                                       child: Text(
//     //                                         titleText,
//     //                                         style: GoogleFonts.firaSans(
//     //                                           color: ColorManager.mediumgrey,
//     //                                           fontSize: FontSize.s38,
//     //                                           fontWeight: FontWeightManager.extrabold,
//     //                                         ),
//     //                                       ),
//     //                                     ),
//     //                                     SizedBox(
//     //                                       height: MediaQuery.of(context)
//     //                                               .size
//     //                                               .height /
//     //                                           30,
//     //                                     ),
//     //                                     ///todo prachi
//     //                                     ///main container
//     //                                     Padding(
//     //                                         padding: EdgeInsets.only(
//     //                                             left: MediaQuery.of(context)
//     //                                                 .size
//     //                                                 .width /
//     //                                                 20),
//     //                                       child: Container(
//     //                                         width: MediaQuery.of(context)
//     //                                                 .size
//     //                                                 .width /
//     //                                             3,
//     //                                         height: MediaQuery.of(context)
//     //                                                 .size
//     //                                                 .height /
//     //                                             2,
//     //                                         decoration: BoxDecoration(
//     //                                             borderRadius:
//     //                                                 BorderRadius.circular(24),
//     //                                             color: ColorManager.white,
//     //                                             boxShadow: [
//     //                                               BoxShadow(
//     //                                                 color: Color(0xff000000)
//     //                                                     .withOpacity(0.1),
//     //                                                 spreadRadius: 0,
//     //                                                 blurRadius: 0,
//     //                                                 offset: Offset(0, 0),
//     //                                               ),
//     //                                               BoxShadow(
//     //                                                 color: Color(0xff000000)
//     //                                                     .withOpacity(0.1),
//     //                                                 spreadRadius: 1,
//     //                                                 blurRadius: 4,
//     //                                                 offset: Offset(0, 3),
//     //                                               ),
//     //                                             ]),
//     //                                         child: child,
//     //                                       ),
//     //                                     ),
//     //                                     SizedBox(
//     //                                       height: MediaQuery.of(context)
//     //                                               .size
//     //                                               .height /
//     //                                           60,
//     //                                     ),
//     //                                   ],
//     //                                 ),
//     //                                 ///forget password text
//     //                                 Column(
//     //                                   crossAxisAlignment:
//     //                                       CrossAxisAlignment.end,
//     //                                   children: [
//     //                                     Container(
//     //                                       alignment: Alignment.centerRight,
//     //                                       child: InkWell(
//     //                                         onTap: onTap,
//     //                                         child: Text(
//     //                                           textAction,
//     //                                           textAlign: TextAlign.end,
//     //                                           style: CustomTextStylesCommon.commonStyle(
//     //                                             color:ColorManager.bluebottom,
//     //                                             fontSize: FontSize.s12,
//     //                                             fontWeight: FontWeightManager.medium,
//     //                                           ),
//     //                                         ),
//     //                                       ),
//     //                                     ),
//     //                                   ],
//     //                                 ),
//     //                               ],
//     //                             ),
//     //                             Expanded(
//     //                               child: Image.asset(
//     //                                 'images/amico.png',
//     //                                 width: MediaQuery.of(context).size.width / 3,
//     //                                 height:
//     //                                     MediaQuery.of(context).size.height / 2,
//     //                               ),
//     //                             )
//     //                           ],
//     //                         )
//     //                       ],
//     //                     ),
//     //                   ),
//     //                 ),
//     //               ),
//     //             ),
//     //           ),
//     //         ),
//     //       ),
//     //       Align(
//     //         alignment: Alignment.bottomCenter,
//     //         child: Row(
//     //           mainAxisAlignment: MainAxisAlignment.center,
//     //           crossAxisAlignment: CrossAxisAlignment.center,
//     //           children: [
//     //             Text(
//     //               AppString.poweredby,
//     //               style: GoogleFonts.firaSans(
//     //                 color: ColorManager.black,
//     //                 fontSize: FontSize.s14,
//     //                 fontWeight: FontWeightManager.regular,
//     //               ),
//     //             ),
//     //             SizedBox(
//     //               width: AppSize.s2,
//     //             ),
//     //             Image.asset('images/powered_logo.png', width: AppSize.s25, height: AppSize.s25)
//     //           ],
//     //         ),
//     //       )
//     //     ],
//     //   ),
//     // );
//   }
// }