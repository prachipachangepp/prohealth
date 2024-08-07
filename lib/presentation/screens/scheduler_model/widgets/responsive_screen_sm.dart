import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/scheduler_model/widgets/sm_desktop_screen.dart';

class ResponsiveScreenSM extends StatelessWidget {
  const ResponsiveScreenSM({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          return SMHomeScreen();
        } else {
          return Container(
            color: Colors.white,
            height: 100,
            width: 500,
            child: Center(
              child: Text('Tablet Screen Scheduler & Intake',style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }
      },
    );
  }
}

class SMHomeScreen extends StatefulWidget {
  const SMHomeScreen({super.key});

  @override
  State<SMHomeScreen> createState() => _EMHomeScreenState();
}

class _EMHomeScreenState extends State<SMHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SMDesktopScreen();
  }
}
