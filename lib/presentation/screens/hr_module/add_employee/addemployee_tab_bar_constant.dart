import 'package:flutter/material.dart';
import '../manage/controller/controller.dart';
///prachi
class AddEmployeeTabBar extends StatelessWidget {
  final AddEmployeeController controller;

  AddEmployeeTabBar(this.controller);
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
              color: Color(0xFF50B5E5),
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
            height: 30,
            width: controller.tabBarViewWidth,
            child: TabBar(
              isScrollable: false,
              tabs: controller.tabs,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Creates border
                  color: Colors.white),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.white,
              labelColor: Color(0xFF686464),
              labelStyle: TextStyle(
                fontFamily: 'FiraSans',
                fontSize: 12,
                color: Color(0xFF686464),
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelColor: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: controller.tabBarViewHeight,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: controller.tabViews,
            ),
          ),
        ],
      ),
    );
  }
}