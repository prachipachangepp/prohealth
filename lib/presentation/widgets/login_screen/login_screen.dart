import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/login_screen/widgets/login_flow_base_struct.dart';
import 'package:prohealth/presentation/widgets/login_screen/sub_login_page.dart';

import 'forgot_screen/forgot_pass_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController controller = TextEditingController();
  PageController _pageController = PageController();
  int _selectedIndex = -1;

  void _navigateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _handleSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _navigateToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return LoginBaseConstant(
      child: Column(
      children: [
        ///logo
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 365,
              height: 110,
              child: Image.asset('images/logo_login.png'),
            )
          ],
        ),
        // SizedBox(height: 20,),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 15,
              right: MediaQuery.of(context).size.width / 12,
              top: 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 80.0),
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontFamily: 'FiraSans',
                        color: Color(0xff686464),
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  ///todo prachi
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      width: 380,
                      height: 250,
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 380,
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(24),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                // Headings
                                Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context)
                                          .size
                                          .width /
                                          120),
                                  child: Container(
                                    width: double.infinity,
                                    padding:
                                    EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _handleSelected(
                                                0);
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                "Login with Email",
                                                style:
                                                TextStyle(
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                  fontSize:
                                                  15,
                                                  color: _selectedIndex == 0
                                                      ? Colors
                                                      .blue
                                                      : Color(
                                                      0xff686464),
                                                ),
                                              ),
                                              SizedBox(
                                                  height:
                                                  5),
                                              _selectedIndex ==
                                                  0
                                                  ? Container(
                                                width:
                                                MediaQuery.of(context).size.width / 12,
                                                height:
                                                2,
                                                color:
                                                Colors.blue,
                                              )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _handleSelected(
                                                1);
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                "Login with Authenticator",
                                                style:
                                                TextStyle(
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                  fontSize:
                                                  15,
                                                  color: _selectedIndex == 1
                                                      ? Colors
                                                      .blue
                                                      : Color(
                                                      0xff686464),
                                                ),
                                              ),
                                              SizedBox(
                                                  height:
                                                  5),
                                              _selectedIndex ==
                                                  1
                                                  ? Container(
                                                width:
                                                MediaQuery.of(context).size.width / 8,
                                                height:
                                                2,
                                                color:
                                                Colors.blue,
                                              )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                ///todo prachi
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                        MediaQuery.of(
                                            context)
                                            .size
                                            .width /
                                            99),
                                    child: PageView(
                                      controller:
                                      _pageController,
                                      scrollDirection:
                                      Axis.horizontal,
                                      children: [
                                        /// Page 1: Log in with mail
                                        Container(
                                          width: 380,
                                          height: 200,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                    20),
                                                child:
                                                TextField(
                                                  decoration:
                                                  InputDecoration(
                                                    labelText:
                                                    'Email',
                                                    labelStyle:
                                                    TextStyle(fontSize: 14),
                                                    border:
                                                    UnderlineInputBorder(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  height:
                                                  12),
                                              Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                    20),
                                                child:
                                                TextField(
                                                  decoration:
                                                  InputDecoration(
                                                    labelText:
                                                    'Password',
                                                    labelStyle:
                                                    TextStyle(fontSize: 14), // Adjust the font size here
                                                    border:
                                                    UnderlineInputBorder(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  height:
                                                  10),
                                              CustomButton(
                                                text:
                                                'LogIn',
                                                onPressed:
                                                    () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SubLoginScreen()));
                                                },
                                                width: 90.0,
                                                height:
                                                30.0,
                                              )
                                            ],
                                          ),
                                        ),

                                        /// Page 2: Log in with authenticator
                                        Container(
                                          width: 380,
                                          height: 200,
                                          // color: Colors.blue,
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal:
                                                      20),
                                                  child:
                                                  TextField(
                                                    decoration:
                                                    InputDecoration(
                                                      labelText:
                                                      'Email',
                                                      labelStyle:
                                                      TextStyle(fontSize: 14),
                                                      border:
                                                      UnderlineInputBorder(),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                    20),
                                                CustomButton(
                                                  text:
                                                  'Next',
                                                  onPressed:
                                                      () {},
                                                  width:
                                                  90.0,
                                                  height:
                                                  30.0,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 175.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassScreen()));
                      },
                      child: Text(
                        'Forgot your account password ?',
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height/2,
                      child: Image.asset(
                        'images/amico.png',
                      ))
                ],
              )
            ],
          ),
        )
      ],
    ),);
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         Container(
    //             decoration: BoxDecoration(
    //               image: DecorationImage(
    //                   image: AssetImage('images/login_screen_no_blur.png'),
    //                   fit: BoxFit.fill),
    //             ),
    //             child: Center(
    //               child: Padding(
    //                 padding: const EdgeInsets.symmetric(
    //                     horizontal: 58.0, vertical: 58),
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     boxShadow: [
    //                       BoxShadow(
    //                         color: Color(0xff000000).withOpacity(0.045),
    //                         spreadRadius: 1,
    //                         blurRadius: 4,
    //                         offset: Offset(1, 4),
    //                       ),
    //                     ],
    //                     color: Color(0xffFFFFFF).withOpacity(0.35),
    //                     borderRadius: BorderRadius.all(Radius.circular(25)),
    //                   ),
    //                   child: Padding(
    //                     padding: EdgeInsets.symmetric(
    //                         horizontal: MediaQuery.of(context).size.width / 90,
    //                         vertical: MediaQuery.of(context).size.height / 100),
    //                     child: Column(
    //                       children: [
    //                         ///logo
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.end,
    //                           children: [
    //                             Container(
    //                               width: 365,
    //                               height: 110,
    //                               child: Image.asset('images/logo_login.png'),
    //                             )
    //                           ],
    //                         ),
    //                         // SizedBox(height: 20,),
    //                         Padding(
    //                           padding: EdgeInsets.only(
    //                               left: MediaQuery.of(context).size.width / 15,
    //                               right: MediaQuery.of(context).size.width / 12,
    //                               top: 60),
    //                           child: Row(
    //                             mainAxisAlignment:
    //                                 MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Column(
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   Padding(
    //                                     padding:
    //                                         const EdgeInsets.only(left: 80.0),
    //                                     child: Text(
    //                                       'Log In',
    //                                       style: TextStyle(
    //                                         fontFamily: 'FiraSans',
    //                                         color: Color(0xff686464),
    //                                         fontSize: 40,
    //                                         fontWeight: FontWeight.w800,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   SizedBox(
    //                                     height: 30,
    //                                   ),
    //
    //                                   ///todo prachi
    //                                   Material(
    //                                     elevation: 5,
    //                                     borderRadius: BorderRadius.circular(24),
    //                                     child: Container(
    //                                       width: 380,
    //                                       height: 250,
    //                                       child: Column(
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           Container(
    //                                             width: 380,
    //                                             height: 250,
    //                                             decoration: BoxDecoration(
    //                                               borderRadius:
    //                                                   BorderRadius.circular(24),
    //                                               color: Colors.white,
    //                                             ),
    //                                             child: Column(
    //                                               crossAxisAlignment:
    //                                                   CrossAxisAlignment.start,
    //                                               children: [
    //                                                 // Headings
    //                                                 Padding(
    //                                                   padding: EdgeInsets.all(
    //                                                       MediaQuery.of(context)
    //                                                               .size
    //                                                               .width /
    //                                                           120),
    //                                                   child: Container(
    //                                                     width: double.infinity,
    //                                                     padding:
    //                                                         EdgeInsets.all(8),
    //                                                     child: Row(
    //                                                       mainAxisAlignment:
    //                                                           MainAxisAlignment
    //                                                               .spaceEvenly,
    //                                                       children: [
    //                                                         GestureDetector(
    //                                                           onTap: () {
    //                                                             _handleSelected(
    //                                                                 0);
    //                                                           },
    //                                                           child: Column(
    //                                                             children: [
    //                                                               Text(
    //                                                                 "Login with Email",
    //                                                                 style:
    //                                                                     TextStyle(
    //                                                                   fontWeight:
    //                                                                       FontWeight
    //                                                                           .bold,
    //                                                                   fontSize:
    //                                                                       15,
    //                                                                   color: _selectedIndex == 0
    //                                                                       ? Colors
    //                                                                           .blue
    //                                                                       : Color(
    //                                                                           0xff686464),
    //                                                                 ),
    //                                                               ),
    //                                                               SizedBox(
    //                                                                   height:
    //                                                                       5),
    //                                                               _selectedIndex ==
    //                                                                       0
    //                                                                   ? Container(
    //                                                                       width:
    //                                                                           MediaQuery.of(context).size.width / 12,
    //                                                                       height:
    //                                                                           2,
    //                                                                       color:
    //                                                                           Colors.blue,
    //                                                                     )
    //                                                                   : Container(),
    //                                                             ],
    //                                                           ),
    //                                                         ),
    //                                                         GestureDetector(
    //                                                           onTap: () {
    //                                                             _handleSelected(
    //                                                                 1);
    //                                                           },
    //                                                           child: Column(
    //                                                             children: [
    //                                                               Text(
    //                                                                 "Login with Authenticator",
    //                                                                 style:
    //                                                                     TextStyle(
    //                                                                   fontWeight:
    //                                                                       FontWeight
    //                                                                           .bold,
    //                                                                   fontSize:
    //                                                                       15,
    //                                                                   color: _selectedIndex == 1
    //                                                                       ? Colors
    //                                                                           .blue
    //                                                                       : Color(
    //                                                                           0xff686464),
    //                                                                 ),
    //                                                               ),
    //                                                               SizedBox(
    //                                                                   height:
    //                                                                       5),
    //                                                               _selectedIndex ==
    //                                                                       1
    //                                                                   ? Container(
    //                                                                       width:
    //                                                                           MediaQuery.of(context).size.width / 8,
    //                                                                       height:
    //                                                                           2,
    //                                                                       color:
    //                                                                           Colors.blue,
    //                                                                     )
    //                                                                   : Container(),
    //                                                             ],
    //                                                           ),
    //                                                         ),
    //                                                       ],
    //                                                     ),
    //                                                   ),
    //                                                 ),
    //
    //                                                 ///todo prachi
    //                                                 Expanded(
    //                                                   child: Padding(
    //                                                     padding: EdgeInsets.symmetric(
    //                                                         horizontal:
    //                                                             MediaQuery.of(
    //                                                                         context)
    //                                                                     .size
    //                                                                     .width /
    //                                                                 99),
    //                                                     child: PageView(
    //                                                       controller:
    //                                                           _pageController,
    //                                                       scrollDirection:
    //                                                           Axis.horizontal,
    //                                                       children: [
    //                                                         /// Page 1: Log in with mail
    //                                                         Container(
    //                                                           width: 380,
    //                                                           height: 200,
    //                                                           child: Column(
    //                                                             children: [
    //                                                               Padding(
    //                                                                 padding: const EdgeInsets
    //                                                                     .symmetric(
    //                                                                     horizontal:
    //                                                                         20),
    //                                                                 child:
    //                                                                     TextField(
    //                                                                   decoration:
    //                                                                       InputDecoration(
    //                                                                     labelText:
    //                                                                         'Email',
    //                                                                     labelStyle:
    //                                                                         TextStyle(fontSize: 14),
    //                                                                     border:
    //                                                                         UnderlineInputBorder(),
    //                                                                   ),
    //                                                                 ),
    //                                                               ),
    //                                                               SizedBox(
    //                                                                   height:
    //                                                                       12),
    //                                                               Padding(
    //                                                                 padding: const EdgeInsets
    //                                                                     .symmetric(
    //                                                                     horizontal:
    //                                                                         20),
    //                                                                 child:
    //                                                                     TextField(
    //                                                                   decoration:
    //                                                                       InputDecoration(
    //                                                                     labelText:
    //                                                                         'Password',
    //                                                                     labelStyle:
    //                                                                         TextStyle(fontSize: 14), // Adjust the font size here
    //                                                                     border:
    //                                                                         UnderlineInputBorder(),
    //                                                                   ),
    //                                                                 ),
    //                                                               ),
    //                                                               SizedBox(
    //                                                                   height:
    //                                                                       10),
    //                                                               CustomButton(
    //                                                                 text:
    //                                                                     'LogIn',
    //                                                                 onPressed:
    //                                                                     () {
    //                                                                   Navigator.push(context, MaterialPageRoute(builder: (context) => SubLoginScreen()));
    //                                                                     },
    //                                                                 width: 90.0,
    //                                                                 height:
    //                                                                     30.0,
    //                                                               )
    //                                                             ],
    //                                                           ),
    //                                                         ),
    //
    //                                                         /// Page 2: Log in with authenticator
    //                                                         Container(
    //                                                           width: 380,
    //                                                           height: 200,
    //                                                           // color: Colors.blue,
    //                                                           child: Center(
    //                                                             child: Column(
    //                                                               children: [
    //                                                                 Padding(
    //                                                                   padding: const EdgeInsets
    //                                                                       .symmetric(
    //                                                                       horizontal:
    //                                                                           20),
    //                                                                   child:
    //                                                                       TextField(
    //                                                                     decoration:
    //                                                                         InputDecoration(
    //                                                                       labelText:
    //                                                                           'Email',
    //                                                                       labelStyle:
    //                                                                           TextStyle(fontSize: 14),
    //                                                                       border:
    //                                                                           UnderlineInputBorder(),
    //                                                                     ),
    //                                                                   ),
    //                                                                 ),
    //                                                                 SizedBox(
    //                                                                     height:
    //                                                                         20),
    //                                                                 CustomButton(
    //                                                                   text:
    //                                                                       'Next',
    //                                                                   onPressed:
    //                                                                       () {},
    //                                                                   width:
    //                                                                       90.0,
    //                                                                   height:
    //                                                                       30.0,
    //                                                                 )
    //                                                               ],
    //                                                             ),
    //                                                           ),
    //                                                         ),
    //                                                       ],
    //                                                     ),
    //                                                   ),
    //                                                 ),
    //                                               ],
    //                                             ),
    //                                           ),
    //                                         ],
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   SizedBox(
    //                                     height: 10,
    //                                   ),
    //                                   Padding(
    //                                     padding:
    //                                         const EdgeInsets.only(left: 175.0),
    //                                     child: GestureDetector(
    //                                       onTap: (){
    //
    //                                       },
    //                                       child: Text(
    //                                         'Forgot your account password ?',
    //                                         style: TextStyle(
    //                                           fontFamily: 'FiraSans',
    //                                           color: Color(0xff1696C8),
    //                                           fontSize: 12,
    //                                           fontWeight: FontWeight.w500,
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   )
    //                                 ],
    //                               ),
    //                               Column(
    //                                 mainAxisAlignment: MainAxisAlignment.start,
    //                                 children: [
    //                                   Container(
    //                                       width: MediaQuery.of(context).size.width / 3,
    //                                       height: MediaQuery.of(context).size.height/2,
    //                                       child: Image.asset(
    //                                         'images/amico.png',
    //                                       ))
    //                                 ],
    //                               )
    //                             ],
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             )),
    //       ],
    //     ),
    //   ),
    // );
  }
}