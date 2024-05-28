import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/app_config.dart';

class SignUpManager {
  Dio dio = Dio();

  ///sign up POST
  Future signUp({required String email, required String password}) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      // "email": "srojkrjha@gmail.com",
      // "password": "Test@user12"
      "email": email,
      "password": password,
    });
    var dio = Dio();
    var response = await dio.request(
      '${AppConfig.endpoint}/auth/sign-up/',
      //  'https://wwx3rebc2b.execute-api.us-west-1.amazonaws.com/dev/serverlessSetup/auth/sign-up',
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
  }
}
