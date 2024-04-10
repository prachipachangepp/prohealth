import 'dart:ui';

import 'package:flutter/material.dart';

class LoginBaseConstant extends StatelessWidget {
  final Widget child;
  final String titleText;
  final VoidCallback onTap;
  final String textAction;
  final EdgeInsetsGeometry? textActionPadding;

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
      elevation: 4,
      child: Container(
          // height: 725,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/login_screen_no_blur.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height / 30,
                  vertical: MediaQuery.of(context).size.width / 30),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 9, sigmaY: 5),
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
                                        MediaQuery.of(context).size.height / 3),
                                child: Image.asset(
                                  'images/logo_login.png',
                                  width: MediaQuery.of(context).size.width / 5,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.height /
                                                10),
                                    child: Text(
                                      titleText,
                                      style: TextStyle(
                                        fontFamily: 'FiraSans',
                                        color: Color(0xff686464),
                                        fontSize: 30,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        100,
                                  ),

                                  ///todo prachi
                                  Material(
                                    elevation: 9,
                                    borderRadius: BorderRadius.circular(24),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2.3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            color: Colors.white,
                                          ),
                                          child: child,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 70,
                                  ),

                                  ///forget password text
                                  Padding(
                                    padding:
                                        textActionPadding ?? EdgeInsets.zero,
                                    child: GestureDetector(
                                      onTap: onTap,
                                      child: Text(
                                        textAction,
                                        style: TextStyle(
                                          fontFamily: 'FiraSans',
                                          color: Color(0xff1696C8),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Image.asset(
                                'images/amico.png',
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.height / 2,
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
          )),
    );
  }
}

//Material(
//       child: Container(
//           // height: 725,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('images/login_screen_no_blur.png'),
//               fit: BoxFit.fill,
//             ),
//           ),
//           child: Center(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: MediaQuery.of(context).size.height / 30,
//                   vertical: MediaQuery.of(context).size.width / 30),
//               child: Container(
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
//                   borderRadius: BorderRadius.all(Radius.circular(25)),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: MediaQuery.of(context).size.width / 90,
//                       vertical: MediaQuery.of(context).size.height / 100),
//                   child: Column(
//                     children: [
//                       ///logo
//
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           )),
//     );
