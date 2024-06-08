import 'dart:core';

import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/home_module/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/hr_module/manage/controller/controller.dart';
import '../../screens/login_module/login/login_screen.dart';

///todo prachi
///old one
class ResponsivePage extends StatelessWidget {
  Future getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString("access_token");
    return token ?? "";
  }

  final ScreenSizeController controller;
  ResponsivePage({required this.controller});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          controller.checkScreenType(screenWidth);
          // if (controller.isTabletScreen.value) {
          //  // return Container(child: MobileLogIn());
          //   return Container(child: Container(
          //       height: MediaQuery.of(context).size.height, color: Colors.green,
          //       child: Center(child: Text("Mobile Screen"),)
          //   ));
          // } else
          //if{
          return FutureBuilder(
              future: getToken(),
              builder: (context, token) {
                if (token.hasData) {
                  String d = token.data.toString();
                  return d.isEmpty ? LoginScreen() : HomeScreen();
                } else {
                  return Scaffold();
                }
              });
          // return SingleChildScrollView(
          // scrollDirection: Axis.vertical, child: HomeScreen());
          //}
        },
      ),
    );
  }
}
