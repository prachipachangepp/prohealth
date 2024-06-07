import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/login_module/login/widgets/login_mobile.dart';
import 'package:prohealth/presentation/screens/login_module/login/widgets/login_tablet.dart';
import 'package:prohealth/presentation/screens/login_module/login/widgets/login_web.dart';
import 'package:prohealth/presentation/widgets/responsive_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/logIn";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
        mobile: LoginMobile(),
        web: const LoginWeb(),
        tablet: const LoginTablet());
  }
}
