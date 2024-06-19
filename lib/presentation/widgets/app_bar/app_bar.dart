import 'package:flutter/material.dart';
import 'package:prohealth/presentation/widgets/app_bar/app_bar_mobile.dart';
import 'package:prohealth/presentation/widgets/app_bar/app_bar_tab.dart';
import 'package:prohealth/presentation/widgets/app_bar/app_bar_web.dart';
import 'package:prohealth/presentation/widgets/app_bar/responsive_app_bar.dart';

class AppBar extends StatelessWidget {
  const AppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveAppBar(
        mobile: const AppBarMobile(),
        web: AppBarWeb(),
        tablet: const AppBarTab());
  }
}
