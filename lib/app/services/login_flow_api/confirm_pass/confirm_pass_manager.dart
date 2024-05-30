import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/app_config.dart';

class ConfirmPassManager {
  Dio dio = Dio();

  Future<void> confirmPassword(
      String email, String otp, String password) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode(
          {"email": email, "otp": int.parse(otp), "password": password});
      print(data);
      var dio = Dio();
      var response = await dio.request(
        '${AppConfig.endpoint}/auth/ResetPassword',
        //  'https://wwx3rebc2b.execute-api_hr.us-west-1.amazonaws.com/dev/serverlessSetup/auth/confirmPassword',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      print(response);
      if (response.statusCode == 201) {
        print(json.encode(response.data));
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
