import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/em_module/dashboard/widgets/screens/widgets/general_setting_const.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/header_content_const.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../em_dashboard_const.dart';

class GeneralSettingScreen extends StatelessWidget {
  const GeneralSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                flex: 4,
                child: Column(children: [
                 GeneralSettingConst(),
                  SizedBox(height: 20,),
                  EMDashboardAllBlueSideContainer(
                      height: 100,
                      child: Container()),
                  SizedBox(height: AppPadding.p20,),
                  Row(children: [
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: 100,
                          child: Container()),
                    ),
                    SizedBox(width: 30,),
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: 100,
                          child: Container()),
                    ),
                  ],),
                  SizedBox(height: AppPadding.p10,),
                  Row(children: [
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: 100,
                          child: Container()),
                    ),
                    SizedBox(width: 30,),
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: 100,
                          child: Container()),
                    ),
                  ],),
                  SizedBox(height: AppPadding.p10,),
                  Row(children: [
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: 100,
                          child: Container()),
                    ),
                    SizedBox(width: 30,),
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: 100,
                          child: Container()),
                    ),
                  ],),
                  SizedBox(height: AppPadding.p10,),
                  Row(children: [
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: 100,
                          child: Container()),
                    ),
                    SizedBox(width: 30,),
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: 100,
                          child: Container()),
                    ),
                  ],),
                ],),
              ),
              SizedBox(width: AppSize.s15,),

              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    UserRoleDistribution(),
                    SizedBox(height: 20,),
                    Container(
                      height: 550,
                      padding: EdgeInsets.all(AppPadding.p10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        // border: Border.symmetric(vertical: BorderSide.none,horizontal: BorderSide(width: 1,color: Color(0xFFBCBCBC)),),//all(width: 1, color: Color(0xFFBCBCBC)),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.black.withOpacity(0.2),
                            blurRadius: 6.3,
                            spreadRadius: 0,
                            offset: const Offset(0, 14), // Downward shadow
                          ),
                        ],
                      ),
                      child: Container(),),
                  ],
                ),
              ),
            ],),
            SizedBox(height: AppSize.s30,),
        ],),
      ),
    );
  }
}
