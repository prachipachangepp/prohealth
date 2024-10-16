import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prohealth/app/resources/screen_route_name.dart';
import 'package:prohealth/presentation/screens/em_module/em_desktop_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/hr_home_screen/desk_dashboard_hrm.dart';

class HRHomeScreen extends StatelessWidget {
  static const String routeName = RouteStrings.hrDesktop;
  HRHomeScreen({super.key});
  final ButtonSelectionController myController =
      Get.put(ButtonSelectionController());

  @override
  Widget build(BuildContext context) {
    myController.selectButton(0);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          return Padding(
            padding: MediaQuery.of(context).size.width > 1920
                ? EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 8)
                : EdgeInsets.all(0.0),
            child: HomeScreenHRM(),
          );
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
