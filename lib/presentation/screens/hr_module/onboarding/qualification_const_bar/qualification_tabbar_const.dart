// import 'package:flutter/material.dart';
// import '../../../../../../app/resources/color.dart';
// import '../../../../../../app/resources/font_manager.dart';
// import '../../../../../../app/resources/theme_manager.dart';
// import '../../../../../../app/resources/value_manager.dart';
// import '../../manage/controller/controller.dart';
//
//
// class QualificationTabarConstant extends StatelessWidget {
//   final QualificationTabBarController controller;
//
//   QualificationTabarConstant(this.controller);
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: controller.tabs.length,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Container(
//             height: AppSize.s30,
//             width: controller.tabBarViewWidth,
//             child: TabBar(
//               tabs: controller.tabs,
//               dividerColor: Colors.transparent,
//               indicatorColor: ColorManager.blueprime,
//               labelColor:  ColorManager.blueprime,
//               labelStyle: CustomTextStylesCommon.commonStyle(
//                   fontSize: FontSize.s12,
//                   fontWeight: FontWeightManager.bold
//               ),
//               unselectedLabelColor: ColorManager.black,
//             ),
//           ),
//           SizedBox(height: AppSize.s30),
//           Container(
//             height: MediaQuery.of(context).size.height/1.65,
//             child: TabBarView(
//               children: controller.tabViews,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
