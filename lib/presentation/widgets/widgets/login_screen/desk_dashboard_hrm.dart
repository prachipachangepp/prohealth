import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../screens/hr_module/manage/controller/controller.dart';
import '../const_appbar/app_bar.dart';

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
    return
        // HrAppBar();
        MyAppBar();
  }
}
