import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static Future<String> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("accessToken");
    return token ?? "";
  }

  static Future<String> getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userName = sharedPreferences.getString("userName");
    return userName ?? "";
  }

  static void setAccessToken({required String token, required String username}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print('User Name set $username');
    print("Token to set $token");
    sharedPreferences.setString("accessToken", token);
    sharedPreferences.setString("userName", username);
  }

  static void removeAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("accessToken", "");
  }
}
