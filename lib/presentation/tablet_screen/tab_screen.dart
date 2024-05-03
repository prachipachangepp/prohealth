import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/controller/controller.dart';
import 'package:prohealth/presentation/tablet_screen/login_screen_flow/login_base_const.dart';

///prachi
class TabletScreen extends StatelessWidget {
  final MyController myController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBaseConst(
        titleText: AppString.login, onTap: () {  },
        bottomText: AppString.forgotpass,
        textActionPadding: EdgeInsets.only(right: 10),
        child: Container(),
      ),
    );
  }
}
