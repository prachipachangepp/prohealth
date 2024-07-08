
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/presentation/widgets/widgets/login_screen/desk_dashboard_hrm.dart';

import '../../../widgets/responsive_screen.dart';

class HRHomeScreen extends StatelessWidget {
   // static const String routeName = "/hr home";
  HRHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
        mobile: Material(
          child: Container(
            child: Center(
              child: Text(
                "Mobile"
              ),
            ),
          ),
        ),
        web:HomeScreenHRM(),
        tablet: Material(
          child: Container(
            child: Center(
              child: Text(
                  "Tablet"
              ),
            ),
          ),
        ),);
  }
}
