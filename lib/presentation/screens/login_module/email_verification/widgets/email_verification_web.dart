import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prohealth/app/resources/login_resources/login_flow_theme_const.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/auth/auth_manager.dart';
import '../../../../../data/api_data/api_data.dart';
import '../../../../widgets/widgets/login_screen/widgets/login_flow_base_struct.dart';
import '../../../home_module/home_screen.dart';
import '../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../login_password/login_password.dart';

class EmailVerifyWeb extends StatefulWidget {
  final String email;
  const EmailVerifyWeb({super.key, required this.email});

  @override
  State<EmailVerifyWeb> createState() => _EmailVerifyWebState();
}

class _EmailVerifyWebState extends State<EmailVerifyWeb> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());

  bool _isVerifyingOTP = false;
  String? _errorMessage = "";
  Future<void> _verifyOTPAndLogin() async {
    setState(() {
      _isVerifyingOTP = true;
      _errorMessage = "";
    });
    String enteredOTP =
        _otpControllers.map((controller) => controller.text).join();
    try {
      ApiData result = await AuthManager.verifyOTPAndLogin(
          email: widget.email, otp: enteredOTP, context: context);
      if (result.success) {
        Navigator.pushNamed(context, HomeScreen.routeName);
      } else {
        setState(() {
          _errorMessage = result.message;
        });
      }
      setState(() {
        _isVerifyingOTP = false;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getOtpByEmail() async {
    try {
      ApiData response = await AuthManager.getOTP(widget.email, context);
      print(
          "Response::::::::${response.data}+${response.statusCode}+${response.message}");
      if (response.success) {
        print('Resend OTP is {${response.data}');
      } else {
        setState(() {
          _errorMessage = response.message;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginBaseConstant(
      onTap: () {},
      textAction: '',
      titleText: AppString.verification,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: MediaQuery.of(context).size.width / 3.5,
          height: MediaQuery.of(context).size.height / 2.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: ColorManager.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppString.enter6digitcode,
                  style: CodeVerficationText.VerifyCode(context),
                ),

                ///txtfield
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6,
                    (index) {
                      return Container(
                        width: MediaQuery.of(context).size.width / 45,
                        height: MediaQuery.of(context).size.height / 19,
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width / 150),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.26),
                          border: Border.all(
                            color: ColorManager.bluecontainer,
                            width: 0.85,
                          ),
                        ),
                        child: Focus(
                          onKey: (node, event) {
                            if (event is RawKeyDownEvent) {
                              if (event.logicalKey ==
                                  LogicalKeyboardKey.backspace) {
                                if (_otpControllers[index].text.isEmpty &&
                                    index > 0) {
                                  // Clear current field and move focus to previous field
                                  _focusNodes[index].unfocus();
                                  _otpControllers[index].clear();
                                  FocusScope.of(context)
                                      .requestFocus(_focusNodes[index - 1]);
                                  return KeyEventResult.handled;
                                }
                              }
                            }
                            return KeyEventResult.ignored;
                          },
                          child: TextFormField(
                            style: LoginFlowTextField.customTextStyle(context),
                            controller: _otpControllers[index],
                            focusNode: _focusNodes[index],
                            cursorColor: Colors.black,
                            cursorHeight: 20,
                            cursorWidth: 2,
                            cursorRadius: const Radius.circular(1),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            maxLength: 1,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 15),
                              counterText: '',
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                // Move focus to the next field
                                FocusScope.of(context)
                                    .requestFocus(_focusNodes[index + 1]);
                              } else if (value.isNotEmpty && index == 5) {
                                // Last field, perform action (e.g., verify OTP)
                                _verifyOTPAndLogin();
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

                ///didnt receive code
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppString.didntrecieveCode,
                        style: CodeVerficationText.VerifyCode(context)),
                    TextButton(
                      onPressed: () {
                        _getOtpByEmail();
                      },
                      child: Text(AppString.resend,
                          style: LoginFlowText.customTextStyle(context)),
                    )
                  ],
                ),

                ///button
                CustomButton(
                  borderRadius: 24,
                  height: MediaQuery.of(context).size.height / 18,
                  width: MediaQuery.of(context).size.height / 4,
                  text: _isVerifyingOTP ? AppString.verify : AppString.loginbtn,
                  onPressed: () {
                    _verifyOTPAndLogin();
                  },
                ),
                if (_errorMessage!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: Text(
                      _errorMessage!,
                      style: LoginFlowErrorMsg.customTextStyle(context),
                    ),
                  ),

                ///bottomtxt
                InkWell(
                  child: Text(AppString.donthaveauth,
                      style: LoginFlowText.customTextStyle(context)),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            LoginWithPassword(email: widget.email),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///
// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: List.generate(
//     6,
//         (index) {
//       return Container(
//         width: MediaQuery.of(context).size.width / 45,
//         height: MediaQuery.of(context).size.height / 19,
//         margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 150),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(2.26),
//           border: Border.all(
//             color: ColorManager.bluecontainer,
//             width: 0.85,
//           ),
//         ),
//         child: Focus(
//           onKey: (node, event) {
//             if (event is RawKeyDownEvent) {
//               if (event.logicalKey == LogicalKeyboardKey.backspace && _otpControllers[index].text.isEmpty && index > 0) {
//                 FocusScope.of(context).previousFocus();
//                 _otpControllers[index - 1].clear();
//                 return KeyEventResult.handled;
//               }
//             }
//             return KeyEventResult.ignored;
//           },
//           child: TextFormField(
//             controller: _otpControllers[index],
//             cursorColor: ColorManager.black,
//             cursorHeight: 20,
//             cursorWidth: 2,
//             cursorRadius: const Radius.circular(1),
//             inputFormatters: [
//               FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//             ],
//             keyboardType: TextInputType.number,
//             textAlign: TextAlign.center,
//             textAlignVertical: TextAlignVertical.center,
//             maxLength: 1,
//             decoration: const InputDecoration(
//               contentPadding: EdgeInsets.only(bottom: AppSize.s15),
//               counterText: '',
//               focusedBorder: InputBorder.none,
//               enabledBorder: InputBorder.none,
//               errorBorder: InputBorder.none,
//               disabledBorder: InputBorder.none,
//             ),
//             validator: (value) {
//             return value!.isEmpty ? AppString.otp : null;
//              },
//             onChanged: (value) {
//               if (value.isNotEmpty && index < 5) {
//                 FocusScope.of(context).nextFocus();
//               } else if (value.isNotEmpty && index == 5) {
//                 _verifyOTPAndLogin();
//               }
//             },
//           ),
//         ),
//       );
//     },
//   ),
// ),
///
// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: List.generate(
//     6,
//     (index) => Container(
//       // width: MediaQuery.of(context).size.width /45,
//       width: MediaQuery.of(context).size.width / 45,
//       height: MediaQuery.of(context).size.height / 19,
//       margin: EdgeInsets.symmetric(
//           horizontal: MediaQuery.of(context).size.width / 150),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(2.26),
//         border: Border.all(
//           color: ColorManager.bluecontainer,
//           width: 0.85,
//         ),
//       ),
//       child: TextFormField(
//         controller: _otpControllers[index],
//         cursorColor: ColorManager.black,
//         cursorHeight: 20,
//         cursorWidth: 2,
//         cursorRadius: const Radius.circular(1),
//         inputFormatters: [
//           FilteringTextInputFormatter.allow(
//             RegExp(r'[0-9]'),
//           ),
//         ],
//         keyboardType: TextInputType.number,
//         textAlign: TextAlign.center,
//         textAlignVertical: TextAlignVertical.center,
//         maxLength: 1,
//         decoration: const InputDecoration(
//           contentPadding: EdgeInsets.only(bottom: AppSize.s15),
//           counterText: '',
//           focusedBorder: InputBorder.none,
//           enabledBorder: InputBorder.none,
//           errorBorder: InputBorder.none,
//           disabledBorder: InputBorder.none,
//         ),
//         validator: (value) {
//           return value!.isEmpty ? AppString.otp : null;
//         },
//         onChanged: (value) {
//           if (value.isNotEmpty && index < 5) {
//             FocusScope.of(context).nextFocus();
//           } else if (value.isNotEmpty && index == 5) {
//             _verifyOTPAndLogin();
//           }
//         },
//       ),
//     ),
//   ),
// ),
