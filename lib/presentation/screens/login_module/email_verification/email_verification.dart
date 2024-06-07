import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/login_module/email_verification/widgets/email_verification_mobile.dart';
import 'package:prohealth/presentation/screens/login_module/email_verification/widgets/email_verification_tab.dart';
import 'package:prohealth/presentation/screens/login_module/email_verification/widgets/email_verification_web.dart';
import 'package:prohealth/presentation/widgets/responsive_screen.dart';

class EmailVerification extends StatelessWidget {
  static const String routeName = "/emailVerification";

  const EmailVerification({super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
        mobile: const EmailVerifyMobile(),
        web: const EmailVerifyWeb(),
        tablet: const EmailVerifyTab());
  }
}