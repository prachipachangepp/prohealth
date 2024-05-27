import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:prohealth/presentation/screens/desktop_module/hr_module/manage/controller/controller.dart';
import 'package:prohealth/presentation/screens/desktop_module/widgets/responsive_screens.dart';
import 'package:prohealth/presentation/screens/mobile_module/mobile_menu_screen.dart';

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
            // MobileMenuScreen()
            // TabLoginScreen()
            //ForgotPassScreen()
            //SMDesktop()
            ///
            ResponsivePage(
          controller: myController,
        )
    );
  }
}
