import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prohealth/presentation/widgets/login_screen/forgot_screen/change_password.dart';
import 'package:prohealth/presentation/widgets/login_screen/widgets/login_flow_base_struct.dart';
import '../../../screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../login_screen.dart';

class PasswordVerifyScreen extends StatelessWidget {
  const PasswordVerifyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginBaseConstant(
      child: _PasswordVerifyContent(),
    );
  }
}

class _PasswordVerifyContent extends StatefulWidget {
  @override
  __PasswordVerifyContentState createState() => __PasswordVerifyContentState();
}

class __PasswordVerifyContentState extends State<_PasswordVerifyContent> {
  late Timer _timer;
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
    return Column(
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
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 20,
              top: 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Verification',
                    style: TextStyle(
                      fontFamily: 'FiraSans',
                      color: Color(0xff686464),
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 360,
                          height: 250,
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                          ),
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
                                    width: 45,
                                    height: 40,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xff9BADCA),
                                        width: 0.55,
                                      ),
                                    ),
                                    child: TextField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                      ],
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      maxLength: 1,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) {

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
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
                                  },
                                  width: 90.0,
                                  height: 30.0,
                                ),
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
                                      text: 'If you didn’t receive a code! ',),
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 300.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        'Back to login',
                        textAlign: TextAlign.right,
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
                      width: MediaQuery.of(context).size.width / 3.1,
                      height: MediaQuery.of(context).size.height / 2,
                      child: Image.asset(
                        'images/amico.png',
                      ))
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}