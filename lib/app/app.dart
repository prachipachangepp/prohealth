import 'package:flutter/material.dart';
import 'package:prohealth/app/routes_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/hr_home_screen/hr_home_screen.dart';

import '../presentation/screens/home_module/home_screen.dart';
import '../presentation/screens/login_module/login/login_screen.dart';


class App extends StatelessWidget {
  //final String userName;
  final bool signedIn;

   App({super.key, required this.signedIn,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
       // home:  HRHomeScreen(),
      // initialRoute: "/",
      // routes: RoutesManager().getRoutes(token: signedIn),
      home: SplashScreen(signedIn: signedIn),
      routes: RoutesManager().getRoutes(token: signedIn),
    );
  }
}
class SplashScreen extends StatefulWidget {
  final bool signedIn;

  const SplashScreen({super.key, required this.signedIn});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(
          widget.signedIn ? HomeScreen.routeName : LoginScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "images/splash_logo.png",
        fit: BoxFit.cover,
        // height: double.infinity,
        // width: double.infinity,
        ),
      ),
    );
  }
}
