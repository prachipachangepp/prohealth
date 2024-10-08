import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/screen_route_name.dart';

class DashboardMainButtonScreen extends StatelessWidget {
  static const String routeName = RouteStrings.emMainDashboard;
  const DashboardMainButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.asset(
          'images/EMDASHBOARD.jpg',
          fit: BoxFit.contain,
        ));
  }
}
