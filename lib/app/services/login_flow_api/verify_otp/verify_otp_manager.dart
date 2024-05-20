import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/constants/app_config.dart';

import '../../../../presentation/screens/desktop_module/widgets/login_screen/menu_login_page.dart';

class VerifyOTPService {
  static Future<void> verifyOTPAndLogin(
    BuildContext context,
    String email,
    String enteredOTP,
    Function(String) setErrorMessage,
  ) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      email = email.trim();
      var data = json.encode({
        "email": email,
        "otp": enteredOTP,
      });
      var dio = Dio();
      var response = await dio.request(
        '${AppConfig.endpoint}/auth/verifyotp',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        print(json.encode(response.data));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuScreen(),
          ),
        );
      } else {
        print(response.statusMessage);
        setErrorMessage('Incorrect OTP. Please try again.');
      }
    } catch (e) {
      print('Error occurred during OTP verification: $e');
      setErrorMessage(
          'Error occurred during OTP verification. Please try again.');
    }
  }
}
