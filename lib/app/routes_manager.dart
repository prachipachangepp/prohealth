import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/home_module/home_screen.dart';
import 'package:prohealth/presentation/screens/login_module/email_verification/email_verification.dart';
import 'package:prohealth/presentation/screens/login_module/forget_pass_verification/forget_pass_verification.dart';
import 'package:prohealth/presentation/screens/login_module/forget_password/forget_password_screen.dart';
import 'package:prohealth/presentation/screens/login_module/login/login_screen.dart';

import '../data/navigator_arguments/screen_arguments.dart';

class RoutesManager {
  String fetchEmailFromArgs(BuildContext context) {
    String email = "";
    var v = ModalRoute.of(context)!.settings.arguments ??
        ScreenArguments(title: "");
    final args = v as ScreenArguments;
    email = args.title!;
    return email;
  }

  Map<String, Widget Function(BuildContext)> getRoutes({required bool token}) {
    return {
      ///Home
      '/': (context) => token ? const HomeScreen() : const LoginScreen(),

      ///Auth
      LoginScreen.routeName: (context) => const LoginScreen(),
      ForgetPassword.routeName: (context) => const ForgetPassword(),
      VerifyPassword.routeName: (context) => VerifyPassword(
            email: fetchEmailFromArgs(context),
          ),
      EmailVerification.routeName: (context) => EmailVerification(
            email: fetchEmailFromArgs(context),
          ),

      ///Menu Screen.
      HomeScreen.routeName: (context) => const HomeScreen(),

      ///todo Establishment Manager Screens
      ///todo HR Manager Screens
      /// todo Scheduler Manager Screens
    };
  }
}
