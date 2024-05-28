import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../desktop_module/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../tablet_module/tab_const.dart';
import '../../update_password/update_password.dart';

class TabVerifyPassword extends StatefulWidget {
  final String email;
  const TabVerifyPassword({super.key, required this.email});

  @override
  State<TabVerifyPassword> createState() => _TabVerifyPasswordState();
}

class _TabVerifyPasswordState extends State<TabVerifyPassword> {
  List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());
  List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;
  late Timer _timer;
  int _timerCount = 30;
  bool isOtpFieldEmpty = true;
  List<bool> _otpFieldFilledStatus = List.generate(6, (_) => false);

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
    return LoginBaseConstTab(
        titleText: AppString.login, onTap: () {  },
        textAction: '',
        //textActionPadding: EdgeInsets.only(right: 10),
        childTab: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(25),
            child: Container(
                height: MediaQuery.of(context).size.height/3.5,
                width: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          AppString.entersixdigitCode,
                          style: CustomTextStylesCommon.commonStyle(
                            color: ColorManager.mediumgrey,
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.semiBold,
                          )
                      ),
                      ///txtfield
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          6,
                              (index) => Container(
                            width: MediaQuery.of(context).size.width / 40,
                            height:  MediaQuery.of(context).size.height / 20,
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

                              style: CustomTextStylesCommon.commonStyle(
                                color: ColorManager.black
                                    .withOpacity(0.7),
                                fontSize: FontSize.s14,
                                fontWeight: FontWeightManager.medium,
                              ),
                              controller: _otpControllers[index],
                              cursorColor: ColorManager.black,
                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .allow(RegExp(
                                    r'[0-9]')),
                              ],
                              keyboardType:
                              TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              focusNode: _focusNodes[index],
                              decoration:
                              InputDecoration(
                                contentPadding:
                                const EdgeInsets
                                    .only(
                                    bottom: AppPadding.p11),
                                counterText: '',
                                border:
                                InputBorder.none,
                              ),
                              validator: (value) {
                                return value!.isEmpty
                                    ? AppString.enterotp
                                    : null;
                              },
                              ///
                              onChanged: (value) {
                                _otpFieldFilledStatus[index] = value.isNotEmpty;
                                bool allFieldsFilled = _otpFieldFilledStatus.every(
                                        (filled) => filled);
                                setState(() {
                                  isOtpFieldEmpty =
                                  !allFieldsFilled;
                                });
                                if (value.isNotEmpty &&
                                    index < 5) {
                                  FocusScope.of(context)
                                      .requestFocus(
                                      _focusNodes[
                                      index +
                                          1]);
                                }
                                else if(allFieldsFilled) {
                                  navigateToNextScreen();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      ///timer
                      Text('${getTimerString()}',
                        style: CustomTextStylesCommon.commonStyle(
                          color:  ColorManager.orange,
                          fontSize: FontSize.s8,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                      ///button
                      Center(
                        child: CustomButton(
                          borderRadius: 24,
                          height: MediaQuery.of(context).size.height / 18,
                          width: MediaQuery.of(context).size.width / 10,
                          text: AppString.continuet,
                          onPressed: (){
                            navigateToNextScreen();
                          },
                        ),
                      ),
                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          child: Text(
                            _errorMessage!,
                            style:  CustomTextStylesCommon.commonStyle(
                              color: ColorManager.red,
                              fontSize: FontSize.s10,
                              fontWeight: FontWeightManager.bold,
                            ),
                          ),
                        ),
                      ///didnt receive code
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              AppString.didntrecieveCode,
                              style: CodeVerficationText.VerifyCode(context)),
                          TextButton(
                            onPressed: () {
                              print("Resend tapped!");
                            },
                            child: Text(
                                AppString.resend,
                                style: CustomTextStylesCommon.commonStyle(
                                  color: ColorManager.blueprime,
                                  fontSize: FontSize.s10,
                                  fontWeight: FontWeightManager.semiBold,
                                )
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
            )));
  }
  void navigateToNextScreen() {
    bool allFieldsFilled = _otpFieldFilledStatus.every((filled) => filled);
    if (allFieldsFilled) {
      String email = widget.email;
      String otp = _otpControllers.map((controller) => controller.text).join();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UpdatePassword(email: email, otp: otp)),
      );
    } else {
      setState(() {
        _errorMessage = AppString.enterotp;
      });
    }
  }
}
