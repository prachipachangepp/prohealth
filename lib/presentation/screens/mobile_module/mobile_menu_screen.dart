import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/mobile_module/widgets/mobile_const.dart';

class MobileMenuScreen extends StatefulWidget {
  const MobileMenuScreen({Key? key}) : super(key: key);

  @override
  State<MobileMenuScreen> createState() => _MobileMenuScreenState();
}

class _MobileMenuScreenState extends State<MobileMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileConst(
        mobileChild: Container(),
        titleText: '',
        textAction: '',
        onTap: () {},
      ),
    );
  }
}
