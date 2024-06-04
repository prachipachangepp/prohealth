import 'package:flutter/material.dart';
import 'package:prohealth/app/routes_manager.dart';
import 'package:prohealth/presentation/screens/desktop_module/hr_module/manage/web_manage/manage_screen.dart';


class App extends StatelessWidget {
  final bool signedIn;

  const App({super.key, required this.signedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home:  ManagePopUpScreen(),
      initialRoute: "/",
      routes: RoutesManager().getRoutes(token: signedIn),
    );
  }
}


