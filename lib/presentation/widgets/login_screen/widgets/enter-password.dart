import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/login_flow_api/log_in/log_in_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/login_screen/forgot_screen/forgot_pass_screen.dart';
import 'package:prohealth/presentation/widgets/login_screen/widgets/login_flow_base_struct.dart';

class PasswordLoginScreen extends StatefulWidget {
  @override
  _PasswordLoginScreenState createState() => _PasswordLoginScreenState();
}

class _PasswordLoginScreenState extends State<PasswordLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return LoginBaseConstant(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) =>
                ForgotPassScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.ease;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ),
        );
      },
      titleText: AppString.login,
      textAction: AppString.forgotpassword,
      textActionPadding:
          EdgeInsets.only(left: MediaQuery.of(context).size.width / 5.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 10,
                      horizontal: MediaQuery.of(context).size.width / 30,
                    ),
                    child: TextFormField(
                      style: CustomTextStylesCommon.commonStyle(
                        color: Color(0xff000000).withOpacity(0.5),
                        fontWeight: FontWeightManager.medium,
                        fontSize: FontSize.s14,
                      ),
                      controller: _passwordController,
                      cursorColor: Colors.black,
                      cursorHeight: 22,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 1),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff000000).withOpacity(0.5),
                            width: 0.5,
                          ),
                        ),
                        labelText: AppString.password,
                        labelStyle: CustomTextStylesCommon.commonStyle(
                          color: Color(0xff000000).withOpacity(0.3),
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.medium,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Password";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: CustomButton(
                      borderRadius: 28,
                      height: MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.height / 5.5,
                      text: AppString.login,
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          String enteredPassword = _passwordController.text;
                          AuthService.loginWithEmail(
                            context,
                            _emailController,
                            _passwordController,
                            true, // isLoading
                            (isLoading) {}, // setLoading
                            (errorMessage) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(errorMessage),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///
// class PasswordLoginScreen extends StatelessWidget {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   PageController _pageController = PageController();
//   List<TextEditingController> _otpControllers =
//       List.generate(4, (_) => TextEditingController());
//   TextEditingController _otpController = TextEditingController();
//   int _selectedIndex = 0;
//   FocusNode fieldOne = FocusNode();
//   FocusNode fieldTow = FocusNode();
//   final _formKey = GlobalKey<FormState>();
//   final _formKeyAuth = GlobalKey<FormState>();
//   bool isPasswordVisible = true;
//   bool _isLoading = false;
//   bool _isPasswordVisible = false;
//   String? _errorMessage;
//   bool _showEmailInput = true;
//   bool _loginSuccessful = false;
//   bool _isauthLoginLoading = false;
//   FocusNode emailFocusNode = FocusNode();
//   FocusNode passwordFocusNode = FocusNode();
//   String? otpFromRunTab;
//   String? _errorLoginMessage;
//   bool _isLoggingIn = false;
//   final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
//   bool _isLoadingScreen = true;
//   bool _isSendingEmail = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return LoginBaseConstant(
//       onTap: () {},
//       titleText: AppString.login,
//       textAction: "",
//       textActionPadding:
//           EdgeInsets.only(left: MediaQuery.of(context).size.width / 5.5),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Form(
//               key: _formKey,
//               child: Center(
//                 child: Column(children: [
//                   ///textfield Email
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         vertical: MediaQuery.of(context).size.height / 10,
//                         horizontal: MediaQuery.of(context).size.width / 30),
//                     child: TextFormField(
//                       style: CustomTextStylesCommon.commonStyle(
//                         color: Color(0xff000000).withOpacity(0.5),
//                         fontWeight: FontWeightManager.medium,
//                         fontSize: FontSize.s14,
//                       ),
//                       focusNode: emailFocusNode,
//                       controller: _emailController,
//                       cursorColor: Colors.black,
//                       cursorHeight: 22,
//                       decoration: InputDecoration(
//                         contentPadding: const EdgeInsets.only(top: 1),
//                         focusedBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Color(0xff000000).withOpacity(0.5),
//                               width: 0.5),
//                         ),
//                         labelText: AppString.email,
//                         labelStyle: CustomTextStylesCommon.commonStyle(
//                           color: Color(0xff000000).withOpacity(0.3),
//                           fontSize: FontSize.s14,
//                           fontWeight: FontWeightManager.medium,
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return AppString.enteremail;
//                         }
//                         if (!emailRegex.hasMatch(value)) {
//                           return AppString.entervalidemail;
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   Center(
//                     child: _isSendingEmail
//                         ? CircularProgressIndicator(
//                             color: Colors.blue,
//                           )
//                         : Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(14),
//                             ),
//                             child: CustomButton(
//                               borderRadius: 28,
//                               height: MediaQuery.of(context).size.height / 20,
//                               width: MediaQuery.of(context).size.height / 5.5,
//                               text: AppString.login,
//                               onPressed: () async {},
//                             ),
//                           ),
//                   ),
//                 ]),
//               ))
//         ],
//       ),
//     );
//   }
// }
