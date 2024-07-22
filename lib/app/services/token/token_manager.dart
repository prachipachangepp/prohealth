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
  static Future<int> getCompanyId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? companyId = sharedPreferences.getInt("companyId");
    return companyId ?? 0;
  }


  static void setAccessToken({required String token, required String username, required int companyId}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print('User Name set $username');
    print("Token to set $token");
    print('companyId ${companyId}');
    sharedPreferences.setString("accessToken", token);
    sharedPreferences.setString("userName", username);
    sharedPreferences.setInt("companyId", companyId);
  }

  static void removeAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("accessToken", "");
  }
}
