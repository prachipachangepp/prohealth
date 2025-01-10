import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/provider/hr_register_provider.dart';
import 'package:prohealth/app/resources/provider/navigation_provider.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/presentation/screens/em_module/see_all_screen/see_all_provider.dart';
import 'package:prohealth/presentation/screens/em_module/see_all_screen/widgets/user_create_provider.dart';
import 'package:prohealth/presentation/screens/em_module/see_all_screen/widgets/user_delete_provider.dart';
import 'package:prohealth/presentation/screens/em_module/see_all_screen/widgets/user_edit_provider.dart';
import 'package:prohealth/presentation/screens/hr_module/add_employee/widget/dateprovider.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/pagination_widget.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'presentation/screens/hr_module/hr_home_screen/referesh_provider.dart';
import 'presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_plan_care/planer_notifier.dart';

Future<void> main() async {
  bool token = await checkToken();

  // Register the view factory for the iframe
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
          ChangeNotifierProvider(
            create: (_) => PageIndexProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => SeeAllPaginationProvider(itemsPerPage: 10),
          ),
          ChangeNotifierProvider(create: (_) => SeeAllProvider()),
          ChangeNotifierProvider(create: (_) => UserCreationProvider()),
          ChangeNotifierProvider(
            create: (context) => DeleteUserPopupProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => EditUserProvider(),
          ),
          ChangeNotifierProvider(
              create: (context) => AddressProvider(
                  controller: '' as TextEditingController,
                  onChange: '' as Function(String p1)?)),
          ChangeNotifierProvider(
              create: (_)=>HrManageProvider()
          ),
          ChangeNotifierProvider(
              create: (_)=>HrRegisterProvider()
          ),
          ChangeNotifierProvider(
              create: (_)=>HrEnrollEmployeeProvider()
          ),
          ChangeNotifierProvider(create: (context)=>AddressProvider(controller: '' as TextEditingController,onChange: '' as Function(String p1)?))
        ],

        child: App(
          signedIn: token,
        ),
        //child: NonChromeApp(),
      ),
    );
  } else {
    runApp(NonChromeApp());
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
