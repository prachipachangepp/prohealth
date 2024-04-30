import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/controller/controller.dart';
import 'package:prohealth/resources/color.dart';
import 'package:prohealth/resources/value_manager.dart';
import '../../../../../resources/font_manager.dart';
import '../../../../../resources/theme_manager.dart';

class QualificationTabarConstant extends StatelessWidget {
  final QualificationTabBarController controller;

  QualificationTabarConstant(this.controller);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.tabs.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: AppSize.s30,
            width: controller.tabBarViewWidth,
            child: TabBar(
              tabs: controller.tabs,
              dividerColor: Colors.transparent,
              indicatorColor: ColorManager.blueprime,
              labelColor:  ColorManager.blueprime,
              labelStyle: CustomTextStylesCommon.commonStyle(
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.bold
              ),
              unselectedLabelColor: ColorManager.black,
            ),
          ),
          SizedBox(height: AppSize.s30),
          Container(
            height: controller.tabBarViewHeight,
            child: TabBarView(
              children: controller.tabViews,
            ),
          ),
        ],
      ),
    );
  }
}
