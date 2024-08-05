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

  static void setAccessRegisterToken({required String token, required String username, required int companyId, required String emailId}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print('userNameRegister set $username');
    print("accessTokenRegister Token to set $token");
    print('companyIdRegister ${companyId}');
    print("employee Id ${emailId}");
    sharedPreferences.setString("accessTokenRegister", token);
    sharedPreferences.setString("userNameRegister", username);
    sharedPreferences.setInt("companyIdRegister", companyId);
    sharedPreferences.setString("emailIdRegistered", emailId);
  }

  static Future<int> getCompanyIdRegister() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? companyIdRegistered = sharedPreferences.getInt("companyIdRegister");
    return companyIdRegistered ?? 0;
  }

  static Future<String> getEmailIdRegister() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? emilIdRegistred = sharedPreferences.getString("emailIdRegistered");
    return emilIdRegistred ?? "";
  }

  static void removeAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("accessToken", "");
  }

  static void removeAccessRegisterToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("accessTokenRegister", "");
  }
}
