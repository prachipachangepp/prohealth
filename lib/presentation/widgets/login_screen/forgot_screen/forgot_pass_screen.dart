import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/login_screen/forgot_screen/password_verification.dart';
import 'package:prohealth/presentation/widgets/login_screen/login_screen.dart';

import '../widgets/login_flow_base_struct.dart';

class ForgotPassScreen extends StatelessWidget {
  ForgotPassScreen({super.key});
  //
  // /// forget api method
  //
  final TextEditingController controller = TextEditingController();
  final ForgotPasswordApi _forgotPasswordApi = ForgotPasswordApi();

  Future<void> _forgotPassword(BuildContext context, String email) async {
    try {
      await _forgotPasswordApi.sendResetCode(email);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => PasswordVerifyScreen()),
      // );
    } catch (e) {
      print('Error: $e');
    }
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
      textActionPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4),
      titleText: 'Forgot Password',
      textAction: 'Back to Log in',
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Enter your email for the verification process,we will send 4\ndigits code to your email.',
              style: TextStyle(
                fontFamily: 'FiraSans',
                color: Color(0xff686464),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              controller: controller,
              style: TextStyle(
                fontFamily: 'FiraSans',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                    fontSize: 14, color: Color(0xff000000).withOpacity(0.9)),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 99,
            ),
            Center(
              child: CustomButton(
                  text: 'Continue',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PasswordVerifyScreen()),
                    );
                    // String email = controller.text.trim();
                    // if (email.isNotEmpty) {
                    //   _forgotPassword(context, email);
                    // } else {
                    //   print('Email is empty');
                    // }
                  },
                  width: MediaQuery.of(context).size.width / 10,
                  height: MediaQuery.of(context).size.height / 22),
            )
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordApi {
  final Dio _dio = Dio();

  Future<void> sendResetCode(String email) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({"email": email});

      var response = await _dio.post(
        'https://wwx3rebc2b.execute-api.us-west-1.amazonaws.com/dev/serverlessSetup/auth/forgotPassword',
        options: Options(
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
