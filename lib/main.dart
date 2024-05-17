import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/controller/controller.dart';
import 'package:prohealth/presentation/widgets/profile_bar/dummy_login.dart';
import 'package:prohealth/presentation/widgets/responsive_screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MyController myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        home:
        // MenuScreen()
            //HrAdministrativeScreen()
             //DumLogInScreen()
            // SMDesktop()
            // MobileLogIn()
            ///
            //  ResponsiveScreenSM()
            ///
            ResponsivePage(
          controller: myController,
        )
    );
  }
}
