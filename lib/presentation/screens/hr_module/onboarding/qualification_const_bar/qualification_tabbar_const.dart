import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/controller/controller.dart';

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
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(24),
            //   color: Color(0xFF50B5E5),
            //   boxShadow: [
            //     BoxShadow(
            //       // color: Colors.black.withOpacity(0.2),
            //       color: Colors.black.withOpacity(0.25),
            //       spreadRadius: 1,
            //       blurRadius: 4,
            //       offset: Offset(0, 3),
            //     ),
            //   ],
            // ),
            height: 30,
            width: controller.tabBarViewWidth,
            child: TabBar(
              tabs: controller.tabs,
              dividerColor: Colors.transparent,
              indicatorColor: Color(0xFF50B5E5),
              labelColor: Color(0xFF50B5E5),
              labelStyle: TextStyle(
                fontFamily: 'FiraSans',
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelColor: Colors.black,
              // dividerColor: Colors.transparent,
            ),
          ),
          SizedBox(height: 20),
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
