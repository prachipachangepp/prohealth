import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static Future<String> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("accessToken");
    return token ?? "";
  }

  static void setAccessToken({required String token}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print("Token to set $token");
    sharedPreferences.setString("accessToken", token);
  }

  static void removeAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("accessToken", "");
  }
}
