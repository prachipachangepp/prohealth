import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/login_module/forget_password/widgets/forget_password_mobile.dart';
import 'package:prohealth/presentation/screens/login_module/forget_password/widgets/forget_password_tablet.dart';
import 'package:prohealth/presentation/screens/login_module/forget_password/widgets/forget_password_web.dart';
import 'package:prohealth/presentation/widgets/responsive_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
        mobile: const ForgetPasswordMobile(),
        web: const ForgetPasswordWeb(),
        tablet: const ForgetPasswordTablet());
  }
}
