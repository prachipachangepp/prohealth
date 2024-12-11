import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/provider/navigation_provider.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/add_employee/widget/dateprovider.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_plan_care/planer_notifier.dart';

Future<void> main() async {
  bool token = await checkToken();
  if (isChrome()) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => DateProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ContainerProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => RouteProvider(),
          ),
        ],
        child: App(
          signedIn: token,
        ),
      ),
    );
  } else {
    showNotSupportedMessage();
  }

  // runApp(
  //     ChangeNotifierProvider(
  //         create: (context) => DateProvider(),
  //    child: App(
  //       signedIn: token,
  //     )
  // ));
}

// Function to detect if the browser is Chrome
bool isChrome() {
  final userAgent = html.window.navigator.userAgent.toLowerCase();

  // Check for Chrome, but exclude Edge and Opera
  bool isChrome = userAgent.contains('chrome') &&
      !userAgent.contains('edg') &&
      !userAgent.contains('opr');

  // Additional check: Chrome should have 'google' in the vendor property
  bool isGoogleVendor =
      html.window.navigator.vendor.toLowerCase().contains('google');

  return isChrome && isGoogleVendor;
}

// Show a message if the browser is not Chrome
void showNotSupportedMessage() {
  html.document.body!.innerHtml = '''
    <h1>This application is supported only in Google Chrome.</h1>
    <p>Please open this application using Google Chrome.</p>
  ''';
}

Future<bool> checkToken() async {
  String token = await TokenManager.getAccessToken();
  if (token.isEmpty) {
    return false;
  } else {
    return true;
  }
}
