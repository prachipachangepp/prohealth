import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/provider/navigation_provider.dart';
import 'package:prohealth/app/routes_manager.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
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
  String? initialVersion;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Listen for messages from JavaScript
    // If splash screen hasn't been shown, navigate to it.
    // if (!_hasShownSplash) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     _navigateToSplashScreen();
    //   });
    // }
    _initializeVersion();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) => _checkForUpdate());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _initializeVersion() {
    initialVersion = html.document
        .querySelector('meta[name="build-version"]')
        ?.getAttribute("content");
  }

  void _checkForUpdate() {
    final currentVersion = html.document
        .querySelector('meta[name="build-version"]')
        ?.getAttribute("content");
    if (currentVersion != initialVersion) {
      _showUpdateDialog();
    }
  }

  void _showUpdateDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("New Update Available"),
        content: Text(
            "A new version of the app is available. Please refresh to update."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Later"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _reloadPage();
            },
            child: Text("Refresh"),
          ),
        ],
      ),
    );
  }

  void _reloadPage() {
    html.window.location.reload();
  }

  Future<void> setToken() async {
    TokenManager.setAccessToken(
        token: "yergtvskdvhvsavasgdguiasgdu",
        username: "",
        companyId: 1,
        userID: 1,
        email: "");
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
            // widget.signedIn?(){}:setToken();
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
