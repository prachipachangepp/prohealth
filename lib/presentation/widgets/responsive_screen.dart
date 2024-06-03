import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prohealth/presentation/screens/desktop_module/hr_module/manage/controller/controller.dart';

class ResponsiveScreen extends StatelessWidget {
  ResponsiveScreen(
      {super.key,
      required this.mobile,
      required this.web,
      required this.tablet});
  final ScreenSizeController controller = Get.put(ScreenSizeController());
  final Widget mobile, web, tablet;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        controller.checkScreenType(screenWidth);
        if (controller.isTabletScreen.value) {
          print(controller.isTabletScreen.value);
          return tablet;
        } else if (controller.isMobileScreen.value) {
          print(controller.isMobileScreen.value);
          return mobile;
        } else if (controller.isDesktopScreen.value) {
          print(controller.isDesktopScreen.value);
          return web;
        } else {
          return Scaffold();
          // return SingleChildScrollView(
          // scrollDirection: Axis.vertical, child: HomeScreen());
        }
      },
    );
  }
}
