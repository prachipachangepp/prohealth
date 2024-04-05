import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';

///getx
class CenteredTabBar extends GetView<CenteredTabBarController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 4),
      child: DefaultTabController(
        length: controller.tabs.length,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: TabBar(
                controller: controller.tabController,
                tabs: controller.tabs,
                indicatorWeight: 6,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Color(0xFF50B5E5),
                labelColor: Color(0xFF50B5E5),
                labelStyle: TextStyle(
                  fontFamily: 'FiraSans',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelColor: Colors.black,
                dividerColor: Colors.transparent,
              ),
            ),
            Container(
              // color: Colors.purpleAccent,
              height: controller.tabBarViewHeight,
              child: TabBarView(
                controller: controller.tabController,
                children: controller.tabViews,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ///login tabbar
// class LoginTabBar extends StatelessWidget {
//   final LoginTabBarController controller;
//   LoginTabBar(this.controller);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//       child: DefaultTabController(
//         length: controller.tabs.length,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               color: Colors.white,
//               child: TabBar(
//                 controller: controller.tabController,
//                 tabs: controller.tabs,
//                 indicatorWeight: 6,
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 indicatorColor: Color(0xFF50B5E5),
//                 labelColor: Color(0xFF50B5E5),
//                 labelStyle: TextStyle(
//                   fontFamily: 'FiraSans',
//                   fontSize: 12,
//                   fontWeight: FontWeight.w700,
//                 ),
//                 unselectedLabelColor: Colors.black,
//                 dividerColor: Colors.transparent,
//               ),
//             ),
//             Container(
//               // color: Colors.purpleAccent,
//               height: controller.tabBarViewHeight,
//               child: TabBarView(
//                 controller: controller.tabController,
//                 children: controller.tabViews,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
