import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/app_config.dart';
import '../../../resources/const_string.dart';

class VerifyOtpService {
  static Future<Map<String, dynamic>> verifyOTPAndLogin({
    required String email,
    required String otp,
  }) async {
    try {
      String trimmedEmail = email.trim();
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({"email": email, "otp": int.parse(otp)});
      print(data);
      var dio = Dio();
      var response = await dio.request(
        '${AppConfig.endpoint}/auth/verifyOtp',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      print(response.data);
      if (response.statusCode == 201) {
        print(response.data);
        return {"success": true, "data": response.data};
      } else {
        return {"success": false, "message": AppString.incorrectOtp};
      }
    } catch (e) {
      print('Error occurred during OTP verification: $e');
      return {"success": false, "message": AppString.incorrectOtp};
    }
  }
}
