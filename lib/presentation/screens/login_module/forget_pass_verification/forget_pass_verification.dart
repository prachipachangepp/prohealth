import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prohealth/presentation/screens/desktop_module/widgets/login_screen/widgets/login_flow_base_struct.dart';
import 'package:prohealth/presentation/screens/login_module/forget_pass_verification/widgets/forget_pass_verification_mobile.dart';
import 'package:prohealth/presentation/screens/login_module/forget_pass_verification/widgets/forget_pass_verification_tab.dart';
import 'package:prohealth/presentation/screens/login_module/forget_pass_verification/widgets/forget_pass_verification_web.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/const_string.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/theme_manager.dart';
import '../../../../app/resources/value_manager.dart';
import '../../../../data/navigator_arguments/screen_arguments.dart';
import '../../../widgets/responsive_screen.dart';
import '../../desktop_module/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../desktop_module/widgets/profile_bar/widget/screen_transition.dart';
import '../../mobile_module/mobile_const.dart';
import '../../tablet_module/tab_const.dart';
import '../login/login_screen.dart';
import '../update_password/update_password.dart';

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
