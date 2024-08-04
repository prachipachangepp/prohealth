import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/home_module/home_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/on_boarding_welcome.dart';
import 'package:prohealth/presentation/screens/login_module/email_verification/email_verification.dart';
import 'package:prohealth/presentation/screens/login_module/forget_pass_verification/forget_pass_verification.dart';
import 'package:prohealth/presentation/screens/login_module/forget_password/forget_password_screen.dart';
import 'package:prohealth/presentation/screens/login_module/login/login_screen.dart';

import '../data/navigator_arguments/screen_arguments.dart';

// class RoutesManager {
//   String getArgumentTitle(BuildContext context) {
//     try {
//       final args =
//           ModalRoute.of(context)!.settings.arguments as ScreenArguments;
//       String email = args.title ?? "";
//       return email;
//     } catch (e) {
//       return "";
//     }
//   }
//
//   Map<String, Widget Function(BuildContext)> getRoutes({required bool token, String? userName}) {
//     return {
//       ///Home
//       '/': (context) => token ? const HomeScreen() : const LoginScreen(),
//       // "/": (context) => SMDesktop(),
//
//       ///Auth
//       LoginScreen.routeName: (context) => const LoginScreen(),
//       ForgetPassword.routeName: (context) => const ForgetPassword(),
//       VerifyPassword.routeName: (context) =>
//           getArgumentTitle(context).isNotEmpty
//               ? VerifyPassword(
//                   email: getArgumentTitle(context),
//                 )
//               : const LoginScreen(),
//       EmailVerification.routeName: (context) =>
//           getArgumentTitle(context).isNotEmpty
//               ? EmailVerification(
//                   email: getArgumentTitle(context),
//                 )
//               : const LoginScreen(),
//
//       ///Menu Screen.
//       HomeScreen.routeName: (context) => const HomeScreen(),
//
//       ///todo Establishment Manager Screens
//       ///todo HR Manager Screens
//       /// todo Scheduler Manager Screens
//     };
//   }
// }

///
class RoutesManager {
  String getArgumentTitle(BuildContext context) {
    try {
      final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
      String email = args.title ?? "";
      return email;
    } catch (e) {
      return "";
    }
  }

  Map<String, Widget Function(BuildContext)> getRoutes({required bool token, String? userName}) {
    return {
      LoginScreen.routeName: (context) => const LoginScreen(),
      ForgetPassword.routeName: (context) => const ForgetPassword(),
      VerifyPassword.routeName: (context) =>
      getArgumentTitle(context).isNotEmpty
          ? VerifyPassword(email: getArgumentTitle(context))
          : const LoginScreen(),
      EmailVerification.routeName: (context) =>
      getArgumentTitle(context).isNotEmpty
          ? EmailVerification(email: getArgumentTitle(context))
          : const LoginScreen(),
      HomeScreen.routeName: (context) => const HomeScreen(),
     OnBoardingWelcome.routeName :(context) => const OnBoardingWelcome(),
    };
  }
}
