import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/login_screen/forgot_screen/change_password.dart';
import 'package:prohealth/presentation/widgets/login_screen/widgets/login_flow_base_struct.dart';

import '../login_screen.dart';

class PasswordVerifyScreen extends StatefulWidget {
  @override
  State<PasswordVerifyScreen> createState() => _PasswordVerifyScreenState();
}

class _PasswordVerifyScreenState extends State<PasswordVerifyScreen> {
  late Timer _timer;
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> _otpControllers =
  List.generate(4, (_) => TextEditingController());
  TextEditingController _otpController = TextEditingController();
  int _timerCount = 30;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_timerCount == 0) {
        timer.cancel();
      } else {
        setState(() {
          _timerCount--;
        });
      }
    });
  }

  String getTimerString() {
    int minutes = _timerCount ~/ 60;
    int seconds = _timerCount % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return LoginBaseConstant(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
      titleText: 'Password Verification',
      textAction: 'Back to login',
      textActionPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4),
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 100),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Enter your 4 digits code that you received on your email.',
                style: TextStyle(
                  fontFamily: 'FiraSans',
                  color: Color(0xff686464),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => Container(
                    width: MediaQuery.of(context).size.width/35,
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff9BADCA),
                        width: 0.55,
                      ),
                    ),
                    child: TextFormField(
                      controller: _otpControllers[index],
                      cursorColor: Colors.black,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets. only(bottom: 10),
                        counterText: '',
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        return value!.isEmpty
                            ? 'Please enter OTP'
                            : null;
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty &&
                            index < 3) {
                          FocusScope.of(context)
                              .nextFocus();
                        } else if (value.isNotEmpty &&
                            index == 3) {
                          String enteredOTP =
                          _otpControllers
                              .map((controller) =>
                          controller.text)
                              .join();
                          bool anyFieldEmpty =
                          _otpControllers
                              .any((controller) =>
                          controller
                              .text.isEmpty);
                          if (!anyFieldEmpty &&
                              (_formKey.currentState
                                  ?.validate() ??
                                  false)) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChangePasswordScreen()));
                            // _verifyOTPAndLogin(
                            //   _emailController.text,
                            //   // enteredOTP,
                            // );
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              Text(
                '${getTimerString()}',
                style: TextStyle(
                  fontFamily: 'FiraSans',
                  color: Color(0xffF2451C),
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Center(
                child: CustomButton(
                    text: 'Continue',
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ChangePasswordScreen()));
                    },
                    width: MediaQuery.of(context).size.width / 10,
                    height: MediaQuery.of(context).size.height / 22),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'FiraSans',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff686464),
                  ),
                  children: [
                    TextSpan(
                      text: 'If you didn’t receive a code! ',
                    ),
                    TextSpan(
                      text: 'Resend',
                      style: TextStyle(color: Color(0xffF2451C)),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//
// class _PasswordVerifyContent extends StatefulWidget {
//   @override
//   __PasswordVerifyContentState createState() => __PasswordVerifyContentState();
// }
//
// class __PasswordVerifyContentState extends State<_PasswordVerifyContent> {
//   late Timer _timer;
//   int _timerCount = 30;
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
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ///logo
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width / 5,
//               height: MediaQuery.of(context).size.height / 5,
//               child: Image.asset('images/logo_login.png'),
//             )
//           ],
//         ),
//         Padding(
//           padding:
//               EdgeInsets.only(left: MediaQuery.of(context).size.height / 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Verification',
//                     style: TextStyle(
//                       fontFamily: 'FiraSans',
//                       color: Color(0xff686464),
//                       fontSize: 30,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height / 100,
//                   ),
//                   Material(
//                     elevation: 9,
//                     borderRadius: BorderRadius.circular(24),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           width: 360,
//                           height: 250,
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 30, vertical: 30),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(24),
//                             color: Colors.white,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Enter your 4 digits code that you received on your email.',
//                                 style: TextStyle(
//                                   fontFamily: 'FiraSans',
//                                   color: Color(0xff686464),
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: List.generate(
//                                   4,
//                                   (index) => Container(
//                                     width: 45,
//                                     height: 40,
//                                     margin: EdgeInsets.symmetric(horizontal: 5),
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: Color(0xff9BADCA),
//                                         width: 0.55,
//                                       ),
//                                     ),
//                                     child: TextField(
//                                       inputFormatters: [
//                                         FilteringTextInputFormatter.allow(
//                                             RegExp(r'[0-9]')),
//                                       ],
//                                       keyboardType: TextInputType.number,
//                                       textAlign: TextAlign.center,
//                                       maxLength: 1,
//                                       decoration: InputDecoration(
//                                         counterText: '',
//                                         border: InputBorder.none,
//                                       ),
//                                       onChanged: (value) {},
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Text(
//                                 '${getTimerString()}',
//                                 style: TextStyle(
//                                   fontFamily: 'FiraSans',
//                                   color: Color(0xffF2451C),
//                                   fontSize: 8,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Center(
//                                 child: CustomButton(
//                                     text: 'Continue',
//                                     onPressed: () {
//                                       // Navigator.push(
//                                       //     context,
//                                       //     MaterialPageRoute(
//                                       //         builder: (context) =>
//                                       //             ChangePasswordScreen()));
//                                     },
//                                     width:
//                                         MediaQuery.of(context).size.width / 10,
//                                     height: MediaQuery.of(context).size.height /
//                                         22),
//                               ),
//                               RichText(
//                                 text: TextSpan(
//                                   style: TextStyle(
//                                     fontFamily: 'FiraSans',
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w600,
//                                     color: Color(0xff686464),
//                                   ),
//                                   children: [
//                                     TextSpan(
//                                       text: 'If you didn’t receive a code! ',
//                                     ),
//                                     TextSpan(
//                                       text: 'Resend',
//                                       style:
//                                           TextStyle(color: Color(0xffF2451C)),
//                                       recognizer: TapGestureRecognizer()
//                                         ..onTap = () {
//                                           //Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
//                                         },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height / 80,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         left: MediaQuery.of(context).size.width / 8),
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => LoginScreen()));
//                       },
//                       child: Text(
//                         'Back to login',
//                         textAlign: TextAlign.right,
//                         style: TextStyle(
//                           fontFamily: 'FiraSans',
//                           color: Color(0xff1696C8),
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               Image.asset(
//                 'images/amico.png',
//                 width: MediaQuery.of(context).size.width / 3,
//                 height: MediaQuery.of(context).size.height / 2,
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
