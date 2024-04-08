///
// class LoginManager {
//   Dio dio = Dio();
//
//   Future<void> login(
//       {required String username, required String password}) async {
//     var headers = {'Content-Type': 'application/json'};
//     var data = json.encode({"email": username, "password": password});
//
//     try {
//       var response = await dio.post(
//         '${AppConfig.endpoint}/auth/sign-in',
//         options: Options(
//           headers: headers,
//         ),
//         data: data,
//       );
//
//       if (response.statusCode == 200) {
//         String? access = response.data['data']?['access'];
//         String? refresh = response.data['data']?['refresh'];
//
//         await _saveUserCredentials(username, password);
//         await _saveTokens(access, refresh);
//
//         print(json.encode(response.data));
//       } else {
//         print(response.statusMessage);
//       }
//     } catch (e) {
//       print('Error occurred: $e');
//     }
//   }
//
//   Future<void> _saveUserCredentials(String username, String password) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('username', username);
//     await prefs.setString('password', password);
//   }
//
//   Future<void> _saveTokens(String? access, String? refresh) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('access_token', access ?? '');
//     await prefs.setString('refresh_token', refresh ?? '');
//   }
//
//   Future<Map<String, String?>> getUserCredentials() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? username = prefs.getString('username');
//     String? password = prefs.getString('password');
//     return {'username': username, 'password': password};
//   }
// }
///
//
// class LoginManager {
//   Dio dio = Dio();
//
//   Future<void> login(
//       {required String username, required String password}) async {
//     var headers = {'Content-Type': 'application/json'};
//     var data = json.encode({"email": username, "password": password});
//
//     try {
//       var response = await dio.post(
//         '${AppConfig.endpoint}/auth/sign-in',
//         options: Options(
//           headers: headers,
//         ),
//         data: data,
//       );
//
//       if (response.statusCode == 200) {
//         await _saveUserCredentials(username, password);
//         print(json.encode(response.data));
//       } else {
//         print(response.statusMessage);
//       }
//     } catch (e) {
//       print('Error occurred: $e');
//     }
//   }
//
//   Future<void> _saveUserCredentials(String username, String password) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('username', username);
//     await prefs.setString('password', password);
//   }
//
//   Future<Map<String, String?>> getUserCredentials() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? username = prefs.getString('username');
//     String? password = prefs.getString('password');
//     return {'username': username, 'password': password};
//   }
// }
