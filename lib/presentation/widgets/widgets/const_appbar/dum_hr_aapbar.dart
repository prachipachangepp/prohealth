// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:prohealth/app/resources/theme_manager.dart';
// import '../../../screens/hr_module/add_employee/add_employee_screen.dart';
// import '../../../screens/hr_module/manage/web_manage/manage_screen.dart';
// import '../../../screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
// import '../../../screens/hr_module/onboarding/onboarding_screen.dart';
// import '../../../screens/hr_module/register/register_screen.dart';
//
// ///not in use
// class HrAppBar extends StatelessWidget {
//   final HRController hrController = Get.put(HRController());
//   final PageController _pageController = PageController();
//   final ButtonSelectionController myController =
//       Get.put(ButtonSelectionController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ///row one
//         Row(
//           children: [
//             Expanded(
//               flex: 1,
//               child: Container(
//                 height: 30,
//                 child: Image.asset('images/logo.png'),
//               ),
//             ),
//             Expanded(
//               flex: 4,
//               child: Material(
//                 elevation: 4,
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(10),
//                     topLeft: Radius.circular(10)),
//                 child: Container(
//                     height: 37,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(10),
//                           topLeft: Radius.circular(10)),
//                       gradient: LinearGradient(
//                         colors: [
//                           Color(0xff008abd).withOpacity(0.9),
//                           Color(0xff008abd).withOpacity(0.8)
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         stops: [0.4, 0.7],
//                         tileMode: TileMode.repeated,
//                       ),
//                     ),
//                     child: Row(children: [
//                       Padding(
//                         padding: EdgeInsets.only(
//                           left: MediaQuery.of(context).size.width / 90,
//                         ),
//                         child: Container(
//                             height: 33,
//                             width: 80,
//                             decoration: BoxDecoration(
//                               border: Border.all(width: 1, color: Colors.white),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20)),
//                             ),
//                             child: Row(children: [
//                               Image.asset("images/mike.png"),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 4),
//                                 child: Column(
//                                   children: [
//                                     Text("Ask",
//                                         style: TextStyle(
//                                             color: Colors.white, fontSize: 9)),
//                                     Text("KLIP",
//                                         style: TextStyle(
//                                             color: Colors.white, fontSize: 10)),
//                                   ],
//                                 ),
//                               )
//                             ])),
//                       ),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width / 10,
//                       ),
//                       Material(
//                         elevation: 3,
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         child: Container(
//                           height: 30,
//                           width: MediaQuery.of(context).size.width / 5.7,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             color: Colors.white,
//                           ),
//                           child: Center(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Text("Human Resource Manager",
//                                     style:
//                                         ThemeManagerLightblue.customTextStyle(
//                                             context)),
//                                 Icon(
//                                   Icons.close,
//                                   color: Color(0xff434343),
//                                   size: MediaQuery.of(context).size.width / 70,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width / 120,
//                       ),
//
//                       ///
//                       // GetBuilder<CustomButtonController>(
//                       //   builder: (controller) => Material(
//                       //     elevation: 3,
//                       //     shape: CircleBorder(),
//                       //     child: InkWell(
//                       //       child: Container(
//                       //         width: 33,
//                       //         height: 33,
//                       //         decoration: BoxDecoration(
//                       //           shape: BoxShape.circle,
//                       //           color: Colors.white,
//                       //         ),
//                       //         child: Icon(
//                       //           Icons.add,
//                       //           color: Color(0xff2B647F),
//                       //           size: 25,
//                       //         ),
//                       //       ),
//                       //       onTap: () {},
//                       //     ),
//                       //   ),
//                       // ),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width / 20,
//                       ),
//                       Material(
//                         elevation: 4,
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         child: Container(
//                             height: 30,
//                             width: MediaQuery.of(context).size.width / 10,
//                             decoration: BoxDecoration(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20)),
//                               color: Colors.white,
//                             ),
//                             child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Icon(
//                                     Icons.phone_outlined,
//                                     color: Color(0xff2B647F),
//                                     size:
//                                         MediaQuery.of(context).size.width / 70,
//                                   ),
//                                   Icon(
//                                     Icons.mode_comment_outlined,
//                                     color: Color(0xff2B647F),
//                                     size:
//                                         MediaQuery.of(context).size.width / 70,
//                                   ),
//                                   Icon(
//                                     Icons.mail_outline_outlined,
//                                     color: Color(0xff2B647F),
//                                     size:
//                                         MediaQuery.of(context).size.width / 70,
//                                   )
//                                 ])),
//                       ),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width / 60,
//                       ),
//
//                       ///dropdown
//                       Container(
//                         height: 23,
//                         width: 90,
//                         // padding: EdgeInsets.all(5),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(color: Colors.white),
//                           color: Colors.transparent,
//                         ),
//                         child: Obx(
//                           () => Center(
//                             child: DropdownButton<String>(
//                               icon: Icon(Icons.arrow_drop_down,
//                                   size: MediaQuery.of(context).size.width / 89,
//                                   color: Colors.white),
//                               dropdownColor: Colors.grey,
//                               style: TextStyle(
//                                 fontSize:
//                                     MediaQuery.of(context).size.width / 92,
//                                 color: Colors.white,
//                               ),
//                               underline: Container(),
//                               value: hrController.selectedItem.value,
//                               onChanged: (String? newValue) {
//                                 if (newValue != null) {
//                                   hrController.changeSelectedItem(newValue);
//                                 }
//                               },
//                               items: ['Admin', 'Staff', 'Patient']
//                                   .map<DropdownMenuItem<String>>(
//                                     (String value) => DropdownMenuItem<String>(
//                                       value: value,
//                                       child: Text(
//                                         value,
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontFamily: 'FiraSans',
//                                           fontSize: 11,
//                                           fontWeight: FontWeight.w200,
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                   .toList(),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width / 60,
//                       ),
//                       InkWell(
//                         splashColor: Colors.white, // Splash color
//                         onTap: () {},
//                         child: SizedBox(
//                             width: MediaQuery.of(context).size.width / 37,
//                             height: 25,
//                             child: Icon(
//                               Icons.notifications_none_outlined,
//                               color: Colors.white,
//                               size: MediaQuery.of(context).size.width / 68,
//                             )),
//                       ),
//                       InkWell(
//                         splashColor: Colors.white,
//                         onTap: () {},
//                         child: SizedBox(
//                             width: MediaQuery.of(context).size.width / 37,
//                             height: 25,
//                             child: Icon(
//                               Icons.settings_outlined,
//                               color: Colors.white,
//                               size: MediaQuery.of(context).size.width / 68,
//                             )),
//                       ),
//                       //SizedBox(width: MediaQuery.of(context).size.width/10,),
//                       Expanded(
//                         flex: 1,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             CircleAvatar(
//                               radius: 10,
//                               backgroundColor: Colors.white,
//                               child: Image.asset("images/profile.png"),
//                             ),
//                             SizedBox(height: 2),
//                             Flexible(
//                               child: Text(
//                                 "William Christiana ",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 8,
//                                   fontFamily: 'FiraSans',
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ])),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 5,
//         ),
//
//         ///row two
//         Row(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: MediaQuery.of(context).size.width / 100),
//                 child: Container(
//                   height: 40,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Obx(() => CustomTitleButton(
//                             height: 30,
//                             width: 100,
//                             onPressed: () {
//                               myController.selectButton(0);
//                               _pageController.animateToPage(0,
//                                   duration: Duration(milliseconds: 500),
//                                   curve: Curves.ease);
//                             },
//                             text: 'Dashboard',
//                             isSelected: myController.selectedIndex.value == 0,
//                           )),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Obx(() => CustomTitleButton(
//                             height: 30,
//                             width: 140,
//                             onPressed: () {
//                               myController.selectButton(1);
//                               _pageController.animateToPage(1,
//                                   duration: Duration(milliseconds: 500),
//                                   curve: Curves.ease);
//                             },
//                             text: 'Manage',
//                             isSelected: myController.selectedIndex.value == 1,
//                           )),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Obx(() => CustomTitleButton(
//                             height: 30,
//                             width: 100,
//                             onPressed: () {
//                               myController.selectButton(2);
//                               _pageController.animateToPage(2,
//                                   duration: Duration(milliseconds: 500),
//                                   curve: Curves.ease);
//                             },
//                             text: 'Add Employee',
//                             isSelected: myController.selectedIndex.value == 2,
//                           )),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Obx(() => CustomTitleButton(
//                             height: 30,
//                             width: 140,
//                             onPressed: () {
//                               myController.selectButton(3);
//                               _pageController.animateToPage(3,
//                                   duration: Duration(milliseconds: 500),
//                                   curve: Curves.ease);
//                             },
//                             text: 'Register',
//                             isSelected: myController.selectedIndex.value == 3,
//                           )),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Obx(() => CustomTitleButton(
//                             height: 30,
//                             width: 140,
//                             onPressed: () {
//                               myController.selectButton(4);
//                               _pageController.animateToPage(4,
//                                   duration: Duration(milliseconds: 500),
//                                   curve: Curves.ease);
//                             },
//                             text: 'Onboarding',
//                             isSelected: myController.selectedIndex.value == 4,
//                           )),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         Expanded(
//           flex: 10,
//           child: PageView(
//             controller: _pageController,
//             physics: NeverScrollableScrollPhysics(),
//             children: [
//               Container(color: Colors.green),
//               ManageScreen(),
//               AddEmployeeHomeScreen(),
//               RegisterScreen(),
//               OnBoardingScreen(),
//               // Container(color: Colors.orange),
//               // Container(color: Colors.blue),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class HRController extends GetxController {
//   var selectedItem = 'Admin'.obs;
//   void changeSelectedItem(String newItem) {
//     selectedItem.value = newItem;
//   }
// }
//
// class CustomButtonController extends GetxController {}
//
// class ButtonSelectionController extends GetxController {
//   RxInt selectedIndex = 0.obs;
//   void selectButton(int index) {
//     selectedIndex.value = index;
//   }
// }
