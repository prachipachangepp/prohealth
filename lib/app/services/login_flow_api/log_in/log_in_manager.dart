import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/constants/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../presentation/screens/desktop_module/widgets/login_screen/menu_login_page.dart';
import '../../../../presentation/screens/mobile_module/mobile_menu_screen.dart';

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
            builder: (context) => const MenuScreen(),
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

///mobile
// class AuthServicePhone {
//   static Future<void> loginWithEmailId(
//     BuildContext context,
//     String email,
//     TextEditingController passwordController,
//   ) async {
//     if (email.isEmpty || passwordController.text.isEmpty) {
//       throw 'Please enter username and password.';
//     }
//     String password = passwordController.text.trim();
//
//     try {
//       var dio = Dio();
//       var response = await dio.post(
//         '${AppConfig.endpoint}/auth/sign-in',
//         data: {
//           'email': email,
//           'password': password,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         String? access = response.data["authResults"]['AccessToken'];
//         String? refresh = response.data["authResults"]['RefreshToken'];
//
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setString('email', email);
//         await prefs.setString('password', password);
//         await prefs.setString('access_token', access ?? '');
//         await prefs.setString('refresh_token', refresh ?? '');
//
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => MobileMenuScreen(),
//           ),
//         );
//       } else {
//         String errorMsg = response.data['message'] ?? 'Unknown error occurred';
//         print('Error response: ${response.data}');
//         throw errorMsg;
//       }
//     } on DioException catch (e) {
//       print('Request failed with status: ${e.response?.statusCode}');
//       print('Response data: ${e.response?.data}');
//       throw 'The password you entered is incorrect!';
//     } catch (e) {
//       print('Error occurred: $e');
//       throw 'An unexpected error occurred!';
//     }
//   }
// }
class AuthServicePhone {
  static Future<void> loginWithEmailId(
      BuildContext context,
      String emailController,
      TextEditingController passwordController,
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

      if (response.statusCode == 200) {
        String? access = response.data["authResults"]['AccessToken'];
        String? refresh = response.data["authResults"]['RefreshToken'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);
        await prefs.setString('password', password);
        await prefs.setString('access_token', access ?? '');
        await prefs.setString('refresh_token', refresh ?? '');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MobileMenuScreen(),
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