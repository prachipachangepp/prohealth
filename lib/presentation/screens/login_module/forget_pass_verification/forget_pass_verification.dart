import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/login_module/forget_pass_verification/widgets/forget_pass_verification_mobile.dart';
import 'package:prohealth/presentation/screens/login_module/forget_pass_verification/widgets/forget_pass_verification_tab.dart';
import 'package:prohealth/presentation/screens/login_module/forget_pass_verification/widgets/forget_pass_verification_web.dart';

import '../../../widgets/responsive_screen.dart';

class VerifyPassword extends StatelessWidget {
  static const String routeName = "/ForgetPasswordVerification";
  final String email;
  const VerifyPassword({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
        mobile: VerifyForgotPassMobile(
          email: email,
        ),
        web: VerifyForgotPassWeb(
          email: email,
        ),
        tablet: VerifyForgotPassTab(
          email: email,
        ));
  }
}
