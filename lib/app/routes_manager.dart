import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/home_module/home_screen.dart';
import 'package:prohealth/presentation/screens/login_module/email_verification/email_verification.dart';
import 'package:prohealth/presentation/screens/login_module/forget_pass_verification/forget_pass_verification.dart';
import 'package:prohealth/presentation/screens/login_module/forget_password/forget_password_screen.dart';
import 'package:prohealth/presentation/screens/login_module/login/login_screen.dart';

class RoutesManager {
  Map<String, Widget Function(BuildContext)> getRoutes({required bool token}) {
    return {
      ///Home
      '/': (context) => token ? const HomeScreen() : const LoginScreen(),

      ///Auth
      LoginScreen.routeName: (context) => const LoginScreen(),
      ForgetPassword.routeName: (context) => const ForgetPassword(),
      VerifyPassword.routeName: (context) => const VerifyPassword(),
      EmailVerification.routeName: (context) => const EmailVerification(),

      ///Menu Screen.
      HomeScreen.routeName: (context) => const HomeScreen(),

      ///todo Establishment Manager Screens
      ///todo HR Manager Screens
      /// todo Scheduler Manager Screens
    };
  }
}
