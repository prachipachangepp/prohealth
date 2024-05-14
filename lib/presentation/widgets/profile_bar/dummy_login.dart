import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DumLoginconst extends StatelessWidget {
  final Widget child;
  final String titleText;
  final VoidCallback onTap;
  final String textAction;
  final EdgeInsetsGeometry? textActionPadding;
  final SvgPicture backImg = SvgPicture.asset("images/background.svg");
  DumLoginconst(
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
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.green,
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.yellow,
                      ))
                ],
              ),
            ),
          )

          ///
          // Container(
          //     child: Center(
          //         child: Expanded(
          //             flex: 1,
          //             child: Padding(
          //                 padding: EdgeInsets.all(
          //                     MediaQuery.of(context).size.width / 40),
          //                 child: ClipRect(
          //                     child: BackdropFilter(
          //                         filter:
          //                             ImageFilter.blur(sigmaX: 9, sigmaY: 5),
          //                         child: Container(
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.all(
          //                               Radius.circular(25),
          //                             ),
          //                             boxShadow: [
          //                               BoxShadow(
          //                                 color: Color(0xff000000)
          //                                     .withOpacity(0.045),
          //                                 spreadRadius: 1,
          //                                 blurRadius: 4,
          //                                 offset: Offset(1, 4),
          //                               ),
          //                             ],
          //                             color:
          //                                 Color(0xffFFFFFF).withOpacity(0.35),
          //
          //                             // color: Colors.red
          //                           ),
          //                           child: Container(),
          //                         )))))))

          ///
          // Container(
          //   child: Center(
          //     child: Expanded(
          //       flex: 1,
          //       child: Padding(
          //           padding:
          //               EdgeInsets.all(MediaQuery.of(context).size.width / 40),
          //           child: ClipRect(
          //               child: BackdropFilter(
          //             filter: ImageFilter.blur(sigmaX: 9, sigmaY: 5),
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.all(
          //                   Radius.circular(25),
          //                 ),
          //                 // color: Colors.red
          //               ),
          //               child: Row(
          //                 children: [
          //                   Expanded(
          //                     flex: 1,
          //                     child: Container(
          //                         decoration: BoxDecoration(
          //                           borderRadius: BorderRadius.only(
          //                             topLeft: Radius.circular(25),
          //                             bottomLeft: Radius.circular(25),
          //                           ),
          //                           // color: Colors.yellow
          //                         ),
          //                         child: Column(children: [
          //                           Center(
          //                             child: Expanded(
          //                               flex: 1,
          //                               child: Text(
          //                                 titleText,
          //                                 style: GoogleFonts.firaSans(
          //                                   color: ColorManager.darktgrey,
          //                                   fontSize: 40,
          //                                   fontWeight:
          //                                       FontWeightManager.extrabold,
          //                                 ),
          //                               ),
          //                             ),
          //                           ),
          //                           SizedBox(
          //                             height: 30,
          //                           ),
          //                           Expanded(
          //                               flex: 1,
          //                               child: Padding(
          //                                 padding: EdgeInsets.all(70),
          //                                 child: Material(
          //                                   elevation: 4,
          //                                   borderRadius: BorderRadius.all(
          //                                     Radius.circular(25),
          //                                   ),
          //                                   child: Container(
          //                                     decoration: BoxDecoration(
          //                                       borderRadius: BorderRadius.all(
          //                                         Radius.circular(25),
          //                                       ),
          //                                       color: Colors.white,
          //                                     ),
          //                                   ),
          //                                 ),
          //                               )),
          //                         ])),
          //                   ),
          //                   Expanded(
          //                     flex: 1,
          //                     child: Container(
          //                         decoration: BoxDecoration(
          //                           borderRadius: BorderRadius.only(
          //                             bottomRight: Radius.circular(25),
          //                             topRight: Radius.circular(25),
          //                           ),
          //                           // color: Colors.greenAccent
          //                         ),
          //                         child: Column(children: [
          //                           Expanded(
          //                             flex: 1,
          //                             child: Align(
          //                               alignment: Alignment.topCenter,
          //                               child: Image.asset(
          //                                 'images/logo_login.png',
          //                                 width: MediaQuery.of(context)
          //                                         .size
          //                                         .width /
          //                                     5,
          //                                 // height:
          //                                 //     MediaQuery.of(context).size.height /
          //                                 //         5,
          //                               ),
          //                             ),
          //                           ),
          //                           Image.asset(
          //                             'images/amico.png',
          //                             width: MediaQuery.of(context).size.width /
          //                                 1.3,
          //                             height:
          //                                 MediaQuery.of(context).size.height /
          //                                     1.4,
          //                           )
          //                         ])),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ))),
          //     ),
          //   ),
          // )
        ],
      ),
    );
    //   Material(
    //   elevation: 0,
    //   child: Stack(
    //     children: [
    //       Container(
    //         //height: double.maxFinite,
    //           width: double.maxFinite,
    //           child: Stack(
    //             fit: StackFit.expand,
    //             children: [
    //               Column(
    //                 mainAxisAlignment: MainAxisAlignment.end,
    //                 crossAxisAlignment: CrossAxisAlignment.end,
    //                 children: [
    //                   Align(
    //                     alignment: Alignment.bottomRight,
    //                     child: SvgPicture.asset(
    //                       'images/vector.svg',
    //                       height: MediaQuery.of(context).size.height / 1.25,
    //                       // width: MediaQuery.of(context).size.width / 1,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               Column(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Align(
    //                       alignment: Alignment.topLeft,
    //                       child: SvgPicture.asset('images/vector1.svg',
    //                           height: MediaQuery.of(context).size.height / 1,
    //                           width: MediaQuery.of(context).size.width),
    //                     ),
    //                   ]),
    //             ],
    //           )),
    //       Center(
    //         child: Padding(
    //           padding: EdgeInsets.symmetric(
    //               horizontal: MediaQuery.of(context).size.height / 30,
    //               vertical: MediaQuery.of(context).size.width / 30),
    //           child: ClipRect(
    //             child: BackdropFilter(
    //               filter: ImageFilter.blur(sigmaX: 9, sigmaY: 5),
    //               child: SingleChildScrollView(
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
    //                             Padding(
    //                               padding: EdgeInsets.only(
    //                                   right:
    //                                   MediaQuery.of(context).size.height /
    //                                       3),
    //                               child: Image.asset(
    //                                 'images/logo_login.png',
    //                                 width:
    //                                 MediaQuery.of(context).size.width / 5,
    //                                 height:
    //                                 MediaQuery.of(context).size.height / 5,
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                           children: [
    //                             Column(
    //                               crossAxisAlignment: CrossAxisAlignment.end,
    //                               children: [
    //                                 Column(
    //                                   crossAxisAlignment:
    //                                   CrossAxisAlignment.start,
    //                                   children: [
    //                                     ///head text
    //                                     Padding(
    //                                       padding: EdgeInsets.only(
    //                                           left: MediaQuery.of(context)
    //                                               .size
    //                                               .height /
    //                                               30),
    //                                       child: Text(
    //                                         titleText,
    //                                         style: GoogleFonts.firaSans(
    //                                           color: ColorManager.darktgrey,
    //                                           fontSize: 40,
    //                                           fontWeight:
    //                                           FontWeightManager.extrabold,
    //                                         ),
    //                                       ),
    //                                     ),
    //                                     SizedBox(
    //                                       height: MediaQuery.of(context)
    //                                           .size
    //                                           .height /
    //                                           30,
    //                                     ),
    //                                     ///todo prachi
    //                                     ///main container
    //                                     Container(
    //                                       width: MediaQuery.of(context)
    //                                           .size
    //                                           .width /
    //                                           3,
    //                                       height: MediaQuery.of(context)
    //                                           .size
    //                                           .height /
    //                                           2,
    //                                       decoration: BoxDecoration(
    //                                           borderRadius:
    //                                           BorderRadius.circular(24),
    //                                           color: Colors.white,
    //                                           boxShadow: [
    //                                             BoxShadow(
    //                                               color: Color(0xff000000)
    //                                                   .withOpacity(0.1),
    //                                               spreadRadius: 0,
    //                                               blurRadius: 0,
    //                                               offset: Offset(0, 0),
    //                                             ),
    //                                             BoxShadow(
    //                                               color: Color(0xff000000)
    //                                                   .withOpacity(0.1),
    //                                               spreadRadius: 1,
    //                                               blurRadius: 4,
    //                                               offset: Offset(0, 3),
    //                                             ),
    //                                           ]),
    //                                       child: child,
    //                                     ),
    //                                     SizedBox(
    //                                       height: MediaQuery.of(context)
    //                                           .size
    //                                           .height /
    //                                           60,
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 ///forget password text
    //                                 Column(
    //                                   crossAxisAlignment:
    //                                   CrossAxisAlignment.end,
    //                                   children: [
    //                                     Container(
    //                                       alignment: Alignment.centerRight,
    //                                       child: InkWell(
    //                                         onTap: onTap,
    //                                         child: Text(
    //                                           textAction,
    //                                           textAlign: TextAlign.end,
    //                                           style: GoogleFonts.firaSans(
    //                                             color: Color(0xff1696C8),
    //                                             fontSize: FontSize.s14,
    //                                             fontWeight: FontWeight.bold,
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ],
    //                             ),
    //                             Expanded(
    //                               child: Image.asset(
    //                                 'images/amico.png',
    //                                 width: MediaQuery.of(context).size.width / 3,
    //                                 height:
    //                                 MediaQuery.of(context).size.height / 2,
    //                               ),
    //                             )
    //                           ],
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       Align(
    //         alignment: Alignment.bottomCenter,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Text(
    //               "Powered By",
    //               style: GoogleFonts.firaSans(
    //                 color: ColorManager.black,
    //                 fontSize: 14,
    //                 fontWeight: FontWeight.w400,
    //               ),
    //             ),
    //             SizedBox(
    //               width: 2,
    //             ),
    //             Image.asset('images/powered_logo.png', width: 25, height: 25)
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}

