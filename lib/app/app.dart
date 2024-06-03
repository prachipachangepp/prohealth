import 'package:flutter/material.dart';
import 'package:prohealth/app/routes_manager.dart';

class App extends StatelessWidget {
  final bool signedIn;

  const App({super.key, required this.signedIn});

  @override
  Widget build(BuildContext context) {
    print(signedIn);
    print("Signed in");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: RoutesManager().getRoutes(token: signedIn),
    );
  }
}
