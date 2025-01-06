import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import '../controller/controller.dart';

///getx
class CenteredTabBarChild extends StatelessWidget {
  final CenteredTabBarChildController controller;

  CenteredTabBarChild(this.controller);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.tabs!.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: ColorManager.calandercolour,
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
              isScrollable: false,
              tabs: controller.tabs!,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Creates border
                  color: ColorManager.white),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: ColorManager.white,
              labelColor: ColorManager.granitegray,
              unselectedLabelStyle: TextStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeight.w600,
              ),
              labelStyle: TextStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelColor: ColorManager.white,
            ),
          ),
          SizedBox(height: AppSize.s20),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: controller.tabBarViewHeight,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: controller.tabViews!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
