class SignUpData{
  final String email;
  final String password;

  SignUpData({
    required this.email,
    required this.password});

  SignUpData.fromJson(
      Map<String, dynamic> json,
      ) : email = json["email"] as String ,
      password = json["password"] as String;

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}