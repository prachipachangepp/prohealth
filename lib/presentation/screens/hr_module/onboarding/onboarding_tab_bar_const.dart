// import 'package:flutter/material.dart';
// import '../../../../../app/resources/color.dart';
// import '../../../../../app/resources/font_manager.dart';
// import '../../../../../app/resources/theme_manager.dart';
// import '../../../../../app/resources/value_manager.dart';
// import '../manage/controller/controller.dart';
//
// ///prachi
// class OnboardingTabBar extends StatelessWidget {
//   final OnboardingController controller;
//
//   OnboardingTabBar(this.controller);
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: controller.tabs.length,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(24),
//               color:ColorManager.blueprime,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.25),
//                   spreadRadius: 1,
//                   blurRadius: 4,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//             height: AppSize.s30,
//             width: MediaQuery.of(context).size.width/2.2,
//             child: TabBar(
//               isScrollable: false,
//               tabs: controller.tabs,
//               dividerColor: Colors.transparent,
//               indicator: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50), // Creates border
//                   color: ColorManager.white),
//               indicatorSize: TabBarIndicatorSize.tab,
//               indicatorColor: ColorManager.white,
//               labelColor: ColorManager.mediumgrey,
//               labelStyle: CustomTextStylesCommon.commonStyle(
//     fontSize: FontSize.s12,
//     color:  ColorManager.mediumgrey,
//     fontWeight: FontWeightManager.semiBold,
//     ),
//               unselectedLabelColor: ColorManager.white,
//             ),
//           ),
//           SizedBox(height: AppSize.s10),
//           Container(
//             height: MediaQuery.of(context).size.height/1.45,
//             child: TabBarView(
//               physics: NeverScrollableScrollPhysics(),
//               children: controller.tabViews,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Define a custom widget for the repeated Column structure
// class CustomTextColumn extends StatelessWidget {
//   final String text;
//   final TextStyle textStyle;
//   final double spacing;
//
//   const CustomTextColumn({
//     Key? key,
//     required this.text,
//     required this.textStyle,
//     this.spacing = 5.0,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(text, style: textStyle),
//         SizedBox(height: spacing),
//         Text(text, style: textStyle),
//         SizedBox(height: spacing),
//         Text(text, style: textStyle),
//         SizedBox(height: spacing),
//         Text(text, style: textStyle),
//       ],
//     );
//   }
// }
