import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/login_module/forget_pass_verification/widgets/forget_pass_verification_mobile.dart';
import 'package:prohealth/presentation/screens/login_module/forget_pass_verification/widgets/forget_pass_verification_tab.dart';
import 'package:prohealth/presentation/screens/login_module/forget_pass_verification/widgets/forget_pass_verification_web.dart';
import '../../../widgets/responsive_screen.dart';

class VerifyPassword extends StatelessWidget {
  static const String routeName = "/ForgetPasswordVerification";

  const VerifyPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
        mobile: const VerifyForgotPassMobile(),
        web: const VerifyForgotPassWeb(),
        tablet: const VerifyForgotPassTab());
  }
}
