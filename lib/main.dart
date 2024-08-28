import 'package:flutter/material.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/add_employee/widget/dateprovider.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_plan_care/planer_notifier.dart';



Future<void> main() async {
  bool token = await checkToken();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DateProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ContainerProvider(),
        ),
      ],
      child: App(
        signedIn: token,
      ),
    ),
  );
  // runApp(
  //     ChangeNotifierProvider(
  //         create: (context) => DateProvider(),
  //    child: App(
  //       signedIn: token,
  //     )
  // ));
}

Future<bool> checkToken() async {
  String token = await TokenManager.getAccessToken();
  if (token.isEmpty) {
    return false;
  } else {
    return true;

  }
}

