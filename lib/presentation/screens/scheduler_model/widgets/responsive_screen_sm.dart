import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/scheduler_model/widgets/sm_desktop_screen.dart';

class ResponsiveScreenSM extends StatelessWidget {
  const ResponsiveScreenSM({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 850) {
          return SMDesktopScreen();
        } else {
          return const EMTabletScreen();
        }
      },
    );
  }
}

class EMTabletScreen extends StatelessWidget {
  const EMTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tablet Screen'),
      ),
      body: Center(
        child: Text(
          'Tablet Screen Scheduler & Intake',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
