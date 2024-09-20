// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:prohealth/presentation/screens/hr_module/dashboard/dashoboard_screen.dart';
// import 'package:prohealth/presentation/screens/hr_module/onboarding/new_onboard_screen.dart';
// import 'package:prohealth/presentation/widgets/app_bar/app_bar.dart';
// import '../../../../../app/resources/theme_manager.dart';
// import '../../../screens/hr_module/add_employee/add_employee_screen.dart';
// import '../../../screens/hr_module/manage/controller/controller.dart';
// import '../../../screens/hr_module/manage/web_manage/manage_screen.dart';
// import '../../../screens/hr_module/manage/widgets/app_bar_tabbar_constant.dart';
// import '../../../screens/hr_module/register/register_screen.dart';
// import 'controller.dart';
// ///not in use
// class MyAppBar extends StatelessWidget {
//   final HRController hrController = Get.put(HRController());
//   final CustomButtonController customController =
//       Get.put(CustomButtonController());
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(MyAppTabBarController(
//       tabs: [
//         Tab(text: 'Dashboard'),
//         Tab(text: 'Manage'),
//         Tab(text: 'Add Employee'),
//         Tab(text: 'Register'),
//         Tab(text: 'Onboarding'),
//       ],
//       tabViews: [
//         DashBoardScreen(),
//         ManageScreen(),
//         AddEmployeeHomeScreen(),
//         RegisterScreen(),
//         NewOnboardScreen(),
//       ],
//       tabBarViewWidth: MediaQuery.of(context).size.width / 1.04,
//       tabBarViewHeight: MediaQuery.of(context).size.height/1.2
//     ));
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Material(
//         color: Colors.white,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// first row logo
//             ApplicationAppBar(headingText: "Human Resource Manager"),
//             SizedBox(
//               height: 10,),
//             ///second row title heading
//             AppBarTabBarConstant(controller),
//           ],
//         ),
//       ),
//     );
//   }
// }
