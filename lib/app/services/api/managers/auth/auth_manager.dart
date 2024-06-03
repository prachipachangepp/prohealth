import 'package:dio/dio.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/auth/auth_repository.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';

class AuthManager {
  static Future<ApiData> signInWithEmail(String email, String password) async {
    try {
      Response response = await Api.post(
          path: AuthenticationRepository.signInWithPassword,
          data: {"email": email, "password": password});

      if (response.statusCode == 201) {
        String? access = response.data['accessToken'];
        TokenManager.setAccessToken(token: access ?? "");
        return ApiData(
            success: true,
            message: response.statusMessage ?? 'Unknown error occurred',
            statusCode: response.statusCode ?? 200);
      } else {
        return ApiData(
            success: false,
            message: response.statusMessage ?? 'Unknown error occurred',
            statusCode: response.statusCode ?? 0);
      }
    } catch (e) {
      return ApiData(
          success: false, message: 'Something went wrong !', statusCode: 0);
    }
  }
}
