import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/login_resources/login_flow_theme_const.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import '../../../../../../app/resources/theme_manager.dart';
import '../../../../widgets/widgets/login_screen/widgets/login_flow_base_struct.dart';
import '../../../../widgets/widgets/profile_bar/widget/screen_transition.dart';
import '../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../login/login_screen.dart';
import '../../update_password/update_password.dart';

class VerifyForgotPassWeb extends StatefulWidget {
  final String email;
  const VerifyForgotPassWeb({super.key, required this.email});

  @override
  State<VerifyForgotPassWeb> createState() => _VerifyForgotPassWebState();
}

class _VerifyForgotPassWebState extends State<VerifyForgotPassWeb> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;
  late Timer _timer;
  int _timerCount = 30;
  bool isOtpFieldEmpty = true;

  final List<bool> _otpFieldFilledStatus = List.generate(6, (_) => false);
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

  void navigateToNextScreen() {
    bool allFieldsFilled = _otpFieldFilledStatus.every((filled) => filled);
    if (allFieldsFilled) {
      String otp = _otpControllers.map((controller) => controller.text).join();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UpdatePassword(email: widget.email, otp: otp)),
      );
    } else {
      setState(() {
        _errorMessage = AppString.enterotp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginBaseConstant(
      onTap: () {
        Navigator.push(
          context,
          RouteTransitions.slideTransition(page: const LoginScreen()),
        );
      },
      textAction: AppString.backtologin,
      titleText: AppString.verification,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: MediaQuery.of(context).size.width / 3.6,
          height: MediaQuery.of(context).size.height / 2.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: ColorManager.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(AppString.entersixdigitCode,
                    style: LoginFlowLetterSpacing.enterEmail(context,applyLetterSpacing: false)),

                ///txtfield
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6,
                    (index) => Container(
                      width: MediaQuery.of(context).size.width / 40,
                      height: MediaQuery.of(context).size.height / 20,
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.26),
                        border: Border.all(
                          color: ColorManager.bluecontainer,
                          width: 0.85,
                        ),
                      ),
                      child: TextFormField(
                        style: LoginFlowTextField.customTextStyle(context),
                        controller: _otpControllers[index],
                        cursorColor: ColorManager.black,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        focusNode: _focusNodes[index],
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.only(bottom: AppPadding.p11),
                          counterText: '',
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          return value!.isEmpty ? AppString.enterotp : null;
                        },

                        ///
                        onChanged: (value) {
                          _otpFieldFilledStatus[index] = value.isNotEmpty;
                          bool allFieldsFilled =
                              _otpFieldFilledStatus.every((filled) => filled);
                          setState(() {
                            isOtpFieldEmpty = !allFieldsFilled;
                          });
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context)
                                .requestFocus(_focusNodes[index + 1]);
                          } else if (allFieldsFilled) {
                            navigateToNextScreen();
                          }
                        },
                      ),
                    ),
                  ),
                ),

                ///timer
                Text(
                  getTimerString(),
                  style: CustomTextStylesCommon.commonStyle(
                    color: ColorManager.orange,
                    fontSize: FontSize.s10,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                ///button
                Center(
                  child: CustomButton(
                    borderRadius: 24,
                    height: MediaQuery.of(context).size.height / 18,
                    width: MediaQuery.of(context).size.width / 10,
                    text: AppString.continuet,
                    onPressed: () {
                      navigateToNextScreen();
                    },
                  ),
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: Text(
                      _errorMessage!,
                      style: LoginFlowErrorMsg.customTextStyle(context),
                    ),
                  ),

                ///didnt receive code
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppString.didntrecieveCode,
                        style: LoginFlowLetterSpacing.enterEmail(context,)),
                    TextButton(
                      onPressed: () {
                        print("Resend tapped!");
                      },
                      child: Text(AppString.resend,
                          style: CustomTextStylesCommon.commonStyle(
                            color: ColorManager.blueprime,
                            fontSize: FontSize.s10,
                            fontWeight: FontWeight.w500,
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
