import 'dart:core';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../hr_module/manage/controller/controller.dart';
import 'login_screen/login_screen.dart';
import 'login_screen/menu_login_page.dart';


// class ResponsivePage extends StatelessWidget {
//   Future<String> getToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString("access_token") ?? "";
//     return token;
//   }
//
//   final MyController controller;
//   ResponsivePage({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           controller.checkScreenType(constraints.maxWidth);
//           return FutureBuilder(
//             future: getToken(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 /// Show loading indicator while fetching token
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 /// Handle error
//                 return Scaffold(body: Center(child: Text('Error')));
//               } else {
//                 /// Check if token is available
//                 String token = snapshot.data as String;
//                 if (token.isEmpty) {
//                   /// Show login screen if token is empty
//                   return LoginScreen();
//                 } else {
//                   /// Show menu screen if token is not empty
//                   return MenuScreen();
//                 }
//               }
//             },
//           );
//         },
//       ),
//     );
//   }
// }

///
// ///todo prachi
//
// ///old one
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
                    return d.isEmpty ? LoginScreen() : MenuScreen();
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
