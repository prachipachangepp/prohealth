import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
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
  List.generate(6, (_) => TextEditingController());
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
                style: GoogleFonts.firaSans(
                   color: Color(0xff686464),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  6,
                  (index) => Container(
                    width: MediaQuery.of(context).size.width/40,
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        color: Color(0xff9BADCA),
                        width: 0.55,
                      ),
                    ),
                    child: TextFormField(
                      style:GoogleFonts.firaSans(
                        color: Color(0xff000000).withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
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
                            index < 5) {
                          FocusScope.of(context)
                              .nextFocus();
                        } else if (value.isNotEmpty &&
                            index == 5) {
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
                style: GoogleFonts.firaSans(
                  color: Color(0xffF2451C),
                  fontSize: 8,
                  fontWeight: FontWeight.w600,)
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: CustomButton(
                    borderRadius: 28,
                      text: 'Continue',
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ChangePasswordScreen()));
                      },
                      width: MediaQuery.of(context).size.width / 9,
                      height: MediaQuery.of(context).size.height / 22),
                ),
              ),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.firaSans(
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
                      style: GoogleFonts.firaSans(
                        color: Color(0xffF2451C),
                      ),
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

// import 'dart:async';
//
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
// import 'package:prohealth/presentation/widgets/login_screen/forgot_screen/change_password.dart';
// import 'package:prohealth/presentation/widgets/login_screen/widgets/login_flow_base_struct.dart';
//
// import '../login_screen.dart';
//
// class PasswordVerifyScreen extends StatefulWidget {
//   final String email;
//   PasswordVerifyScreen(this.email);
//   @override
//   State<PasswordVerifyScreen> createState() => _PasswordVerifyScreenState();
// }
//
// class _PasswordVerifyScreenState extends State<PasswordVerifyScreen> {
//   late Timer _timer;
//   final _formKey = GlobalKey<FormState>();
//   List<TextEditingController> _otpControllers =
//   List.generate(6, (_) => TextEditingController());
//   TextEditingController _otpController = TextEditingController();
//   int _timerCount = 30;
//   String enteredOTP = '';
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
//     return LoginBaseConstant(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => LoginScreen()),
//         );
//       },
//       titleText: 'Password Verification',
//       textAction: 'Back to login',
//       textActionPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4),
//       child: Padding(
//         padding: EdgeInsets.all(MediaQuery.of(context).size.width / 100),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Enter your 4 digits code that you received on your email.',
//                 style: GoogleFonts.firaSans(
//                   color: Color(0xff686464),
//                   fontSize: 10,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   6,
//                       (index) => Container(
//                     width: MediaQuery.of(context).size.width/40,
//                     height: 40,
//                     margin: EdgeInsets.symmetric(horizontal: 5),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(2),
//                       border: Border.all(
//                         color: Color(0xff9BADCA),
//                         width: 0.55,
//                       ),
//                     ),
//                     child: TextFormField(
//                       style:GoogleFonts.firaSans(
//                         color: Color(0xff000000).withOpacity(0.7),
//                         fontWeight: FontWeight.w500,
//                         fontSize: 12,
//                       ),
//                       controller: _otpControllers[index],
//                       cursorColor: Colors.black,
//                       inputFormatters: [
//                         FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//                       ],
//                       keyboardType: TextInputType.number,
//                       textAlign: TextAlign.center,
//                       maxLength: 1,
//                       decoration: InputDecoration(
//                         contentPadding: const EdgeInsets. only(bottom: 10),
//                         counterText: '',
//
//                         border: InputBorder.none,
//                       ),
//                       validator: (value) {
//                         return value!.isEmpty
//                             ? 'Please enter OTP'
//                             : null;
//                       },
//                       onChanged: (value) {
//                         setState(() {
//                           enteredOTP = _otpControllers
//                               .map((controller) => controller.text)
//                               .join();
//                         });
//                         if (value.isNotEmpty && index < 5) {
//                           FocusScope.of(context).nextFocus();
//                         } else if (value.isNotEmpty && index == 5) {
//                           // String enteredOTP =
//                           // _otpControllers
//                           //     .map((controller) =>
//                           // controller.text)
//                           //     .join();
//                           bool anyFieldEmpty = _otpControllers
//                               .any((controller) => controller.text.isEmpty);
//                           if (!anyFieldEmpty && (_formKey.currentState?.validate() ?? false)) {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => ChangePasswordScreen(otp: enteredOTP)));
//                             // _verifyOTPAndLogin(
//                             //   _emailController.text,
//                             //   // enteredOTP,
//                             // );
//                           }
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//               Text(
//                   '${getTimerString()}',
//                   style: GoogleFonts.firaSans(
//                     color: Color(0xffF2451C),
//                     fontSize: 8,
//                     fontWeight: FontWeight.w600,)
//               ),
//               Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(14),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color(0x40000000),
//                         offset: Offset(0, 4),
//                         blurRadius: 4,
//                         spreadRadius: 0,
//                       ),
//                     ],
//                   ),
//                   child: CustomButton(
//                       borderRadius: 28,
//                       text: 'Continue',
//                       onPressed: () {
//                         // Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //         builder: (context) => ChangePasswordScreen()));
//                       },
//                       width: MediaQuery.of(context).size.width / 9,
//                       height: MediaQuery.of(context).size.height / 22),
//                 ),
//               ),
//               RichText(
//                 text: TextSpan(
//                   style: GoogleFonts.firaSans(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xff686464),
//                   ),
//                   children: [
//                     TextSpan(
//                       text: 'If you didn’t receive a code! ',
//                     ),
//                     TextSpan(
//                       text: 'Resend',
//                       style: GoogleFonts.firaSans(
//                         color: Color(0xffF2451C),
//                       ),
//                       recognizer: TapGestureRecognizer()
//                         ..onTap = () {
//                           //Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
//                         },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }