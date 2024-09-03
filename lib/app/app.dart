import 'package:flutter/material.dart';
import 'package:prohealth/app/routes_manager.dart';
import 'package:prohealth/presentation/screens/home_module/home_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/on_boarding_welcome.dart';
import 'package:prohealth/presentation/screens/login_module/login/login_screen.dart';

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
    // If splash screen hasn't been shown, navigate to it.
    if (!_hasShownSplash) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateToSplashScreen();
      });
    }
  }

  void _navigateToSplashScreen() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SplashScreen()),
    );
      _hasShownSplash = true;
  }

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
      initialRoute: _hasShownSplash ? '/' :widget.signedIn == true?HomeScreen.routeName:LoginScreen.routeName,
      routes: RoutesManager().getRoutes(token: widget.signedIn),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            if (widget.signedIn == false) {
              return MaterialPageRoute(
                builder: (context) => SplashScreen(
                  onFinish: () => Navigator.of(context).pushReplacementNamed(LoginScreen.routeName),
                ),
              );
            }
          case '/onBordingWelcome':
            return MaterialPageRoute(
              builder: (context) => SplashScreen(
                onFinish: () => Navigator.of(context).pushReplacementNamed(OnBoardingWelcome.routeName),
              ),
            );
          default:
            _hasShownSplash = true;
            return MaterialPageRoute(
              builder: (context) => SplashScreen(
                onFinish: () => Navigator.of(context).pushReplacementNamed(settings.name!),
              ),
            );
        }
      },
      // onGenerateRoute: (settings) {
      //   if ( settings.name != '/') {
      //     _hasShownSplash = true;
      //      MaterialPageRoute(
      //       builder: (context) => SplashScreen(
      //         onFinish: () => Navigator.of(context).pushReplacementNamed(settings.name!),
      //       ),
      //     );
      //   }else if(widget.signedIn == false){
      //     return MaterialPageRoute(
      //       builder: (context) => SplashScreen(
      //         onFinish: () => Navigator.of(context).pushReplacementNamed(LoginScreen.routeName),
      //       ),
      //     );
      //   }else if(settings.name == "/onBordingWelcome"){
      //     return MaterialPageRoute(
      //       builder: (context) => SplashScreen(
      //         onFinish: () => Navigator.of(context).pushReplacementNamed(OnBoardingWelcome.routeName),
      //       ),
      //     );
      //   }
      //   else{
      //     return MaterialPageRoute(
      //       builder: (context) => SplashScreen(
      //         onFinish: () => Navigator.of(context).pushReplacementNamed(LoginScreen.routeName),
      //       ),
      //     );
      //   }
      // },
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
        child: Image.asset('images/splash_logo.png',fit: BoxFit.contain,),
      ),
    );
  }
}
