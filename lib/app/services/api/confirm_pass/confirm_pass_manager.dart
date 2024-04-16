import 'dart:convert';

import 'package:dio/dio.dart';

class ConfirmPassManager{
  Dio dio = Dio();

  Future<void> confirmPassword(String email, String otp,String password) async{
    try{
      var headers = {
        'Content-Type': 'application/json'
      };
      var data = json.encode({
        "email": email,
        "verificationCode": otp,
        "newPassword": password
      });
      var dio = Dio();
      var response = await dio.request(
        'https://wwx3rebc2b.execute-api.us-west-1.amazonaws.com/dev/serverlessSetup/auth/confirmPassword',
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
        catch(e){
          print('Error occurred: $e');
        }
  }
}