import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/home_module/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/screens/desktop_module/widgets/login_screen/menu_login_page.dart';
import '../presentation/screens/login_module/login/login_screen.dart';

class App extends StatelessWidget {
  Future getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("access_token");
    return token ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        home: HomeScreen()
            //HrAdministrativeScreen()
            //DummyScreen()
            //SMDesktop()
            // MobileLogIn()
            ///
            //  ResponsiveScreenSM()
            ///
            // FutureBuilder(
            //     future: getToken(),
            //     builder: (context, token) {
            //       if (token.hasData) {
            //         String d = token.data.toString();
            //         return d.isEmpty ? LoginScreen() : HomeScreen();
            //       } else {
            //         return Scaffold();
            //       }
            //     })
    );
  }
}
