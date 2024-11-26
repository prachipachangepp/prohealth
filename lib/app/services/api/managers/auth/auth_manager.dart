import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/api_offer.dart';
import 'package:prohealth/app/services/api/repository/auth/auth_repository.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';

import '../../../../resources/const_string.dart';

class AuthManager {
  ///Sign in with Email.
  static Future<ApiData> signInWithEmail(
      String email, String password, BuildContext context) async {
    try {
      Response response = await Api(context).post(
          path: AuthenticationRepository.signInWithPassword,
          data: {"email": email, "password": password});
      if (response.statusCode == 201) {
        String? access = response.data['accessToken'];
        String userName = "${response.data['user']['firstName']} ${response.data['user']['lastName']}";
        int companyID = response.data['user']['company_id'];
        int userId = response.data['user']['userId'];
        String email = response.data['user']['email'];
        TokenManager.setAccessToken(token: access ?? "",username: userName, companyId: companyID,userID: userId, email: email);
        return ApiData(
            success: true,
            message: response.statusMessage ?? "",
            statusCode: response.statusCode!,
            data: userName);
      } else {
        return ApiData(
            success: false,
            message: response.data["message"] ?? "",
            statusCode: response.statusCode!);
      }
    } catch (e) {
      return ApiData(
          success: false,
          message: AppString.somethingWentWrong,
          statusCode: 404);
    }
  }

  ///Confirm Password for Forget Password Flow
  Future<ApiData> confirmPassword(
      String email, String otp, String password, BuildContext context) async {
    try {
      var response = await Api(context).post(
          path: AuthenticationRepository.resetPassword,
          data: {"email": email, "otp": int.parse(otp), "password": password});

      if (response.statusCode == 201 || response.statusCode == 200) {
        return ApiData(
            statusCode: response.statusCode!,
            success: true,
            message: response.statusMessage ?? "");
      } else {
        return ApiData(
            statusCode: response.statusCode!,
            success: false,
            message: response.data["message"] ?? "");
      }
    } catch (e) {
      return ApiData(
          statusCode: 404,
          success: false,
          message: AppString.somethingWentWrong);
    }
  }

  ///Forget Password
  Future<ApiData> forgotPassword(String email, BuildContext context) async {
    try {
      var response = await Api(context).post(
          path: AuthenticationRepository.forgotPassword,
          data: {"email": email});

      if (response.statusCode == 201 || response.statusCode == 200) {
        return ApiData(
            statusCode: response.statusCode!,
            success: true,
            message: response.statusMessage ?? "");
      } else {
        return ApiData(
            statusCode: response.statusCode!,
            success: false,
            message: response.data["message"] ?? "");
      }
    } catch (e) {
      return ApiData(
          statusCode: 404,
          success: false,
          message: AppString.somethingWentWrong);
    }
  }

  ///Get OTP for mail login
  static Future<ApiData> getOTP(String email, BuildContext context) async {
    try {
      print("$email");
      var response = await Api(context).post(
          path: AuthenticationRepository.getOtpMail, data: {"email": email});
      print("<<<>>>${response.statusCode}");
      if (response.statusCode == 201 || response.statusCode == 200) {
        print(response.data);
        return ApiData(
            statusCode: response.statusCode!,
            success: true,
            message: response.statusMessage ?? "");
      } else {
        return ApiData(
            statusCode: response.statusCode!,
            success: false,
            message: response.data["message"] ?? "");
      }
    } catch (e) {
      print(e);
      return ApiData(
          statusCode: 404,
          success: false,
          message: AppString.somethingWentWrong);
    }
  }

  ///Sign In otp Verification
   static Future<ApiData> verifyOTPAndLogin(
      {required String email,
      required String otp,
      required BuildContext context}) async {
    try {
      var response = await Api(context).post(
          path: AuthenticationRepository.verifyOtpMail,
          data: {"email": email, "otp": int.parse(otp)});
      print(response);
      if (response.statusCode == 201 || response.statusCode == 200) {
        String accessToken = response.data["accessToken"] ?? "";
        String userName = "${response.data['user']['firstName']} ${response.data['user']['lastName']}";
        int companyID = response.data['user']['company_id'];
        int userId = response.data['user']['userId'];
        String email = response.data['user']['email'];
        TokenManager.setAccessToken(token: accessToken, username: userName, companyId: companyID, userID: userId, email: email);
        // Navigator.pushNamed(context, HomeScreen.routeName);

        return ApiData(
            statusCode: response.statusCode!,
            success: true,
            message: response.data['message'] ?? "");
      } else {
        return ApiData(
            statusCode: response.statusCode!,
            success: false,
            message: response.data['message'] ?? "");
      }
    } catch (e) {
      return ApiData(statusCode: 404, success: false, message: e.toString());
    }
  }

  ///Sign Up
  Future signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      var response =
          await Api(context).post(path: AuthenticationRepository.signUp, data: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 201 || response.statusCode == 200) {
        return ApiData(
            statusCode: response.statusCode!,
            success: true,
            message: response.statusMessage ?? "");
      } else {
        return ApiData(
            statusCode: response.statusCode!,
            success: false,
            message: response.statusMessage ?? "");
      }
    } catch (e) {
      return ApiData(
          statusCode: 404,
          success: false,
          message: AppString.somethingWentWrong);
    }
  }

  /// Authentication on reguster screen HR
  static Future <ApiDataRegister> verifyOTPAndRegister(
      {required String email,
        required String otp,
        required BuildContext context}) async {
    try {
      var response = await ApiOffer(context).post(
          path: AuthenticationRepository.verifyOtpForOffer,
          data: {"email": email, "otp": int.parse(otp)});
      print(response);
      if (response.statusCode == 201 || response.statusCode == 200) {
        String accessToken = response.data["accessToken"] ?? "";
        String userName = "${response.data['user']['firstName']} ${response.data['user']['lastName']}";
        int companyID = response.data['user']['company_id'];
        String emailId = response.data['user']['email'];
        int userId = response.data['user']['userId'];
        int departmentId = response.data['user']['departmentId'];

        TokenManager.setAccessRegisterToken(token: accessToken, username: userName, companyId: companyID, emailId: emailId, userID: userId, depID: departmentId);
        // Navigator.pushNamed(context, HomeScreen.routeName);

print("dep id ;;;;${ departmentId}");
        return ApiDataRegister(
            statusCode: response.statusCode!,
            success: true,
            message: response.data['message'] ?? "");
      } else {
        return ApiDataRegister(
            statusCode: response.statusCode!,
            success: false,
            message: response.data['message'] ?? "");
      }
    } catch (e) {
      return ApiDataRegister(statusCode: 404, success: false, message: e.toString());
    }
  }
}
