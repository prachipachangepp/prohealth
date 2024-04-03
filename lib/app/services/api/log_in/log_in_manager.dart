import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:prohealth/app/services/api/log_in/log_in_data.dart';

class LoginManager{
  Dio dio = Dio();

  Future loginUser(LoginRequestData requestData) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "email": "srojkrjha@gmail.com",
      "password": "Test@user12"
    });
    var dio = Dio();
    var response = await dio.request(
      'https://wwx3rebc2b.execute-api.us-west-1.amazonaws.com/dev/serverlessSetup/auth/sign-in',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    }
    else {
      print(response.statusMessage);
    }
  }
}