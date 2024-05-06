///enter functionality
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/login_flow_api/forgot_pass/forgot_pass_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/login_screen/forgot_screen/change_password.dart';
import 'package:prohealth/presentation/widgets/login_screen/login_screen.dart';
import 'package:prohealth/presentation/widgets/login_screen/widgets/login_flow_base_struct.dart';

import '../../../../app/resources/const_string.dart';


class ForgotPassScreen extends StatefulWidget {
  ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  FocusNode emailFocusNode = FocusNode();
  
  ForgotPassManager _forgotPassManager = ForgotPassManager();
  int _passwordChangeAttempts = 0;
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
  bool isExceedingLimit() {
    return _passwordChangeAttempts >= 3;
  }

  @override
  Widget build(BuildContext context) {
    return LoginBaseConstant(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration:
                Duration(milliseconds: 500), // Adjust the duration as needed
            pageBuilder: (context, animation, secondaryAnimation) =>
                LoginScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              // Apply the translation to the child's position
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ),
        );

        ///
        //
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => LoginScreen()),
        // );
      },
      textActionPadding:
          EdgeInsets.only(left: MediaQuery.of(context).size.width / 4.5),
      titleText: AppString.forgotpassword,
      textAction: AppString.backtologin,
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                AppString.forgotenter,
                style: GoogleFonts.firaSans(
                  letterSpacing: 0.5,
                  color: ColorManager.darktgrey,
                  fontSize: FontSize.s10,
                  fontWeight: FontWeightManager.semiBold,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 100),
                child: TextFormField(
                  controller: _emailController,
                  style: CustomTextStylesCommon.commonStyle(
                    color: ColorManager.black.withOpacity(0.5),
                    fontWeight: FontWeightManager.medium,
                    fontSize: FontSize.s12,
                  ),
                  cursorHeight: 22,
                  cursorColor: ColorManager.black,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 2),
                    labelText: AppString.email,
                    labelStyle: CustomTextStylesCommon.commonStyle(
                      color: ColorManager.darktgrey.withOpacity(0.5),
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.medium,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorManager.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorManager.black.withOpacity(0.5),
                          width: 0.5),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.enteremail;
                    }
                    if (!emailRegex.hasMatch(value)) {
                      return AppString.entervalidemail;
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) {
                    _submitForm();
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 99,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: CustomButton(
                    borderRadius: 28,
                    text: AppString.continuet,
                    onPressed: _submitForm,
                    width: MediaQuery.of(context).size.width / 9,
                    height: MediaQuery.of(context).size.height / 22,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      String email = _emailController.text;
      _forgotPassManager.forgotPassword(email);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangePasswordScreen(
            email: _emailController.text,
          ),
        ),
      );
      print(AppString.forgotbtnpress);
    }
  }
}

/// count the limit of reset passwoord
// class ForgotPassScreen extends StatefulWidget {
//   ForgotPassScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ForgotPassScreen> createState() => _ForgotPassScreenState();
// }
//
// class _ForgotPassScreenState extends State<ForgotPassScreen> {
//   final TextEditingController _emailcontroller = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   ForgotPassManager _forgotPassManager = ForgotPassManager();
//
//   /// Track password change attempts for each email
//   Map<String, int> _passwordChangeAttemptsMap = {};
//
//   final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
//
//   int totalAttemptsCount() {
//     /// Calculate the total count of password change attempts for all emails
//     return _passwordChangeAttemptsMap.values
//         .fold(0, (sum, attempts) => sum + attempts);
//   }
//
//   bool isExceedingLimit(String email) {
//     /// Check if the email exists in the map and if its attempt count exceeds the limit
//     return _passwordChangeAttemptsMap[email] != null &&
//         _passwordChangeAttemptsMap[email]! >= 3;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LoginBaseConstant(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => LoginScreen()),
//         );
//       },
//       textActionPadding:
//           EdgeInsets.only(left: MediaQuery.of(context).size.width / 4.5),
//       titleText: 'Forgot Password',
//       textAction: 'Back to Login',
//       child: Padding(
//         padding: EdgeInsets.all(MediaQuery.of(context).size.width / 40),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 'Enter your email for the verification process, we will send 6\ndigits code to your email.',
//                 style: GoogleFonts.firaSans(
//                   color: Color(0xff686464),
//                   fontSize: 10,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: MediaQuery.of(context).size.width / 100),
//                 child: TextFormField(
//                   controller: _emailcontroller,
//                   style: GoogleFonts.firaSans(
//                     color: Color(0xff000000).withOpacity(0.5),
//                     fontWeight: FontWeight.w500,
//                     fontSize: 12,
//                   ),
//                   cursorHeight: 22,
//                   cursorColor: Colors.black,
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.only(top: 2),
//                     labelText: 'Email',
//                     labelStyle: GoogleFonts.firaSans(
//                       color: Color(0xff000000).withOpacity(0.3),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     border: UnderlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black),
//                     ),
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                           color: Color(0xff000000).withOpacity(0.5),
//                           width: 0.5),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Enter Email';
//                     }
//                     if (!emailRegex.hasMatch(value)) {
//                       return 'Enter a valid email address';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height / 99,
//               ),
//               Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(14),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color(0x40000000),
//                         offset: Offset(0, 4),
//                         blurRadius: 4,
//                         spreadRadius: 0,
//                       ),
//                     ],
//                   ),
//                   child: CustomButton(
//                     borderRadius: 28,
//                     text: 'Continue',
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         String email = _emailcontroller.text;
//                         if (totalAttemptsCount() >= 3 &&
//                             !isExceedingLimit(email)) {
//                           // Display error message if total attempts exceed limit and current email attempt is within limit
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: Text("Password Change Limit Exceeded"),
//                                 content: Text(
//                                     "You can reset the password three times in a day."),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: Text("OK"),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         } else if (isExceedingLimit(email)) {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: Text("Password Change Limit Exceeded"),
//                                 content: Text(
//                                     "You can reset the password three times in a day."),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: Text("OK"),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         } else {
//                           _passwordChangeAttemptsMap[email] =
//                               (_passwordChangeAttemptsMap[email] ?? 0) + 1;
//                           setState(() {
//                             _isLoading = true;
//                           });
//                           _forgotPassManager.forgotPassword(email);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ChangePasswordScreen(
//                                 email: _emailcontroller.text,
//                               ),
//                             ),
//                           );
//                           print('forgot button press');
//                         }
//                       }
//                     },
//                     width: MediaQuery.of(context).size.width / 9,
//                     height: MediaQuery.of(context).size.height / 22,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
