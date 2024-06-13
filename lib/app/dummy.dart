// //

// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/svg.dart';
// //
// // class DummyScreen extends StatelessWidget {
// //   const DummyScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: Stack(
// //         children: [
// //           Align(
// //             alignment: Alignment.bottomRight,
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.end,
// //               children: [
// //                 SvgPicture.asset(
// //                   'images/vector.svg',
// //                   height: MediaQuery.of(context).size.height/1.25,
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Align(
// //             alignment: Alignment.topLeft,
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.start,
// //               children: [
// //                 SvgPicture.asset(
// //                   'images/vector1.svg',
// //                   height: MediaQuery.of(context).size.height/1,
// //                 ),
// //               ],
// //             ),
// //           ),
// //
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
//
// ///
//
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/widgets.dart';
// // import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
// //
// // class DummyScreen extends StatelessWidget {
// //   const DummyScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Expanded(
// //             flex: 1,
// //             child: Container(
// //               color: Colors.greenAccent,
// //               child: Row(
// //                 children: [
// //                   Text('Details',
// //                   style: CompanyIdentityManageHeadings.customTextStyle(context),),
// //                 ],
// //               ),
// //             ),
// //           ),
// //           Expanded(
// //             flex: 3,
// //             child: Container(
// //              // margin: EdgeInsets.only(left: 163),
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.only(
// //                   topLeft: Radius.circular(16),
// //                 ),
// //                 border: Border(
// //                   top: BorderSide(
// //                     width: 2,
// //                     color: Color(0x33000000), // #00000033
// //                   ),
// //                 ),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Color(0x40000000), // #00000040
// //                     offset: Offset(0, 4),
// //                     blurRadius: 4,
// //                     spreadRadius: 0,
// //                   ),
// //                 ],
// //                 color: Colors.white
// //               ),
// //               child: Opacity(
// //                 opacity: 0,
// //                 child: Row(),
// //               ),
// //             ),
// //           ),
// //           Expanded(
// //             flex: 1,
// //             child: Container(
// //               color: Colors.greenAccent,
// //               child: Row(
// //                 children: [
// //                   Text('Details',
// //                     style: CompanyIdentityManageHeadings.customTextStyle(context),),
// //                 ],
// //               ),
// //             ),
// //           ),
// //           Expanded(
// //               flex: 2,
// //               child: Container(color: Colors.pink,)),
// //           Expanded(
// //             flex: 1,
// //             child: Container(
// //               color: Colors.purple,
// //               child: Text('Details',
// //                 style: CompanyIdentityManageHeadings.customTextStyle(context),),
// //             ),
// //           ),
// //           Expanded(
// //             flex: 1,
// //             child: Container(
// //               color: Colors.purple,
// //               child: Text('Details',
// //                 style: CompanyIdentityManageHeadings.customTextStyle(context),),
// //             ),
// //           ),
// //
// //         ],
// //       ),
// //     );
// //   }
// // }
// ///
// import 'dart:async';
// import 'dart:convert';
// import 'dart:ui';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/color.dart';
// import 'package:prohealth/app/resources/const_string.dart';
// import 'package:prohealth/app/resources/font_manager.dart';
// import 'package:prohealth/app/resources/value_manager.dart';
//
// import '../../../../app/resources/theme_manager.dart';
// import '../presentation/screens/desktop_module/hr_module/manage/widgets/custom_icon_button_constant.dart';
// import '../presentation/screens/login_module/login/login_screen.dart';
// import 'constants/app_config.dart';
//
// class ChangePasswordScreen extends StatefulWidget {
//   final String email;
//   ChangePasswordScreen({super.key, required this.email});
//
//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }
//
// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   final TextEditingController controllerNew = TextEditingController();
//   final TextEditingController controllerConfirm = TextEditingController();
//   List<TextEditingController> _otpControllers =
//       List.generate(6, (_) => TextEditingController());
//   List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
//   bool _obscureText = true;
//   bool _obscureTextconfirm = true;
//   final _formKey = GlobalKey<FormState>();
//   FocusNode newPasswordFocusNode = FocusNode();
//   FocusNode confirmPasswordFocusNode = FocusNode();
//   String? _errorMessage;
//   late Timer _timer;
//   int _timerCount = 30;
//   bool isOtpFieldEmpty = true;
//   ConfirmPassManager confirmPassManager = ConfirmPassManager();
//   TextEditingController newPasswordController = TextEditingController();
//   List<bool> _otpFieldFilledStatus = List.generate(6, (_) => false);
//   bool _isUpdatingPassword = false;
//
//   Future<void> updatePassword(String email, String otp) async {
//     String newPassword = newPasswordController.text;
//     try {
//       var headers = {'Content-Type': 'application/json'};
//       var data = json.encode({
//         "email": email,
//         "verificationCode": otp,
//         "newPassword": newPassword
//       });
//
//       var response = await Dio().post(
//         '${AppConfig.endpoint}/auth/confirmPassword',
//         //  'https://wwx3rebc2b.execute-api.us-west-1.amazonaws.com/dev/serverlessSetup/auth/confirmPassword',
//         data: data,
//         options: Options(headers: headers),
//       );
//       if (response.statusCode == 200) {
//         print(AppString.resetsuccessfully);
//         print(json.encode(response.data));
//         // Optionally, navigate back to the login screen
//         Navigator.pop(context as BuildContext);
//       } else {
//         print('Failed to change password: ${response.statusMessage}');
//         // Print response data for debugging if needed
//         print(json.encode(response.data));
//       }
//     } catch (e) {
//       print('Error occurred: $e');
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   void startTimer() {
//     const oneSec = Duration(seconds: 1);
//     _timer = Timer.periodic(oneSec, (timer) {
//       if (_timerCount == 0) {
//         timer.cancel();
//       } else {
//         setState(() {
//           _timerCount--;
//         });
//       }
//     });
//   }
//
//   String getTimerString() {
//     int minutes = _timerCount ~/ 60;
//     int seconds = _timerCount % 60;
//     return '$minutes:${seconds.toString().padLeft(2, '0')}';
//   }
//
//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: ColorManager.white,
//           content: Container(
//             padding: EdgeInsets.only(top: AppPadding.p25),
//             height: AppSize.s300,
//             width: AppSize.s400,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'images/upload.png',
//                   width: AppSize.s120,
//                   height: AppSize.s120,
//                 ),
//                 Text(
//                   AppString.successfully,
//                   style: CustomTextStylesCommon.commonStyle(
//                     color: ColorManager.darkgrey,
//                     fontSize: FontSize.s30,
//                     fontWeight: FontWeightManager.extrabold,
//                   ),
//                 ),
//                 Text(
//                   AppString.resetsuccessfully,
//                   style: CustomTextStylesCommon.commonStyle(
//                     color: ColorManager.darkgrey,
//                     fontSize: FontSize.s12,
//                     fontWeight: FontWeightManager.medium,
//                   ),
//                 ),
//                 CustomButton(
//                   width: AppSize.s181,
//                   height: AppSize.s45,
//                   text: AppString.continuebutton,
//                   borderRadius: 24,
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginScreen()),
//                     );
//                   },
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
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
//         Center(
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: MediaQuery.of(context).size.height / 30,
//                 vertical: MediaQuery.of(context).size.width / 40),
//             child: ClipRect(
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 9, sigmaY: 5),
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
//                   child: Column(
//                     children: [
//                       ///logo & head text
//                       Padding(
//                         padding: EdgeInsets.only(
//                             right: MediaQuery.of(context).size.width / 30,
//                             left: MediaQuery.of(context).size.width / 12),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(AppString.verification,
//                                 style: CustomTextStylesCommon.commonStyle(
//                                   color: ColorManager.mediumgrey,
//                                   fontSize: FontSize.s40,
//                                   fontWeight: FontWeightManager.extrabold,
//                                 )),
//                             Image.asset(
//                               'images/logo_login.png',
//                               width: MediaQuery.of(context).size.width / 5,
//                               height: MediaQuery.of(context).size.height / 5,
//                             )
//                           ],
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ///todo saloni
//                               ///main container
//                               Material(
//                                 elevation: 9,
//                                 borderRadius: BorderRadius.circular(24),
//                                 child: Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       width: MediaQuery.of(context).size.width /
//                                           3.5,
//                                       height:
//                                           MediaQuery.of(context).size.height /
//                                               1.6,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(24),
//                                           color: ColorManager.white,
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
//
//                                       ///column
//                                       child: Padding(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: MediaQuery.of(context)
//                                                     .size
//                                                     .width /
//                                                 30,
//                                             vertical: MediaQuery.of(context)
//                                                     .size
//                                                     .height /
//                                                 40),
//                                         child: Form(
//                                           key: _formKey,
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(AppString.entersixdigitCode,
//                                                   style: CustomTextStylesCommon
//                                                       .commonStyle(
//                                                     color:
//                                                         ColorManager.mediumgrey,
//                                                     fontSize: FontSize.s10,
//                                                     fontWeight:
//                                                         FontWeightManager
//                                                             .semiBold,
//                                                   )),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: List.generate(
//                                                   6,
//                                                   (index) => Container(
//                                                     width:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .width /
//                                                             40,
//                                                     height: 40,
//                                                     margin: EdgeInsets.symmetric(
//                                                         horizontal:
//                                                             MediaQuery.of(
//                                                                         context)
//                                                                     .size
//                                                                     .width /
//                                                                 200),
//                                                     decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               2),
//                                                       border: Border.all(
//                                                         color:
//                                                             Color(0xff9BADCA),
//                                                         width: 0.55,
//                                                       ),
//                                                     ),
//                                                     child: TextFormField(
//                                                       style:
//                                                           CustomTextStylesCommon
//                                                               .commonStyle(
//                                                         color: Color(0xff000000)
//                                                             .withOpacity(0.7),
//                                                         fontSize: FontSize.s12,
//                                                         fontWeight:
//                                                             FontWeightManager
//                                                                 .medium,
//                                                       ),
//                                                       controller:
//                                                           _otpControllers[
//                                                               index],
//                                                       cursorColor:
//                                                           ColorManager.black,
//                                                       inputFormatters: [
//                                                         FilteringTextInputFormatter
//                                                             .allow(RegExp(
//                                                                 r'[0-9]')),
//                                                       ],
//                                                       keyboardType:
//                                                           TextInputType.number,
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       maxLength: 1,
//                                                       focusNode:
//                                                           _focusNodes[index],
//                                                       decoration:
//                                                           InputDecoration(
//                                                         contentPadding:
//                                                             const EdgeInsets
//                                                                 .only(
//                                                                 bottom:
//                                                                     AppPadding
//                                                                         .p10),
//                                                         counterText: '',
//                                                         border:
//                                                             InputBorder.none,
//                                                       ),
//                                                       validator: (value) {
//                                                         return value!.isEmpty
//                                                             ? AppString.enterotp
//                                                             : null;
//                                                       },
//                                                       onChanged: (value) {
//                                                         _otpFieldFilledStatus[
//                                                                 index] =
//                                                             value.isNotEmpty;
//                                                         bool allFieldsFilled =
//                                                             _otpFieldFilledStatus
//                                                                 .every(
//                                                                     (filled) =>
//                                                                         filled);
//                                                         setState(() {
//                                                           isOtpFieldEmpty =
//                                                               !allFieldsFilled;
//                                                         });
//                                                         if (value.isNotEmpty &&
//                                                             index < 5) {
//                                                           FocusScope.of(context)
//                                                               .requestFocus(
//                                                                   _focusNodes[
//                                                                       index +
//                                                                           1]);
//                                                         } else if (value
//                                                                 .isNotEmpty &&
//                                                             index == 5) {
//                                                           FocusScope.of(context)
//                                                               .requestFocus(
//                                                                   newPasswordFocusNode);
//                                                         }
//                                                       },
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 '${getTimerString()}',
//                                                 style: CustomTextStylesCommon
//                                                     .commonStyle(
//                                                   color: ColorManager.orange,
//                                                   fontSize: FontSize.s8,
//                                                   fontWeight: FontWeightManager
//                                                       .semiBold,
//                                                 ),
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   Text(
//                                                       AppString
//                                                           .didntrecieveCode,
//                                                       style: CodeVerficationText
//                                                           .VerifyCode(context)),
//                                                   TextButton(
//                                                     onPressed: () {
//                                                       print("Resend tapped!");
//                                                     },
//                                                     child: Text(
//                                                         AppString.resend,
//                                                         style:
//                                                             CustomTextStylesCommon
//                                                                 .commonStyle(
//                                                           color: ColorManager
//                                                               .blueprime,
//                                                           fontSize:
//                                                               FontSize.s10,
//                                                           fontWeight:
//                                                               FontWeightManager
//                                                                   .semiBold,
//                                                         )),
//                                                   )
//                                                 ],
//                                               ),
//                                               Divider(),
//                                               Text(
//                                                 AppString.setnewPassword,
//                                                 style: GoogleFonts.firaSans(
//                                                   color: isOtpFieldEmpty
//                                                       ? Colors.grey
//                                                       : ColorManager.mediumgrey,
//                                                   fontSize: FontSize.s10,
//                                                   fontWeight: FontWeightManager
//                                                       .semiBold,
//                                                 ),
//                                               ),
//                                               TextFormField(
//                                                 style: CustomTextStylesCommon
//                                                     .commonStyle(
//                                                   color: ColorManager.black
//                                                       .withOpacity(0.5),
//                                                   fontSize: FontSize.s14,
//                                                   fontWeight:
//                                                       FontWeightManager.medium,
//                                                 ),
//                                                 focusNode: newPasswordFocusNode,
//                                                 onFieldSubmitted: (_) {
//                                                   FocusScope.of(context)
//                                                       .requestFocus(
//                                                           confirmPasswordFocusNode);
//                                                 },
//                                                 cursorHeight: 22,
//                                                 obscuringCharacter: '*',
//                                                 controller: controllerNew,
//                                                 cursorColor: Colors.black,
//                                                 obscureText: _obscureText,
//                                                 decoration: InputDecoration(
//                                                   contentPadding:
//                                                       const EdgeInsets.only(
//                                                           top: 2),
//                                                   suffixIcon: IconButton(
//                                                     icon: Icon(
//                                                       _obscureText
//                                                           ? Icons
//                                                               .visibility_outlined
//                                                           : Icons
//                                                               .visibility_off_outlined,
//                                                       size: AppSize.s15,
//                                                       color: Color(0xffACA5BB),
//                                                     ),
//                                                     onPressed: () {
//                                                       setState(() {
//                                                         _obscureText =
//                                                             !_obscureText;
//                                                       });
//                                                     },
//                                                   ),
//                                                   labelText:
//                                                       AppString.enternewpass,
//                                                   labelStyle:
//                                                       CustomTextStylesCommon
//                                                           .commonStyle(
//                                                     color: isOtpFieldEmpty
//                                                         ? Colors.grey
//                                                         : ColorManager.darkgrey,
//                                                     fontSize: FontSize.s14,
//                                                     fontWeight:
//                                                         FontWeightManager
//                                                             .medium,
//                                                   ),
//                                                   border: UnderlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                         color: Colors.black),
//                                                   ),
//                                                   focusedBorder:
//                                                       UnderlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                         color: Color(0xff000000)
//                                                             .withOpacity(0.5),
//                                                         width: 0.5),
//                                                   ),
//                                                   enabledBorder:
//                                                       UnderlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                         color: Colors.grey),
//                                                   ),
//                                                 ),
//                                                 validator: (value) {
//                                                   if (value == null ||
//                                                       value.isEmpty) {
//                                                     return AppString.enterpass;
//                                                   }
//                                                   return null;
//                                                 },
//                                               ),
//                                               TextFormField(
//                                                 focusNode:
//                                                     confirmPasswordFocusNode,
//                                                 onFieldSubmitted: (_) {
//                                                   _showSuccessDialog();
//                                                 },
//                                                 // onChanged: (value) {
//                                                 //   if (_formKey.currentState!.validate()) {
//                                                 //     _showSuccessDialog();
//                                                 //   }
//                                                 // },
//                                                 cursorHeight: 22,
//                                                 obscuringCharacter: '*',
//                                                 controller: controllerConfirm,
//                                                 style: CustomTextStylesCommon
//                                                     .commonStyle(
//                                                   color: ColorManager.black
//                                                       .withOpacity(0.5),
//                                                   fontSize: FontSize.s14,
//                                                   fontWeight:
//                                                       FontWeightManager.medium,
//                                                 ),
//                                                 cursorColor: ColorManager.black,
//                                                 obscureText:
//                                                     _obscureTextconfirm,
//                                                 decoration: InputDecoration(
//                                                   contentPadding:
//                                                       const EdgeInsets.only(
//                                                           top: 2),
//                                                   suffixIcon: IconButton(
//                                                     icon: Icon(
//                                                       _obscureTextconfirm
//                                                           ? Icons
//                                                               .visibility_outlined
//                                                           : Icons
//                                                               .visibility_off_outlined,
//                                                       size: AppSize.s15,
//                                                       color: Color(0xffACA5BB),
//                                                     ),
//                                                     onPressed: () {
//                                                       setState(() {
//                                                         _obscureTextconfirm =
//                                                             !_obscureTextconfirm;
//                                                       });
//                                                     },
//                                                   ),
//                                                   labelText:
//                                                       AppString.confmpass,
//                                                   labelStyle:
//                                                       CustomTextStylesCommon
//                                                           .commonStyle(
//                                                     color: isOtpFieldEmpty
//                                                         ? Colors.grey
//                                                         : ColorManager.darkgrey,
//                                                     fontSize: FontSize.s14,
//                                                     fontWeight:
//                                                         FontWeightManager
//                                                             .medium,
//                                                   ),
//                                                   border: UnderlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                         color: Colors.black),
//                                                   ),
//                                                   focusedBorder:
//                                                       UnderlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                         color: Color(0xff000000)
//                                                             .withOpacity(0.5),
//                                                         width: 0.5),
//                                                   ),
//                                                   enabledBorder:
//                                                       UnderlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                         color:
//                                                             ColorManager.grey),
//                                                   ),
//                                                 ),
//                                                 validator: (value) {
//                                                   if (value == null ||
//                                                       value.isEmpty) {
//                                                     return AppString
//                                                         .enterconfmpass;
//                                                   }
//                                                   return null;
//                                                 },
//                                               ),
//                                               SizedBox(height: 12),
//                                               Center(
//                                                 child: _isUpdatingPassword
//                                                     ? CircularProgressIndicator(
//                                                         color: ColorManager
//                                                             .blueprime)
//                                                     : Container(
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(14),
//                                                           boxShadow: [
//                                                             BoxShadow(
//                                                               color: Color(
//                                                                   0x40000000),
//                                                               offset:
//                                                                   Offset(0, 4),
//                                                               blurRadius: 4,
//                                                               spreadRadius: 0,
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         child: CustomButton(
//                                                           width: MediaQuery.of(
//                                                                       context)
//                                                                   .size
//                                                                   .width /
//                                                               7,
//                                                           height: MediaQuery.of(
//                                                                       context)
//                                                                   .size
//                                                                   .height /
//                                                               22,
//                                                           text: AppString
//                                                               .updatepass,
//                                                           backgroundColor:
//                                                               isOtpFieldEmpty
//                                                                   ? Colors.grey
//                                                                   : ColorManager
//                                                                       .blueprime,
//                                                           onPressed: () async {
//                                                             if (_formKey
//                                                                 .currentState!
//                                                                 .validate()) {
//                                                               if (controllerNew
//                                                                       .text !=
//                                                                   controllerConfirm
//                                                                       .text) {
//                                                                 setState(() {
//                                                                   _errorMessage =
//                                                                       AppString
//                                                                           .passdontmatch;
//                                                                 });
//                                                                 return;
//                                                               }
//                                                               setState(() {
//                                                                 _isUpdatingPassword =
//                                                                     true;
//                                                               });
//                                                               try {
//                                                                 await ConfirmPassManager()
//                                                                     .confirmPassword(
//                                                                   widget.email,
//                                                                   _otpControllers
//                                                                       .map((controller) =>
//                                                                           controller
//                                                                               .text)
//                                                                       .join(),
//                                                                   controllerNew
//                                                                       .text,
//                                                                 );
//                                                                 print(
//                                                                     '${widget.email}');
//                                                                 print(
//                                                                     '${controllerNew.text}');
//                                                                 showDialog(
//                                                                   context:
//                                                                       context,
//                                                                   builder:
//                                                                       (BuildContext
//                                                                           context) {
//                                                                     return AlertDialog(
//                                                                       backgroundColor:
//                                                                           ColorManager
//                                                                               .white,
//                                                                       content:
//                                                                           Container(
//                                                                         padding:
//                                                                             EdgeInsets.only(top: AppPadding.p25),
//                                                                         height:
//                                                                             AppSize.s300,
//                                                                         width: AppSize
//                                                                             .s400,
//                                                                         child:
//                                                                             Column(
//                                                                           mainAxisAlignment:
//                                                                               MainAxisAlignment.spaceEvenly,
//                                                                           crossAxisAlignment:
//                                                                               CrossAxisAlignment.center,
//                                                                           children: [
//                                                                             Image.asset(
//                                                                               'images/upload.png',
//                                                                               width: AppSize.s120,
//                                                                               height: AppSize.s120,
//                                                                             ),
//                                                                             Text(
//                                                                               AppString.successfully,
//                                                                               style: CustomTextStylesCommon.commonStyle(
//                                                                                 color: ColorManager.darkgrey,
//                                                                                 fontSize: FontSize.s30,
//                                                                                 fontWeight: FontWeightManager.extrabold,
//                                                                               ),
//                                                                             ),
//                                                                             Text(
//                                                                               AppString.resetsuccessfully,
//                                                                               style: CustomTextStylesCommon.commonStyle(
//                                                                                 color: ColorManager.darkgrey,
//                                                                                 fontSize: FontSize.s12,
//                                                                                 fontWeight: FontWeightManager.medium,
//                                                                               ),
//                                                                             ),
//                                                                             CustomButton(
//                                                                               width: AppSize.s181,
//                                                                               height: AppSize.s45,
//                                                                               text: AppString.continuebutton,
//                                                                               borderRadius: 24,
//                                                                               onPressed: () {
//                                                                                 Navigator.push(
//                                                                                   context,
//                                                                                   MaterialPageRoute(builder: (context) => LoginScreen()),
//                                                                                 );
//                                                                               },
//                                                                             )
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                     );
//                                                                   },
//                                                                 );
//                                                               } catch (e) {
//                                                                 AlertDialog(
//                                                                   backgroundColor:
//                                                                       ColorManager
//                                                                           .white,
//                                                                   content:
//                                                                       Container(
//                                                                     padding: EdgeInsets.only(
//                                                                         top: AppPadding
//                                                                             .p10),
//                                                                     height:
//                                                                         AppSize
//                                                                             .s300,
//                                                                     width: AppSize
//                                                                         .s400,
//                                                                     child:
//                                                                         Column(
//                                                                       mainAxisAlignment:
//                                                                           MainAxisAlignment
//                                                                               .spaceEvenly,
//                                                                       crossAxisAlignment:
//                                                                           CrossAxisAlignment
//                                                                               .center,
//                                                                       children: [
//                                                                         Text(
//                                                                           AppString
//                                                                               .threetimepasscanchange,
//                                                                           style:
//                                                                               GoogleFonts.firaSans(
//                                                                             fontSize:
//                                                                                 FontSize.s30,
//                                                                             color:
//                                                                                 Color(0xff686464),
//                                                                             fontWeight:
//                                                                                 FontWeightManager.bold,
//                                                                           ),
//                                                                         ),
//                                                                         Text(
//                                                                           AppString
//                                                                               .cannotchangepass,
//                                                                           style:
//                                                                               CustomTextStylesCommon.commonStyle(
//                                                                             color:
//                                                                                 ColorManager.darkgrey,
//                                                                             fontSize:
//                                                                                 FontSize.s12,
//                                                                             fontWeight:
//                                                                                 FontWeightManager.medium,
//                                                                           ),
//                                                                         ),
//                                                                         CustomButton(
//                                                                           width:
//                                                                               AppSize.s181,
//                                                                           height:
//                                                                               AppSize.s45,
//                                                                           text:
//                                                                               AppString.continuebutton,
//                                                                           borderRadius:
//                                                                               24,
//                                                                           onPressed:
//                                                                               () {
//                                                                             Navigator.push(
//                                                                               context,
//                                                                               MaterialPageRoute(builder: (context) => LoginScreen()),
//                                                                             );
//                                                                           },
//                                                                         )
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 );
//                                                                 print(
//                                                                     'Error occurred while confirming password: $e');
//                                                                 // Handle error
//                                                               } finally {
//                                                                 setState(() {
//                                                                   _isUpdatingPassword =
//                                                                       false;
//                                                                 });
//                                                               }
//                                                             }
//                                                           },
//                                                         ),
//                                                       ),
//                                               ),
//                                               if (_errorMessage != null)
//                                                 Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(vertical: 8.0),
//                                                   child: Text(
//                                                     _errorMessage!,
//                                                     style: TextStyle(
//                                                         color: Colors.red),
//                                                   ),
//                                                 ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: MediaQuery.of(context).size.height / 60,
//                               ),
//
//                               ///back to login text
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     left: MediaQuery.of(context).size.width /
//                                         4.5),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     // updatePassword();
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => LoginScreen()),
//                                     );
//                                   },
//                                   child: Text(
//                                     AppString.backtologin,
//                                     textAlign: TextAlign.right,
//                                     style: CustomTextStylesCommon.commonStyle(
//                                       color: ColorManager.bluebottom,
//                                       fontSize: FontSize.s12,
//                                       fontWeight: FontWeightManager.medium,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Image.asset(
//                             'images/amico.png',
//                             width: MediaQuery.of(context).size.width / 3,
//                             height: MediaQuery.of(context).size.height / 2,
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
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
//   }
// }
