import 'package:flutter/material.dart';
import 'package:prohealth/app/routes_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/hr_home_screen/hr_home_screen.dart';


class App extends StatelessWidget {
  //final String userName;
  final bool signedIn;

  const App({super.key, required this.signedIn,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
       // home:  HRHomeScreen(),
      initialRoute: "/",
      routes: RoutesManager().getRoutes(token: signedIn),
    );
  }
}
