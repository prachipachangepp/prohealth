import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'sm_desktop_screen.dart';

class ResponsiveScreenSM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 850) {
          // Render SMDesktop screen for large screens
          return SMDesktop();
        } else {
          // Render SMTablet screen for small screens
          return SMTablet();
        }
      },
    );
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
