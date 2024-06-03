import 'package:dio/dio.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/services/token/token_manager.dart';

class Api {
  static var dio = Dio();

  static Future<Response> get({
    required String path,
  }) async {
    String token = await TokenManager.getAccessToken();
    var headers = {'Authorization': 'Bearer $token'};
    var response = await dio.get(
      '${AppConfig.endpoint}$path',
      options: Options(
        headers: headers,
      ),
    );
    return response;
  }

  static Future<Response> post(
      {required String path, required Map data}) async {
    String token = await TokenManager.getAccessToken();
    var headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var response = await dio.post(
      '${AppConfig.endpoint}$path',
      options: Options(
        headers: headers,
      ),
      data: data,
    );
    return response;
  }

  static Future<Response> patch(
      {required String path, required Map data}) async {
    String token = await TokenManager.getAccessToken();
    var headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    var response = await dio.patch(
      '${AppConfig.endpoint}$path',
      options: Options(
        headers: headers,
      ),
      data: data,
    );
    return response;
  }

  static Future<Response> delete({
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
