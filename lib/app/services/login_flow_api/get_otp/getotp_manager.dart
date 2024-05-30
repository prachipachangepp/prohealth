import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/app_config.dart';

class GetOTPService {
  // static Future<void> getOTP(String email) async {
  //   try {
  //     var headers = {'Content-Type': 'application/json'};
  //     var data = json.encode({"email": email});
  //     var dio = Dio();
  //     var response = await dio.post(
  //      // '${AppConfig.endpoint}/auth/getotp',
  //       '${AppConfig.endpoint}/auth/Otp',
  //       options: Options(
  //         headers: headers,
  //       ),
  //       data: data,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print(json.encode(response.data));
  //     } else {
  //       print(response.statusMessage);
  //     }
  //   } catch (e) {
  //     print('Error occurred: $e');
  //   }
  // }
  static Future<void> getOTP(String email) async {
    try {
      var headers = {
        'Content-Type': 'application/json'
      };
      var data = json.encode({
        "email": email
      });
      var dio = Dio();
      var response = await dio.request(
       // '${AppConfig.endpoint}/auth/getotp',
        '${AppConfig.endpoint}/auth/Otp',
        options: Options(
          method: 'POST',
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
      print('Error occurred: $e');
    }
  }
}