class DumLogInScreen extends StatelessWidget {
  const DumLogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DumLoginconst(
      onTap: () {},
      titleText: 'Log In',
      textAction: '',
      child: Column(
        children: [],
      ),
    );
  }
}

///
// class LoginScreen extends StatefulWidget {
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   PageController _pageController = PageController();
//   List<TextEditingController> _otpControllers =
//       List.generate(4, (_) => TextEditingController());
//   TextEditingController _otpController = TextEditingController();
//   int _selectedIndex = 0;
//   FocusNode fieldOne = FocusNode();
//   FocusNode fieldTow = FocusNode();
//   final _formKey = GlobalKey<FormState>();
//   final _formKeyAuth = GlobalKey<FormState>();
//   bool isPasswordVisible = true;
//   bool _isLoading = false;
//   bool _isPasswordVisible = false;
//   String? _errorMessage;
//   bool _showEmailInput = true;
//   bool _loginSuccessful = false;
//   bool _isauthLoginLoading = false;
//   FocusNode emailFocusNode = FocusNode();
//   FocusNode passwordFocusNode = FocusNode();
//   String? otpFromRunTab;
//   String? _errorLoginMessage;
//   bool _isLoggingIn = false;
//   final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
//   bool _isLoadingScreen = true;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     emailFocusNode.dispose();
//     passwordFocusNode.dispose();
//     super.dispose();
//   }
//
//   void _navigateToPage(int page) {
//     _pageController.animateToPage(
//       page,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _handleSelected(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     _navigateToPage(index);
//   }
//
//   /// Method for handling the action of the "Next" button
//   void _handleNextButton() async {
//     if (_selectedIndex == 0) {
//       AuthService.loginWithEmail(
//         context,
//         _emailController,
//         _passwordController,
//         _isLoading,
//         (value) => setState(() => _isLoading = value),
//         (message) => setState(() => _errorMessage = message),
//       );
//       // _loginWithEmail();
//     } else if (_selectedIndex == 1) {
//       String email = _emailController.text.trim();
//       await GetOTPService.getOTP(email);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//         // _isLoadingScreen
//         //     ? Center(
//         //         child: CircularProgressIndicator(),
//         //       )
//         //     :
//         LoginBaseConstant(
//       onTap: () {
//         Navigator.push(
//           context,
//           PageRouteBuilder(
//             transitionDuration: Duration(milliseconds: 500),
//             pageBuilder: (context, animation, secondaryAnimation) =>
//                 ForgotPassScreen(),
//             transitionsBuilder:
//                 (context, animation, secondaryAnimation, child) {
//               const begin = Offset(1.0, 0.0);
//               const end = Offset.zero;
//               const curve = Curves.ease;
//               var tween =
//                   Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//               return SlideTransition(
//                 position: animation.drive(tween),
//                 child: child,
//               );
//             },
//           ),
//         );
//         // Navigator.push(context,
//         //  MaterialPageRoute(builder: (context) => ForgotPassScreen()));
//       },
//       titleText: AppString.login,
//       textAction: AppString.forgotpass,
//       textActionPadding:
//           EdgeInsets.only(left: MediaQuery.of(context).size.width / 5.5),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           LoginOptionWidget(
//             selectedIndex: _selectedIndex,
//             handleSelected: _handleSelected,
//           ),
//
//           ///todo prachi & saloni
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                   vertical: 10,
//                   horizontal: MediaQuery.of(context).size.width / 28),
//               child: PageView(
//                 controller: _pageController,
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   /// Page 1: Log in with mail
//                   Container(
//                     //color: Colors.red,
//                     child: Form(
//                       key: _formKey,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SizedBox(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.1,
//                                   child: TextFormField(
//                                     style: GoogleFonts.firaSans(
//                                       color: Color(0xff000000).withOpacity(0.5),
//                                       fontWeight: FontWeightManager.medium,
//                                       fontSize: FontSize.s14,
//                                     ),
//                                     focusNode: emailFocusNode,
//                                     onFieldSubmitted: (_) {
//                                       FocusScope.of(context)
//                                           .requestFocus(passwordFocusNode);
//                                     },
//                                     cursorColor: Colors.black,
//                                     cursorHeight: 22,
//                                     controller: _emailController,
//                                     keyboardType: TextInputType.emailAddress,
//                                     decoration: InputDecoration(
//                                       contentPadding:
//                                           const EdgeInsets.only(top: 1),
//                                       focusedBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Color(0xff000000)
//                                                 .withOpacity(0.5),
//                                             width: 0.5),
//                                       ),
//                                       enabledBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Color(0xff000000)
//                                                 .withOpacity(0.5),
//                                             width: 0.5),
//                                       ),
//                                       labelText: AppString.email,
//                                       labelStyle: GoogleFonts.firaSans(
//                                         color:
//                                             Color(0xff000000).withOpacity(0.3),
//                                         fontSize: FontSize.s14,
//                                         fontWeight: FontWeightManager.medium,
//                                       ),
//                                     ),
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return AppString.enteremail;
//                                       }
//                                       if (!emailRegex.hasMatch(value)) {
//                                         return AppString.entervalidemail;
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.1,
//                                   child: TextFormField(
//                                     style: GoogleFonts.firaSans(
//                                       color: Color(0xff000000).withOpacity(0.5),
//                                       fontWeight: FontWeightManager.medium,
//                                       fontSize: FontSize.s14,
//                                     ),
//                                     focusNode: passwordFocusNode,
//                                     onFieldSubmitted: (_) {
//                                       AuthService.loginWithEmail(
//                                         context,
//                                         _emailController,
//                                         _passwordController,
//                                         _isLoading,
//                                         (value) =>
//                                             setState(() => _isLoading = value),
//                                         (message) => setState(
//                                             () => _errorMessage = message),
//                                       );
//                                       // _loginWithEmail();
//                                     },
//                                     cursorColor: Colors.black,
//                                     controller: _passwordController,
//                                     keyboardType: TextInputType.visiblePassword,
//                                     obscuringCharacter: '*',
//                                     cursorHeight: 22,
//                                     decoration: InputDecoration(
//                                       contentPadding:
//                                           const EdgeInsets.only(top: 2),
//                                       focusedBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Color(0xff000000)
//                                                 .withOpacity(0.5),
//                                             width: 0.5),
//                                       ),
//                                       labelText: AppString.password,
//                                       labelStyle:
//                                           CustomTextStylesCommon.commonStyle(
//                                         color:
//                                             Color(0xff000000).withOpacity(0.3),
//                                         fontSize: FontSize.s14,
//                                         fontWeight: FontWeightManager.medium,
//                                       ),
//                                       enabledBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Color(0xff000000)
//                                                 .withOpacity(0.5),
//                                             width: 0.5),
//                                       ),
//                                       suffixIcon: IconButton(
//                                         icon: _isPasswordVisible
//                                             ? Icon(
//                                                 Icons.visibility_off_outlined,
//                                                 color: ColorManager.whitesheed,
//                                               )
//                                             : Icon(
//                                                 Icons.visibility_outlined,
//                                                 color: ColorManager.whitesheed,
//                                               ),
//                                         onPressed: () {
//                                           setState(() {
//                                             _isPasswordVisible =
//                                                 !_isPasswordVisible;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return AppString.enterpass;
//                                       }
//                                       return null;
//                                     },
//                                     obscureText: !_isPasswordVisible,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             _isLoading
//                                 ? Center(
//                                     child: SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height /
//                                               25,
//                                       width:
//                                           MediaQuery.of(context).size.height /
//                                               25,
//                                       child: CircularProgressIndicator(
//                                           color: ColorManager.blueiconColor),
//                                     ),
//                                   )
//                                 : !_loginSuccessful
//                                     ? Center(
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(14),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Color(0x40000000),
//                                                 offset: Offset(0, 4),
//                                                 blurRadius: 4,
//                                                 spreadRadius: 0,
//                                               ),
//                                             ],
//                                           ),
//                                           child: CustomButton(
//                                             borderRadius: 28,
//                                             height: MediaQuery.of(context)
//                                                     .size
//                                                     .height /
//                                                 20,
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .height /
//                                                 5.5,
//                                             text: AppString.loginbtn,
//                                             onPressed: () {
//                                               if (_formKey.currentState!
//                                                   .validate()) {
//                                                 setState(() {
//                                                   _isLoading = true;
//                                                   _errorMessage = null;
//                                                 });
//                                                 AuthService.loginWithEmail(
//                                                   context,
//                                                   _emailController,
//                                                   _passwordController,
//                                                   _isLoading,
//                                                   (value) => setState(
//                                                       () => _isLoading = value),
//                                                   (message) => setState(() =>
//                                                       _errorMessage = message),
//                                                 );
//                                                 // _loginWithEmail();
//                                               }
//                                               print(AppString.btnpress);
//                                             },
//                                           ),
//                                         ),
//                                       )
//                                     : SizedBox(),
//                             if (_errorMessage != null)
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   top: MediaQuery.of(context).size.height / 99,
//                                 ),
//                                 child: Text(
//                                   _errorMessage!,
//                                   textAlign: TextAlign.center,
//                                   style: GoogleFonts.firaSans(
//                                       color: ColorManager.red,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize:
//                                           MediaQuery.of(context).size.width /
//                                               110),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   /// Page 2: Log in with authenticator
//                   Form(
//                     key: _formKeyAuth,
//                     child: Container(
//                       width: MediaQuery.of(context).size.width / 4,
//                       height: MediaQuery.of(context).size.height / 4,
//                       // color: Colors.blue,
//                       child: Center(
//                         child: Column(
//                           children: _showEmailInput
//                               ? [
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: AppPadding.p5),
//                                     child: TextFormField(
//                                       style: CustomTextStylesCommon.commonStyle(
//                                         color:
//                                             Color(0xff000000).withOpacity(0.5),
//                                         fontWeight: FontWeightManager.medium,
//                                         fontSize: FontSize.s14,
//                                       ),
//                                       focusNode: emailFocusNode,
//                                       controller: _emailController,
//                                       cursorColor: Colors.black,
//                                       cursorHeight: 22,
//                                       decoration: InputDecoration(
//                                         contentPadding:
//                                             const EdgeInsets.only(top: 1),
//                                         focusedBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                               color: Color(0xff000000)
//                                                   .withOpacity(0.5),
//                                               width: 0.5),
//                                         ),
//                                         labelText: AppString.email,
//                                         labelStyle:
//                                             CustomTextStylesCommon.commonStyle(
//                                           color: Color(0xff000000)
//                                               .withOpacity(0.3),
//                                           fontSize: FontSize.s14,
//                                           fontWeight: FontWeightManager.medium,
//                                         ),
//                                       ),
//                                       validator: (value) {
//                                         if (value == null || value.isEmpty) {
//                                           return AppString.enteremail;
//                                         }
//                                         if (!emailRegex.hasMatch(value)) {
//                                           return AppString.entervalidemail;
//                                         }
//                                         return null;
//                                       },
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height:
//                                         MediaQuery.of(context).size.height / 15,
//                                   ),
//
//                                   ///next button
//                                   Center(
//                                       child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(14),
//                                     ),
//                                     child: CustomButton(
//                                       borderRadius: 28,
//                                       height:
//                                           MediaQuery.of(context).size.height /
//                                               20,
//                                       width:
//                                           MediaQuery.of(context).size.height /
//                                               5.5,
//                                       text: AppString.next,
//                                       onPressed: () {
//                                         if (_formKey.currentState?.validate() ??
//                                             false) {
//                                           setState(() {
//                                             _showEmailInput = false;
//                                           });
//                                           _handleNextButton();
//                                         }
//                                       },
//                                     ),
//                                   ))
//                                 ]
//                               : [
//                                   ///
//                                   Center(
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: List.generate(
//                                         4,
//                                         (index) => Container(
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width /
//                                               40,
//                                           height: AppSize.s40,
//                                           margin: EdgeInsets.symmetric(
//                                               horizontal: AppPadding.p10),
//                                           decoration: BoxDecoration(),
//                                           child: TextFormField(
//                                             controller: _otpControllers[index],
//                                             cursorColor: ColorManager.black,
//                                             inputFormatters: [
//                                               FilteringTextInputFormatter.allow(
//                                                 RegExp(r'[0-9]'),
//                                               ),
//                                             ],
//                                             keyboardType: TextInputType.number,
//                                             textAlign: TextAlign.center,
//                                             maxLength: 1,
//                                             decoration: InputDecoration(
//                                               contentPadding:
//                                                   const EdgeInsets.only(top: 2),
//                                               counterText: '',
//                                               focusedBorder:
//                                                   UnderlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                   color: ColorManager.black,
//                                                   width: 2,
//                                                 ),
//                                               ),
//                                             ),
//                                             validator: (value) {
//                                               return value!.isEmpty
//                                                   ? AppString.otp
//                                                   : null;
//                                             },
//                                             onChanged: (value) {
//                                               if (value.isNotEmpty &&
//                                                   index < 3) {
//                                                 FocusScope.of(context)
//                                                     .nextFocus();
//                                               } else if (value.isNotEmpty &&
//                                                   index == 3) {
//                                                 String enteredOTP =
//                                                     _otpControllers
//                                                         .map((controller) =>
//                                                             controller.text)
//                                                         .join();
//                                                 bool anyFieldEmpty =
//                                                     _otpControllers
//                                                         .any((controller) =>
//                                                             controller
//                                                                 .text.isEmpty);
//                                                 if (!anyFieldEmpty &&
//                                                     (_formKey.currentState
//                                                             ?.validate() ??
//                                                         false)) {
//                                                   VerifyOTPService
//                                                       .verifyOTPAndLogin(
//                                                     context,
//                                                     _emailController.text,
//                                                     enteredOTP,
//                                                     (message) {
//                                                       print(message);
//                                                     },
//                                                   );
//                                                   // _verifyOTPAndLogin(
//                                                   //   _emailController.text,
//                                                   //   enteredOTP,
//                                                   // );
//                                                 }
//                                               }
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//
//                                   SizedBox(
//                                     height:
//                                         MediaQuery.of(context).size.height / 20,
//                                   ),
//
//                                   ///resend
//                                   RichText(
//                                     text: TextSpan(
//                                       style: CustomTextStylesCommon.commonStyle(
//                                         fontSize: FontSize.s10,
//                                         fontWeight: FontWeight.w600,
//                                         color: ColorManager.grey,
//                                       ),
//                                       children: [
//                                         TextSpan(
//                                           text: AppString.didntreccode,
//                                         ),
//                                         TextSpan(
//                                           text: AppString.resend,
//                                           style: GoogleFonts.firaSans(
//                                             color: ColorManager.blueprime,
//                                           ),
//                                           recognizer: TapGestureRecognizer()
//                                             ..onTap = () {
//                                               // Handle resend OTP
//                                             },
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height:
//                                         MediaQuery.of(context).size.height / 20,
//                                   ),
//
//                                   ///login button auth
//                                   if (_errorLoginMessage != null)
//                                     Text(_errorLoginMessage!,
//                                         style: TextStyle(color: Colors.red)),
//                                   if (!_isLoggingIn)
//                                     Center(
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(14),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Color(0x40000000),
//                                               offset: Offset(0, 4),
//                                               blurRadius: 4,
//                                               spreadRadius: 0,
//                                             ),
//                                           ],
//                                         ),
//                                         child: CustomButton(
//                                           borderRadius: 28,
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .height /
//                                               20,
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .height /
//                                               5.5,
//                                           text: AppString.loginbtn,
//                                           onPressed: () async {
//                                             String enteredEmail =
//                                                 _emailController.text;
//                                             String enteredOTP = _otpControllers
//                                                 .map((controller) =>
//                                                     controller.text)
//                                                 .join();
//                                             bool anyFieldEmpty = _otpControllers
//                                                 .any((controller) =>
//                                                     controller.text.isEmpty);
//
//                                             if (!anyFieldEmpty &&
//                                                 (_formKey.currentState
//                                                         ?.validate() ??
//                                                     false)) {
//                                               setState(() {
//                                                 _isLoggingIn = true;
//                                                 _errorLoginMessage = null;
//                                               });
//                                               await VerifyOTPService
//                                                   .verifyOTPAndLogin(
//                                                 context,
//                                                 _emailController.text,
//                                                 // enteredEmail,
//                                                 enteredOTP,
//                                                 (message) {
//                                                   print(message);
//                                                 },
//                                               );
//                                               // _verifyOTPAndLogin(
//                                               //   enteredEmail,
//                                               //   enteredOTP,
//                                               // );
//
//                                               /// After the login attempt is completed
//                                               setState(() {
//                                                 /// Reset login in progress
//                                                 _isLoggingIn = false;
//
//                                                 /// Show error message if exists
//                                                 if (_errorLoginMessage ==
//                                                     null) {
//                                                   /// Show loader if no error
//                                                   _isLoading = true;
//                                                 }
//                                               });
//                                             }
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   if (_isLoggingIn)
//                                     CircularProgressIndicator(
//                                         color: ColorManager.blueprime),
//                                 ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
