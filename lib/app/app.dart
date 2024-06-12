import 'package:flutter/material.dart';
import 'package:prohealth/app/routes_manager.dart';

import '../presentation/screens/em_module/em_desktop_screen.dart';


class App extends StatelessWidget {
  final bool signedIn;

  const App({super.key, required this.signedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home:  SMDesktop(),
      initialRoute: "/home",
      routes: RoutesManager().getRoutes(token: signedIn),
    );
  }
}
