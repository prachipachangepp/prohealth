// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/login_module/login_password/widgets/login_password_mobile.dart';
import 'package:prohealth/presentation/screens/login_module/login_password/widgets/login_password_tab.dart';
import 'package:prohealth/presentation/screens/login_module/login_password/widgets/login_password_web.dart';
import '../../../widgets/responsive_screen.dart';

class LoginWithPassword extends StatelessWidget {
  static const String label = "/logInWithPassword";
  final String email;
  const LoginWithPassword({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
        mobile: LoginPasswordMobile(email: email,),
        web: LoginPasswordWeb(email: email,),
        tablet: LoginPassswordTab(email: email,));
  }
}
