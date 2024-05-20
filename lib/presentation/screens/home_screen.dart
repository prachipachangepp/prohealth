import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'desktop_module/hr_module/manage/controller/controller.dart';
import 'desktop_module/widgets/const_appbar/app_bar.dart';

///saloni
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MyController myController = Get.find();

  @override
  Widget build(BuildContext context) {
    return
      // HrAppBar();
      MyAppBar();
  }
}
