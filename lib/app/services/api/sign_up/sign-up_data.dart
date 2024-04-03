// class SignUpData{
//   final String email;
//   final String password;
//
//   SignUpData({
//     required this.email,
//     required this.password});
//
//   SignUpData.fromJson(
//       Map<String, dynamic> json,
//       ) : email = json["email"] as String ,
//       password = json["password"] as String;
//
//   Map<String, dynamic> toJson() => {
//     "email": email,
//     "password": password,
//   };
// }

///method
// Future<void> _signUpWithEmail() async {
//   String email = _emailController.text.trim();
//   String password = _passwordController.text.trim();
//
//   SignUpManager signUpManager = SignUpManager();
//   try {
//     await signUpManager.signUp(email: email, password: password);
//     Navigator.push(context, MaterialPageRoute(builder: (context) => const SubLoginScreen()));
//   } catch (e) {
//     print('Login failed: $e');
//   }
// }