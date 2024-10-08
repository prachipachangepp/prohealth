import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/resources/screen_route_name.dart';
import 'em_desktop_screen.dart';

class ResponsiveScreenEM extends StatelessWidget {
  static const String routeName = RouteStrings.emDesktop;
  ResponsiveScreenEM({super.key});
  final ButtonSelectionController myController =
  Get.put(ButtonSelectionController());
  @override
  Widget build(BuildContext context) {
    myController.selectButton(0);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 850) {
          return EMDesktopScreen();
        } else {
          return SMTablet();
        }
      },
    );
  }
}

class SMTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tablet Screen'),
      ),
      body: Center(
        child: Text(
          'Tablet Screen Content',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
