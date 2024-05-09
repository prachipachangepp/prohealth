import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/constants/app_config.dart';
import 'package:prohealth/presentation/widgets/login_screen/menu_login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<void> loginWithEmail(
    BuildContext context,
    String emailController,
    TextEditingController passwordController,
    bool isLoading,
    Function(bool) setLoading,
    Function(String) setErrorMessage,
  ) async {
    if (emailController.isEmpty || passwordController.text.isEmpty) {
      setErrorMessage('Please enter username and password.');
      return;
    }
    String email = emailController.trim();
    String password = passwordController.text.trim();

    try {
      var dio = Dio();
      var response = await dio.post(
        '${AppConfig.endpoint}/auth/sign-in',
        data: {
          'email': email,
          'password': password,
        },
      );
      print(response);
      if (response.statusCode == 200) {
        String? access = response.data["authResults"]['AccessToken'];
        String? refresh = response.data["authResults"]['RefreshToken'];
        print(access);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);
        await prefs.setString('password', password);
        await prefs.setString('access_token', access ?? '');
        await prefs.setString('refresh_token', refresh ?? '');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuScreen(),
          ),
        );
      } else {
        setErrorMessage(response.statusMessage ?? 'Unknown error occurred');
      }
    } catch (e) {
      setErrorMessage('The email or password you entered is incorrect !');
      print('Error occurred: $e');
    } finally {
      setLoading(false);
    }
  }
}