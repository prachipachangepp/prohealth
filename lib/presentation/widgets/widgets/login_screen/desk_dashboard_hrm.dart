import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prohealth/presentation/screens/hr_module/hr_home_screen/home_hr.dart';
import '../../../screens/hr_module/manage/controller/controller.dart';
import '../const_appbar/app_bar.dart';
import '../const_appbar/dum_hr_aapbar.dart';

///saloni
class HomeScreenHRM extends StatefulWidget {
  const HomeScreenHRM({super.key});

  @override
  State<HomeScreenHRM> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenHRM> {
  final ScreenSizeController myController = Get.find();

  @override
  Widget build(BuildContext context) {
    return HomeHrScreen();
      //return HrAppBar();
        // MyAppBar();
  }
}
