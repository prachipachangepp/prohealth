import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/screen_route_name.dart';
import 'package:prohealth/presentation/screens/home_module/widgets/home_screen_mobile.dart';
import 'package:prohealth/presentation/screens/home_module/widgets/home_screen_tab.dart';
import 'package:prohealth/presentation/screens/home_module/widgets/menu_web.dart';
import 'package:prohealth/presentation/widgets/responsive_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = RouteStrings.home;
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
        mobile: const HomeScreenMobile(),
        web: const HomeScreenWeb(),
        tablet: const HomeScreenTab());
  }
}
