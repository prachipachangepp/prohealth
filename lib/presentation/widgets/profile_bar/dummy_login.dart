// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/color.dart';
// import 'package:prohealth/app/services/login_flow_api/get_otp/getotp_manager.dart';
// import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
// import 'package:prohealth/presentation/widgets/login_screen/verify_screen.dart';
//
// import '../../../app/resources/const_string.dart';
// import '../../../app/resources/font_manager.dart';
// import '../../../app/resources/theme_manager.dart';
//
// class DumLoginconst extends StatelessWidget {
//   final Widget child;
//   final String titleText;
//   final VoidCallback onTap;
//   final String textAction;
//   final EdgeInsetsGeometry? textActionPadding;
//   final SvgPicture backImg = SvgPicture.asset("images/background.svg");
//   // final Widget childimg;
//   DumLoginconst({
//     required this.child,
//     required this.onTap,
//     // required this.child2,
//     required this.titleText,
//     required this.textAction,
//     this.textActionPadding,
//     // required this.childimg
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: 0,
//       child: Stack(children: [
//         Container(
//             //height: double.maxFinite,
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
//                            color: Colors.green,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(25),
//                                 topLeft: Radius.circular(25)),
//                           ),
//                           child: child,
//                         )),
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                           decoration: BoxDecoration(
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
//                                   // width: MediaQuery.of(context).size.width / 1.7,
//                                   // height:
//                                   //     MediaQuery.of(context).size.height / 1.7,
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
//         )
//       ]),
//     );
//   }
// }
//
// class DumLogInScreen extends StatefulWidget {
//   const DumLogInScreen({Key? key}) : super(key: key);
//
//   @override
//   State<DumLogInScreen> createState() => _DumLogInScreenState();
// }
//
// class _DumLogInScreenState extends State<DumLogInScreen> {
//   final TextEditingController _emailController = TextEditingController();
//
//   FocusNode fieldOne = FocusNode();
//   FocusNode fieldTow = FocusNode();
//   final _formKey = GlobalKey<FormState>();
//   bool isPasswordVisible = true;
//   bool _showEmailInput = true;
//   bool _isSendingEmail = false;
//   FocusNode emailFocusNode = FocusNode();
//   FocusNode passwordFocusNode = FocusNode();
//   String? otpFromRunTab;
//   final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
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
//   @override
//   Widget build(BuildContext context) {
//     return DumLoginconst(
//       onTap: () {},
//       titleText: 'Log In',
//       textAction: '',
//       child: Padding(
//         padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               AppString.login,
//               style: GoogleFonts.firaSans(
//                 color: ColorManager.mediumgrey,
//                 fontSize: 40,
//                 fontWeight: FontWeightManager.extrabold,
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 60),
//             Material(
//               elevation: 4,
//               borderRadius: BorderRadius.circular(24),
//               child: Container(
//                 width: MediaQuery.of(context).size.width / 3.5,
//                 height: MediaQuery.of(context).size.height / 3,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(24),
//                   color: Colors.white,
//                 ),
//                 child: Form(
//                     key: _formKey,
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           ///textfield Email
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                               vertical: MediaQuery.of(context).size.height / 80,
//                               horizontal:
//                                   MediaQuery.of(context).size.width / 30,
//                             ),
//                             child: TextFormField(
//                               style: CustomTextStylesCommon.commonStyle(
//                                 color: Color(0xff000000).withOpacity(0.5),
//                                 fontWeight: FontWeightManager.medium,
//                                 fontSize: FontSize.s14,
//                               ),
//                               focusNode: emailFocusNode,
//                               controller: _emailController,
//                               cursorColor: Colors.black,
//                               cursorHeight: 22,
//                               decoration: InputDecoration(
//                                 contentPadding: const EdgeInsets.only(top: 1),
//                                 focusedBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: Color(0xff000000).withOpacity(0.5),
//                                     width: 0.5,
//                                   ),
//                                 ),
//                                 labelText: AppString.email,
//                                 labelStyle: CustomTextStylesCommon.commonStyle(
//                                   color: Color(0xff000000).withOpacity(0.3),
//                                   fontSize: FontSize.s14,
//                                   fontWeight: FontWeightManager.medium,
//                                 ),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return AppString.enteremail;
//                                 }
//                                 if (!emailRegex.hasMatch(value)) {
//                                   return AppString.entervalidemail;
//                                 }
//                                 return null;
//                               },
//                               onFieldSubmitted: (_) async {
//                                 if (_formKey.currentState?.validate() ??
//                                     false) {
//                                   setState(() {
//                                     _isSendingEmail = true;
//                                     _showEmailInput = false;
//                                   });
//                                   try {
//                                     await GetOTPService.getOTP(
//                                         _emailController.text);
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => VerifyScreen(
//                                             email: _emailController.text),
//                                       ),
//                                     );
//                                   } catch (e) {
//                                     // Handle error
//                                     print('Error occurred: $e');
//                                   } finally {
//                                     setState(() {
//                                       _isSendingEmail = false;
//                                     });
//                                   }
//                                 }
//                               },
//                             ),
//                           ),
//                           Center(
//                             child: _isSendingEmail
//                                 ? CircularProgressIndicator(
//                                     color: ColorManager.blueprime,
//                                   )
//                                 : Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(14),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Color(0x40000000),
//                                           offset: Offset(0, 4),
//                                           blurRadius: 3,
//                                           spreadRadius: 0,
//                                         ),
//                                       ],
//                                     ),
//                                     child: CustomButton(
//                                       borderRadius: 28,
//                                       height:
//                                           MediaQuery.of(context).size.height /
//                                               18,
//                                       width:
//                                           MediaQuery.of(context).size.height /
//                                               5.3,
//                                       text: AppString.next,
//                                       onPressed: () async {
//                                         if (_formKey.currentState?.validate() ??
//                                             false) {
//                                           setState(() {
//                                             _isSendingEmail = true;
//                                             _showEmailInput = false;
//                                           });
//                                           try {
//                                             await GetOTPService.getOTP(
//                                                 _emailController.text);
//                                             Navigator.push(
//                                               context,
//                                               PageRouteBuilder(
//                                                 transitionDuration:
//                                                     Duration(milliseconds: 500),
//                                                 pageBuilder: (context,
//                                                         animation,
//                                                         secondaryAnimation) =>
//                                                     VerifyScreen(
//                                                         email: _emailController
//                                                             .text),
//                                                 transitionsBuilder: (context,
//                                                     animation,
//                                                     secondaryAnimation,
//                                                     child) {
//                                                   const begin =
//                                                       Offset(1.0, 0.0);
//                                                   const end = Offset.zero;
//                                                   const curve = Curves.ease;
//
//                                                   var tween = Tween(
//                                                           begin: begin,
//                                                           end: end)
//                                                       .chain(CurveTween(
//                                                           curve: curve));
//                                                   return SlideTransition(
//                                                     position:
//                                                         animation.drive(tween),
//                                                     child: child,
//                                                   );
//                                                 },
//                                               ),
//                                             );
//                                           } catch (e) {
//                                             // Handle error
//                                             print('Error occurred: $e');
//                                           } finally {
//                                             setState(() {
//                                               _isSendingEmail = false;
//                                             });
//                                           }
//                                         }
//                                       },
//                                     ),
//                                   ),
//                           ),
//                         ])),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
