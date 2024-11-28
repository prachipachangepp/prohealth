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

  static Future<String> getEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? email = sharedPreferences.getString("email");
    return email ?? "";
  }

  static Future<int> getCompanyId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? companyId = sharedPreferences.getInt("companyId");
    return companyId ?? 0;
  }
  static Future<int> getuserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? userId = sharedPreferences.getInt("userId");
    return userId ?? 0;
  }


  static void setAccessToken({required String token, required String username, required int companyId, required int userID, required String email}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print('User Name set $username');
    print("Token to set $token");
    print('companyId ${companyId}');
    print('userID ${userID}');
    print('email ${email}');
    sharedPreferences.setString("accessToken", token);
    sharedPreferences.setString("userName", username);
    sharedPreferences.setInt("companyId", companyId);
    sharedPreferences.setInt("userId", userID);
    sharedPreferences.setString("email", email);
  }

  static void setAccessRegisterToken({required String token, required String username, required int companyId, required String emailId, required int userID ,required int depID}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print('userNameRegister set $username');
    print("accessTokenRegister Token to set $token");
    print('companyIdRegister ${companyId}');
    print('User Id ${userID}');
    print("employee Id ${emailId}");

    sharedPreferences.setString("accessTokenRegister", token);
    sharedPreferences.setString("userNameRegister", username);
    sharedPreferences.setInt("companyIdRegister", companyId);
    sharedPreferences.setString("emailIdRegistered", emailId);
    sharedPreferences.setInt("userID", userID);
    sharedPreferences.setInt("departmentId", depID);
  }

  static Future<int> getdepIdRegister() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? depIdRegistered = sharedPreferences.getInt("departmentId");
    return depIdRegistered ?? 0;
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

  static Future<int> getUserID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? userIdRegistred = sharedPreferences.getInt("userID");
    return userIdRegistred ?? 0;
  }

}
