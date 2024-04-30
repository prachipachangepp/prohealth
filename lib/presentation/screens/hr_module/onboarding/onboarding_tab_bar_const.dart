import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/controller/controller.dart';

///prachi
class OnboardingTabBar extends StatelessWidget {
  final OnboardingController controller;

  OnboardingTabBar(this.controller);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.tabs.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: ColorManager.blueprime,
              boxShadow: [
                BoxShadow(
                  // color: Colors.black.withOpacity(0.2),
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            height: AppSize.s30,
            width: controller.tabBarViewWidth,
            child: TabBar(
              tabs: controller.tabs,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Creates border
                  color: ColorManager.white),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: ColorManager.white,
              labelColor: ColorManager.darktgrey,
              labelStyle: CustomTextStylesCommon.commonStyle(
                fontSize: FontSize.s12,
                color: ColorManager.darktgrey,
                fontWeight: FontWeightManager.semiBold,
              ),
              unselectedLabelColor: ColorManager.white,
            ),
          ),
          SizedBox(height: AppSize.s10),
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
