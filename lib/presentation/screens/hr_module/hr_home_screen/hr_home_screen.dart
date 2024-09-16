import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/screen_route_name.dart';
import 'package:prohealth/presentation/screens/hr_module/hr_home_screen/desk_dashboard_hrm.dart';

class HRHomeScreen extends StatelessWidget {
  static const String routeName = RouteStrings.hrDesktop;
  HRHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          return HomeScreenHRM();
        } else {
          return Material(
            child: Container(
              child: Center(
                child: Text("Tablet"),
              ),
            ),
          );
        }
      },
    );
  }

  // Widget build(BuildContext context) {
  //   return ResponsiveScreen(
  //       mobile: Material(
  //         child: Container(
  //           child: Center(
  //             child: Text(
  //               "Mobile"
  //             ),
  //           ),
  //         ),
  //       ),
  //       web:HomeScreenHRM(),
  //       tablet: Material(
  //         child: Container(
  //           child: Center(
  //             child: Text(
  //                 "Tablet"
  //             ),
  //           ),
  //         ),
  //       ),);
  // }
}
