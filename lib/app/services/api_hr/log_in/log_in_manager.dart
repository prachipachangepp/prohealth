// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../../constants/app_config.dart';
//  /// login with email refactored
// class LoginManager{
//   Dio dio = Dio();
//   String? _errorMessage;
//   bool _isLoading = false;
//
//   Future<void> loginWithEmail(String email, String password) async {
//     if (email.isEmpty || password.isEmpty) {
//      // setState(() {
//         _errorMessage = 'Please enter username and password.';
//       //});
//       return;
//     }
//
//     // String email = _emailController.text.trim();
//     // String password = _passwordController.text.trim();
//
//     try {
//       var dio = Dio();
//       var response = await dio.post(
//         '${AppConfig.endpoint}/auth/sign-in',
//         //'https://wwx3rebc2b.execute-api.us-west-1.amazonaws.com/dev/serverlessSetup/auth/sign-in',
//         data: {
//           'email': email,
//           'password': password,
//         },
//       );
//       print(response);
//       if (response.statusCode == 200) {
//         String? access = response.data["authResults"]['AccessToken'];
//         String? refresh = response.data["authResults"]['RefreshToken'];
//         print(access);
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setString('email', email);
//         await prefs.setString('password', password);
//         await prefs.setString('access_token', access ?? '');
//         await prefs.setString('refresh_token', refresh ?? '');
//
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (context) => MenuScreen(),
//         //   ),
//         // );
//       } else {
//        // setState(() {
//           _errorMessage = response.statusMessage;
//         //});
//       }
//     } catch (e) {
//       //setState(() {
//         _errorMessage = 'The email or password you entered is incorrect.';
//       //});
//       print('Error occurred: $e');
//     } finally {
//      // setState(() {
//         _isLoading = false;
//       //});
//     }
//   }
// }