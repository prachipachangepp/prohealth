import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/sm_module/app_bar_sm.dart';

class ResponsiveScreenSM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 850) {
          return SMDesktop();
        } else {
          return SMTablet();
        }
      },
    );
  }
}

class SMDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBarSM();
  }
}

class SMTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tablet Screen'),
      ),
      body: Center(
        child: Text(
          'Tablet Screen Content',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}