import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/auth/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../presentation/screens/home_module/home_screen.dart';

/// desktop
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
      Response response = await Api.post(
          path: AuthenticationRepository.signInWithPassword,
          data: {"email": email, "password": password});
      if (response.statusCode == 201) {
        String? access = response.data['accessToken'];
        // String? refresh = response.data["authResults"]['RefreshToken'];
        print(access);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);
        await prefs.setString('password', password);
        await prefs.setString('accessToken', access ?? '');
        //await prefs.setString('refresh_token', refresh ?? '');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        setErrorMessage(response.statusMessage ?? 'Unknown error occurred');
      }
    } catch (e) {
      setErrorMessage('The password you entered is incorrect !');
      print('Error occurred: $e');
    } finally {
      setLoading(false);
    }
  }
}
