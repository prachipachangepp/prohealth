import 'dart:core';
import 'package:flutter/material.dart';
import 'package:prohealth/presentation/tablet_screen/mobile_login_screen.dart';
import 'package:prohealth/presentation/widgets/login_screen/login_screen.dart';
import 'package:prohealth/presentation/widgets/login_screen/menu_login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/hr_module/manage/controller/controller.dart';

///todo prachi

///old one
class ResponsivePage extends StatelessWidget {
  Future getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString("access_token");
    return token ?? "";
  }

  final MyController controller;
  ResponsivePage({required this.controller});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          controller.checkScreenType(screenWidth);
          if (controller.isTabletScreen.value) {
            return Container(child: MobileLogIn());
          } else {
            return FutureBuilder(
                future: getToken(),
                builder: (context, token) {
                  if (token.hasData) {
                    String d = token.data.toString();
                    return d.isEmpty ? LoginScreen() : MenuScreen();
                  } else {
                    return Scaffold();
                  }
                });
            // return SingleChildScrollView(
            // scrollDirection: Axis.vertical, child: HomeScreen());
          }
        },
      ),
    );
  }
}
