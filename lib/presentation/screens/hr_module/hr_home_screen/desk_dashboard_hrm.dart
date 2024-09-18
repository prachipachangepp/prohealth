import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/hr_home_screen/home_hr.dart';

///saloni
class HomeScreenHRM extends StatefulWidget {
  const HomeScreenHRM({super.key});

  @override
  State<HomeScreenHRM> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenHRM> {
  @override
  Widget build(BuildContext context) {
    return HomeHrScreen();
  }
}
