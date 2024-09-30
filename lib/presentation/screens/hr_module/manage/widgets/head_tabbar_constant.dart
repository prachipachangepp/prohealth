import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import '../../../../../app/resources/font_manager.dart';
import '../controller/controller.dart';

///getx
class CenteredTabBar extends GetView<CenteredTabBarController> {
  final int employeeId;
  CenteredTabBar({required this.employeeId});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
      child: DefaultTabController(
        length: controller.tabs.length,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              // color: Colors.green,
              child: TabBar(
                controller: controller.tabController,
                tabs: controller.tabs,
                indicatorWeight: 6,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                        width: AppSize.s6,
                        color: ColorManager.calandercolour),
                    borderRadius: BorderRadius.circular(13)),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: ColorManager.calandercolour,
                labelStyle: TextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelColor: ColorManager.textPrimaryColor,
                dividerColor: Colors.transparent,
              ),
            ),
            // SizedBox(
            //  // color: Colors.purpleAccent,
            //   height: 700,//controller.tabBarViewHeight,
            //   child: TabBarView(
            //     physics: const NeverScrollableScrollPhysics(),
            //     controller: controller.tabController,
            //     children: controller.tabViews,
            //   ),
            // ),

            Container(
             //color: Colors.purpleAccent,
              height: controller.tabBarViewHeight,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.tabController,
                children: controller.tabViews,
              ),
            ),


            // Container(height: 200,
            //   color: Colors.pink,)
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
