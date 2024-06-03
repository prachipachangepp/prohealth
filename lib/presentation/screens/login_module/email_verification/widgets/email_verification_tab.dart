// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../../../../../app/resources/color.dart';
// import '../../../../../app/resources/const_string.dart';
// import '../../../../../app/resources/font_manager.dart';
// import '../../../../../app/resources/theme_manager.dart';
// import '../../../../../app/resources/value_manager.dart';
// import '../../../../../app/services/login_flow_api/verify_otp/verify_otp_manager.dart';
// import '../../../desktop_module/hr_module/manage/widgets/custom_icon_button_constant.dart';
// import '../../../desktop_module/widgets/login_screen/menu_login_page.dart';
// import '../../../tablet_module/login_screen_flow/tab_pass_login.dart';
// import '../../../tablet_module/tab_const.dart';
//
// class EmailVerifyTab extends StatefulWidget {
//   final String? email;
//   const EmailVerifyTab({super.key, this.email});
//
//   @override
//   State<EmailVerifyTab> createState() => _EmailVerifyTabState(email: email!);
// }
//
// class _EmailVerifyTabState extends State<EmailVerifyTab> {
//   List<TextEditingController> _otpControllers =
//   List.generate(4, (_) => TextEditingController());
//   bool _isVerifyingOTP = false;
//   String? _errorMessage;
//   final String email;
//   _EmailVerifyTabState({required this.email});
//
//   Future<void> _verifyOTPAndLogin() async {
//     setState(() {
//       _isVerifyingOTP = true;
//       _errorMessage = null;
//     });
//     String enteredOTP =
//     _otpControllers.map((controller) => controller.text).join();
//     var result = await VerifyOtpService.verifyOTPAndLogin(
//       email: widget.email!,
//       otp: enteredOTP,
//     );
//     if (result["success"]) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => MenuScreen(),
//         ),
//       );
//     } else {
//       setState(() {
//         _errorMessage = result["message"];
//       });
//     }
//     setState(() {
//       _isVerifyingOTP = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LoginBaseConstTab(
//       titleText: AppString.verification,
//       onTap: (){},
//       textAction: '',
//       childTab: Material(
//         elevation: 4,
//         borderRadius: BorderRadius.circular(24),
//         child: Container(
//           height: MediaQuery.of(context).size.height / 3,
//           width: MediaQuery.of(context).size.width/2,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(24),
//             color: ColorManager.white,
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   AppString.enter4digitcode,
//                   style: CustomTextStylesCommon.commonStyle(
//                       color: ColorManager.darkgrey,
//                       fontSize: FontSize.s12,
//                       fontWeight: FontWeightManager.bold),
//                 ),
//
//                 ///txtfield
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(
//                     4,
//                         (index) => Container(
//                       width: MediaQuery.of(context).size.width / 35,
//                       height: MediaQuery.of(context).size.height / 22,
//                       margin: EdgeInsets.symmetric(horizontal: AppPadding.p10),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(2.26),
//                         border: Border.all(
//                           color: ColorManager.bluecontainer,
//                           width: 0.85,
//                         ),
//                       ),
//                       child: TextFormField(
//                         controller: _otpControllers[index],
//                         cursorColor: ColorManager.black,
//                         cursorHeight: 20,
//                         cursorWidth: 2,
//                         cursorRadius: Radius.circular(1),
//                         inputFormatters: [
//                           FilteringTextInputFormatter.allow(
//                             RegExp(r'[0-9]'),
//                           ),
//                         ],
//                         keyboardType: TextInputType.number,
//                         textAlign: TextAlign.center,
//                         textAlignVertical: TextAlignVertical.center,
//                         maxLength: 1,
//                         decoration: InputDecoration(
//                           contentPadding:
//                           const EdgeInsets.only(bottom: AppSize.s15),
//                           counterText: '',
//                           focusedBorder: InputBorder.none,
//                           enabledBorder: InputBorder.none,
//                           errorBorder: InputBorder.none,
//                           disabledBorder: InputBorder.none,
//                         ),
//                         validator: (value) {
//                           return value!.isEmpty ? AppString.otp : null;
//                         },
//                         onChanged: (value) {
//                           if (value.isNotEmpty && index < 3) {
//                             FocusScope.of(context).nextFocus();
//                           } else if (value.isNotEmpty && index == 3) {
//                             _verifyOTPAndLogin();
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 ///didnt receive code
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(AppString.didntrecieveCode,
//                         style: CodeVerficationText.VerifyCode(context)),
//                     TextButton(
//                       onPressed: () {},
//                       child: Text(AppString.resend,
//                           style: CustomTextStylesCommon.commonStyle(
//                             color: ColorManager.blueprime,
//                             fontSize: FontSize.s10,
//                             fontWeight: FontWeightManager.semiBold,
//                           )),
//                     )
//                   ],
//                 ),
//
//                 ///button
//                 CustomButton(
//                   borderRadius: 24,
//                   height: MediaQuery.of(context).size.height / 22,
//                   width: MediaQuery.of(context).size.height / 6,
//                   text:
//                   _isVerifyingOTP ? AppString.verify : AppString.loginbtn,
//                   onPressed: () {
//                     _verifyOTPAndLogin();
//                   },
//                 ),
//                 if (_errorMessage != null)
//                   Padding(
//                     padding: const EdgeInsets.all(AppPadding.p8),
//                     child: Text(
//                       _errorMessage!,
//                       style: CustomTextStylesCommon.commonStyle(
//                         color: ColorManager.red,
//                         fontSize: FontSize.s10,
//                         fontWeight: FontWeightManager.bold,
//                       ),
//                     ),
//                   ),
//
//                 ///bottomtxt
//                 InkWell(
//                   child: Text(
//                     AppString.donthaveauth,
//                     style: CustomTextStylesCommon.commonStyle(
//                       color: ColorManager.blueprime,
//                       fontSize: FontSize.s10,
//                       fontWeight: FontWeightManager.medium,
//                     ),
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       PageRouteBuilder(
//                         transitionDuration: Duration(milliseconds: 500),
//                         pageBuilder: (context, animation, secondaryAnimation) =>
//                             TabPassLoginScreen(email: email),
//                         transitionsBuilder:
//                             (context, animation, secondaryAnimation, child) {
//                           const begin = Offset(1.0, 0.0);
//                           const end = Offset.zero;
//                           const curve = Curves.ease;
//                           var tween = Tween(begin: begin, end: end)
//                               .chain(CurveTween(curve: curve));
//                           return SlideTransition(
//                             position: animation.drive(tween),
//                             child: child,
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
