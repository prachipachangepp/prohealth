import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/services/token/token_manager.dart';

import '../../../presentation/screens/login_module/login/login_screen.dart';

class Api {
  static var dio;
  final BuildContext buildContext;
  Api(this.buildContext) {
    dio = Dio(BaseOptions(baseUrl: AppConfig.endpoint))
      ..interceptors.add(InterceptorsWrapper(onError: (error, handler) {
        if (error.response!.data["message"] == "Unauthorized") {

          print(error.response!.data);
          TokenManager.removeAccessToken();
          Navigator.pushNamedAndRemoveUntil(
              buildContext, LoginScreen.routeName, (route) => false);
        }
        if (error.response!.statusCode == 404) {
          print(":::::");
          print(error.response!.data);
        }
        if (error.response!.statusCode == 401) {
          print(error.response!.data);
        }
        handler.resolve(error.response!);
      }, onRequest: (options, handler) async {
        String accessToken = await TokenManager.getAccessToken();
        options.headers = {
          'accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json'
        };
        print(options.uri);
        handler.next(options);
      }));
  }

  Future<Response> get({
    required String path,

  }) async {
    var response = await dio.get(

      path,

    );
    // print(path);
    // print("Prachi:::::::::${response}"

    return response;
  }

  Future<Response> post({required String path, required Map data}) async {
    var response = await dio.post(
      path,
      data: data,
    );
    //  print(path);
    // print("Prachi POST:::::::::${response}");
    return response;
  }

  Future<Response> patch({required String path, required Map data}) async {
    var response = await dio.patch(
      path,
      data: data,
    );
    return response;
  }

  Future<Response> delete({
    required String path,
  }) async {
    String token = await TokenManager.getAccessToken();
    var headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await dio.delete(
      '${AppConfig.endpoint}$path',
      options: Options(
        headers: headers,
      ),
    );
    return response;
  }
}
