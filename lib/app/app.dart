import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/provider/navigation_provider.dart';
import 'package:prohealth/app/routes_manager.dart';
import 'package:prohealth/presentation/screens/login_module/login/login_screen.dart';
import 'package:provider/provider.dart';

import '../presentation/screens/home_module/home_screen.dart';
import '../presentation/screens/hr_module/register/widgets/after_clicking_on_link/on_boarding_welcome.dart';

class App extends StatefulWidget {
  final bool signedIn;

  const App({super.key, required this.signedIn});
  @override
  _App createState() => _App();
}

class _App extends State<App> {
  bool _hasShownSplash = false;

  @override
  void initState() {
    super.initState();
    // Listen for messages from JavaScript
    html.window.onMessage.listen((event) {
      if (event.data == 'newVersionAvailable') {
        // Show update dialog
        _showUpdateDialog();
      }
    });
    // If splash screen hasn't been shown, navigate to it.
    // if (!_hasShownSplash) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     _navigateToSplashScreen();
    //   });
    // }
  }

  void _showUpdateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("New Version Available"),
          content: Text(
              "A new version of the app is available. Would you like to reload to get the latest updates?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text("Later"),
            ),
            TextButton(
              onPressed: () {
                // Reload the app to load the new version
                html.window.location.reload();
              },
              child: Text("Reload"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // bool isChrome = html.window.navigator.userAgent.contains("chrome");
    // if(!isChrome){
    //   return MaterialApp(
    //     home: Scaffold(
    //       body: Center(child: Text("This Website only supports on Google Chrome"),),
    //     ),
    //   );
    // }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          // primary: const Colors.yellow[700],
          // secondary: const Colors.yellow.shade700,

          // or from RGB

          primary: const Color(0xff50B5E5),
          //secondary: const Color(0xff50B5E5),
        ),
        useMaterial3: false,
        // primarySwatch: Ma,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: _hasShownSplash
          ? '/'
          : widget.signedIn == true
              ? HomeScreen.routeName
              : LoginScreen.routeName,
      routes: RoutesManager().getRoutes(token: widget.signedIn),
      onGenerateRoute: (settings) {
        final routeProvider =
            Provider.of<RouteProvider>(context, listen: false);
        final route = routeProvider.currentRoute;

        print("current Route :" + route.toString());

        switch (route) {
          case '/':
            if (settings.name != "/") {
              return MaterialPageRoute(
                builder: (context) => SplashScreen(
                  onFinish: () =>
                      Navigator.of(context).pushReplacementNamed(route),
                ),
              );
            } else if (widget.signedIn == false) {
              return MaterialPageRoute(
                builder: (context) => SplashScreen(
                  onFinish: () => Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName),
                ),
              );
            }

          case '/onBordingWelcome':
            return MaterialPageRoute(
              builder: (context) => SplashScreen(
                onFinish: () => Navigator.of(context)
                    .pushReplacementNamed(OnBoardingWelcome.routeName),
              ),
            );
          default:
            _hasShownSplash = true;
            return MaterialPageRoute(
              builder: (context) => SplashScreen(
                onFinish: () =>
                    Navigator.of(context).pushReplacementNamed(route),
              ),
            );
        }
      },
    );
  }
}

class NonChromeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          // primary: const Colors.yellow[700],
          // secondary: const Colors.yellow.shade700,

          // or from RGB

          primary: const Color(0xff50B5E5),
          //secondary: const Color(0xff50B5E5),
        ),
        useMaterial3: false,
        // primarySwatch: Ma,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                // "images/logo_login.png",
                "images/powered_logo.png",
                scale: 1.1,
              ),
              SizedBox(
                height: 80,
              ),
              Text(
                "This application is supported only in Google Chrome.",
                style: TextStyle(
                  fontSize: 28,
                  color: ColorManager.bluebottom,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Please open this application using Google Chrome.",
                style: TextStyle(
                  fontSize: 18,
                  color: ColorManager.textPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Image.asset(
                "images/chrome.png",
                scale: 7,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  final VoidCallback? onFinish;
  SplashScreen({this.onFinish});
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      if (onFinish != null) {
        onFinish!();
      } else {
        Navigator.of(context).pushReplacementNamed('/');
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'images/splash_logo.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
