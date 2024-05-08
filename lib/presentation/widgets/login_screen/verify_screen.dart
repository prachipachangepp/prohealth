import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/constants/app_config.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/login_screen/menu_login_page.dart';
import 'package:prohealth/presentation/widgets/login_screen/widgets/enter-password.dart';
import 'package:prohealth/presentation/widgets/login_screen/widgets/login_flow_base_struct.dart';

class VerifyScreen extends StatefulWidget {
  final String email;

  const VerifyScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState(email: email);
}

class _VerifyScreenState extends State<VerifyScreen> {
  List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  bool _isVerifyingOTP = false;
  String? _errorMessage;
  final String email;
  _VerifyScreenState({required this.email});

  Future<void> verifyOTPAndLogin() async {
    try {
      setState(() {
        _isVerifyingOTP = true;
        _errorMessage = null;
      });
      String enteredOTP =
          _otpControllers.map((controller) => controller.text).join();
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "email": widget.email.trim(),
        "otp": enteredOTP,
      });
      var dio = Dio();
      var response = await dio.post(
        '${AppConfig.endpoint}/auth/verifyotp',
        data: data,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MenuScreen(),
          ),
        );
      } else {
        setState(() {
          _errorMessage = 'Incorrect OTP. Please try again.';
        });
      }
    } catch (e) {
      print('Error occurred during OTP verification: $e');
      setState(() {
        _errorMessage = 'Incorrect OTP. Please try again!';
      });
    } finally {
      setState(() {
        _isVerifyingOTP = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginBaseConstant(
      onTap: () {},
      textAction: '',
      titleText: 'Verification',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Enter your 4 digit code that you recieve through mail.",
              style: TextStyle(
                  fontFamily: 'FiraSans',
                  color: Color(0xff565656),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700),
            ),
            // SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Container(
                  width: MediaQuery.of(context).size.width / 38,
                  height: MediaQuery.of(context).size.width / 38,
                  margin: EdgeInsets.symmetric(horizontal: AppPadding.p10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorManager.grey,
                      width: 1,
                    ),
                  ),
                  child: TextFormField(
                    controller: _otpControllers[index],
                    cursorColor: ColorManager.black,
                    cursorHeight: 20,
                    cursorWidth: 2,
                    cursorRadius: Radius.circular(1),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]'),
                      ),
                    ],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    maxLength: 1,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 15),
                      counterText: '',
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    validator: (value) {
                      return value!.isEmpty ? AppString.otp : null;
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 3) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isNotEmpty && index == 3) {
                        verifyOTPAndLogin();
                      }
                    },
                  ),
                ),
              ),
            ),
            // SizedBox(height: 10),
            RichText(
              text: TextSpan(
                text: "Didn't receive code? ",
                style: TextStyle(
                    fontFamily: 'FiraSans',
                    color: Color(0xff565656),
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700),
                children: <TextSpan>[
                  TextSpan(
                    text: "Resend",
                    style: TextStyle(
                        fontFamily: 'FiraSans',
                        color: ColorManager.bluelight,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("Resend code tapped");
                      },
                  ),
                ],
              ),
            ),
            // SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              child: CustomButton(
                borderRadius: 28,
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.height / 5.5,
                text: _isVerifyingOTP ? 'Verifying...' : AppString.login,
                onPressed: () {
                  verifyOTPAndLogin();
                },
              ),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(
                      fontFamily: 'FiraSans',
                      color: ColorManager.red,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
            InkWell(
              child: Text(
                "Dont have authentication application with me.",
                style: TextStyle(
                    fontFamily: 'FiraSans',
                    color: ColorManager.bluelight,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        PasswordLoginScreen(email: email),
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
    );
  }
}