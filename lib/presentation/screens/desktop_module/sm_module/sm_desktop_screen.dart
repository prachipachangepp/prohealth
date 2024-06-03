import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/presentation/screens/desktop_module/sm_module/widgets/finance_screen.dart';
import 'package:prohealth/presentation/screens/desktop_module/sm_module/widgets/hr_screen.dart';
import 'package:prohealth/presentation/screens/home_module/home_screen.dart';
import '../hr_module/manage/widgets/bottom_row.dart';
import '../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../widgets/const_appbar/controller.dart';
import 'company_identity_screen.dart';

class SMDesktop extends StatelessWidget {
  final PageController _pageController = PageController();
  final SMController smController = Get.put(SMController());
  final String? dropdownValue;
  final ValueChanged<String?>? onChanged;
  final HRController hrController = Get.put(HRController());
  final VoidCallback? onItem2Selected;
  String selectedOption = 'Select';
  // final controller = Get.put(DropdownController());
  // final PageController pageController;
  bool showSelectOption = true;
  final ButtonSelectionController myController =
      Get.put(ButtonSelectionController());
  // final PageController _pageController = PageController();
  SMDesktop({
    this.dropdownValue,
    this.onChanged,
    this.onItem2Selected,
  });

  void navigateToPage2() {
    if (_pageController.page != 2) {
      _pageController.animateToPage(
        2,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  //  color: Colors.grey,
                  child:
                  // SvgPicture.asset(
                  //   'images/pro_logo.svg',
                  //   fit: BoxFit.fill,
                  // ),

                  Image.asset(
                    'images/logo_login.png',
                    fit: BoxFit.fill,
                  ),
                )),
            Expanded(
              flex: 10,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: MediaQuery.of(context).size.height / 13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Color(0x40000000),
                    //
                    //     /// #000000 with 25% opacity
                    //     blurRadius: 4,
                    //     offset: Offset(0, 4),
                    //   ),
                    // ],
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff51B5E6),
                        Color(0xff008ABD),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      // begin: Alignment.centerLeft,
                      // end: Alignment.centerRight,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ///ask klip
                      Container(
                        width: 96,
                        height: MediaQuery.of(context).size.height / 17,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("images/mike.png"),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Ask',
                                  style: GoogleFonts.jost(
                                      color: Colors.white,
                                      fontSize: 10,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w200),
                                ),
                                Text("KLIP",
                                    style: GoogleFonts.jost(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.none,
                                    )),
                              ],
                            ),
                          ],
                        ), // Add child widgets here if needed
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 12,
                      ),
                      ///em text
                      Row(
                        children: [
                          Container(
                            // width: 210,
                            // height: MediaQuery.of(context).size.height / 19,
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x40000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Establishment Manager',
                                  style: TextStyle(
                                    fontFamily: 'Fira Sans',
                                    fontSize: FontSize.s14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff2B647F),
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Color(0xff434343),
                                    size:
                                        MediaQuery.of(context).size.width /
                                            100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 33,
                            height: 33,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x40000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Color(0xff2B647F), // Icon color
                                  size: 20, // Icon size
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      ///plus

                      SizedBox(
                        width: MediaQuery.of(context).size.width / 20,
                      ),
                      Material(
                        elevation: 4,
                        borderRadius:
                            BorderRadius.all(Radius.circular(20)),
                        child: Container(
                            height:
                                MediaQuery.of(context).size.height / 19,
                            width:
                                MediaQuery.of(context).size.width / 10,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              color: Colors.white,
                            ),
                            child: Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    'images/phone_app_bar.svg',
                                   // fit: BoxFit.fill,
                                   //  height: 15,
                                   //  width: 16,
                                  ),
                                  // Icon(
                                  //   Icons.phone_outlined,
                                  //   color: Color(0xff2B647F),
                                  //   size: MediaQuery.of(context)
                                  //           .size
                                  //           .width /
                                  //       70,
                                  // ),
                                  SvgPicture.asset(
                                    'images/message_app_bar.svg',
                                     // height: 15,
                                     // width: 16,
                                    //fit: BoxFit.fill,
                                  ),
                                  // Icon(
                                  //   Icons.mode_comment_outlined,
                                  //   color: Color(0xff2B647F),
                                  //   size: MediaQuery.of(context)
                                  //           .size
                                  //           .width /
                                  //       70,
                                  // ),
                                  // Icon(
                                  //   Icons.mail_outline_outlined,
                                  //   color: Color(0xff2B647F),
                                  //   size: MediaQuery.of(context)
                                  //           .size
                                  //           .width /
                                  //       70,
                                  //  )
                                  SvgPicture.asset(
                                    'images/email_app_bar.svg',
                                    //fit: BoxFit.fill,
                                    // height: 15,
                                    // width: 16,
                                  ),
                                ])),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 20,
                      ),

                      ///dropdown
                      Row(
                        children: [
                          Container(
                            height: 25,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white,width: 2),
                              color: Colors.transparent,
                            ),
                            child: Obx(
                              () => Center(
                                child: DropdownButton<String>(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    size:
                                        MediaQuery.of(context).size.width /
                                            89,
                                    color: Colors.white,
                                  ),
                                  dropdownColor: ColorManager.white,
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width /
                                            92,
                                    color: Colors.white,
                                  ),
                                  underline: Container(),
                                  value: hrController.selectedItem.value,
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      hrController
                                          .changeSelectedItem(newValue);
                                    }
                                  },
                                  items: ['Admin', 'Staff', 'Patient']
                                      .map<DropdownMenuItem<String>>(
                                        (String value) =>
                                            DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: hrController
                                                          .selectedItem
                                                          .value ==
                                                      value
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontFamily: 'FiraSans',
                                              fontSize: 11,
                                              fontWeight: FontWeight.w200,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.white, // Splash color
                            onTap: () {},
                            child: SizedBox(
                                width:
                                MediaQuery.of(context).size.width / 37,
                                height: 25,
                                child: Icon(
                                  Icons.notifications_none_outlined,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.width /
                                      68,
                                )),
                          ),
                          InkWell(
                            splashColor: Colors.white,
                            onTap: () {},
                            child: SizedBox(
                                width:
                                MediaQuery.of(context).size.width / 37,
                                height: 25,
                                child: Icon(
                                  Icons.settings_outlined,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.width /
                                      68,
                                )),
                          ),
                        ],
                      ),
                      // Container(
                      //   height: 23,
                      //   width: 90,
                      //   // padding: EdgeInsets.all(5),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(20),
                      //     border: Border.all(color: Colors.white),
                      //     color: Colors.transparent,
                      //   ),
                      //   child: Obx(
                      //     () => Center(
                      //       child: DropdownButton<String>(
                      //         icon: Icon(Icons.arrow_drop_down,
                      //             size: MediaQuery.of(context)
                      //                     .size
                      //                     .width /
                      //                 89,
                      //             color: Colors.white),
                      //         dropdownColor: Colors.grey,
                      //         style: TextStyle(
                      //           fontSize:
                      //               MediaQuery.of(context).size.width /
                      //                   92,
                      //           color: Colors.white,
                      //         ),
                      //         underline: Container(),
                      //         value: hrController.selectedItem.value,
                      //         onChanged: (String? newValue) {
                      //           if (newValue != null) {
                      //             hrController
                      //                 .changeSelectedItem(newValue);
                      //           }
                      //         },
                      //         items: ['Admin', 'Staff', 'Patient']
                      //             .map<DropdownMenuItem<String>>(
                      //               (String value) =>
                      //                   DropdownMenuItem<String>(
                      //                 value: value,
                      //                 child: Text(
                      //                   value,
                      //                   textAlign: TextAlign.center,
                      //                   style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontFamily: 'FiraSans',
                      //                     fontSize: 11,
                      //                     fontWeight: FontWeight.w200,
                      //                   ),
                      //                 ),
                      //               ),
                      //             )
                      //             .toList(),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width / 50,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.white,
                            child: Image.asset("images/profile.png"),
                          ),
                          SizedBox(height: 2),
                          Flexible(
                            child: Text(
                              "William Christiana ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontFamily: 'FiraSans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),

        ///2nd  buttons
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        MediaQuery.of(context).size.width / 100),
                child: Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(
                            () => CustomTitleButton(
                          height: 30,
                          width: 100,
                          onPressed: () {
                            myController.selectButton(0);
                            _pageController.animateToPage(0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          text: 'Dashboard',
                          isSelected:
                          myController.selectedIndex.value == 0,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Obx(
                            () => CustomTitleButton(
                          height: 30,
                          width: 140,
                          onPressed: () {
                            myController.selectButton(1);
                            _pageController.animateToPage(1,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          text: 'Company Identity',
                          isSelected:
                          myController.selectedIndex.value == 1,
                        ),
                      ),

                      SizedBox(
                        width: 10,
                      ),
                      // Obx(() => CustomTitleButton(
                      //       height: 30,
                      //       width: 100,
                      //       onPressed: () {
                      //         myController.selectButton(0);
                      //         _pageController.animateToPage(0,
                      //             duration: Duration(milliseconds: 500),
                      //             curve: Curves.ease);
                      //       },
                      //       text: 'Dashboard',
                      //       isSelected:
                      //           myController.selectedIndex.value == 0,
                      //     )),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      // Obx(() => CustomTitleButton(
                      //       height: 30,
                      //       width: 140,
                      //       onPressed: () {
                      //         myController.selectButton(1);
                      //         _pageController.animateToPage(1,
                      //             duration: Duration(milliseconds: 500),
                      //             curve: Curves.ease);
                      //       },
                      //       text: 'Company Identity',
                      //       isSelected:
                      //           myController.selectedIndex.value == 1,
                      //     )),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      ///
                      // Obx(
                      //   () => DropdownButton<String>(
                      //     icon: Icon(Icons.arrow_drop_down),
                      //     style: TextStyle(color: Colors.white),
                      //     dropdownColor: Colors.blue,
                      //     elevation: 2,
                      //     underline: Container(
                      //       height: 2,
                      //       color: Colors.blue,
                      //     ),
                      //     value: myController.selectedIndex.value == 2
                      //         ? 'HR'
                      //         : 'Finance',
                      //     onChanged: (String? newValue) {
                      //       // Accepts a nullable String argument
                      //       if (newValue == 'HR') {
                      //         myController.selectButton(2);
                      //         _pageController.animateToPage(
                      //           2,
                      //           duration: Duration(milliseconds: 500),
                      //           curve: Curves.ease,
                      //         );
                      //       } else if (newValue == 'Finance') {
                      //         myController.selectButton(3);
                      //         _pageController.animateToPage(
                      //           3,
                      //           duration: Duration(milliseconds: 500),
                      //           curve: Curves.ease,
                      //         );
                      //       }
                      //     },
                      //     items: ['HR', 'Finance']
                      //         .map<DropdownMenuItem<String>>(
                      //       (String value) {
                      //         return DropdownMenuItem<String>(
                      //           value: value,
                      //           child: Text(value),
                      //         );
                      //       },
                      //     ).toList(),
                      //   ),
                      // )
                      ///main
                      Obx(() => CustomDropdownButton(
                            height: 34,
                            width: 140,
                            items: ['Select a module', 'HR', 'Finance'],
                            selectedItem: myController
                                        .selectedIndex.value ==
                                    2
                                ? 'HR'
                                : myController.selectedIndex.value == 3
                                    ? 'Finance'
                                    : 'Select a module',
                            onChanged: (newValue) {
                              if (newValue == 'HR') {
                                myController.selectButton(2);
                                _pageController.animateToPage(
                                  2,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              } else if (newValue == 'Finance') {
                                myController.selectButton(3);
                                _pageController.animateToPage(
                                  3,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              }
                            },
                          )
                      )

                      // Obx(() => CustomDropdownButton(
                      //       height: 34,
                      //       width: 130,
                      //       items: ['HR', 'Finance'],
                      //       selectedItem:
                      //           myController.selectedIndex.value == 2
                      //               ? 'HR'
                      //               : 'Finance',
                      //       onChanged: (newValue) {
                      //         if (newValue == 'HR') {
                      //           myController.selectButton(2);
                      //           _pageController.animateToPage(
                      //             2,
                      //             duration: Duration(milliseconds: 500),
                      //             curve: Curves.ease,
                      //           );
                      //         } else if (newValue == 'Finance') {
                      //           myController.selectButton(3);
                      //           _pageController.animateToPage(
                      //             3,
                      //             duration: Duration(milliseconds: 500),
                      //             curve: Curves.ease,
                      //           );
                      //         }
                      //       },
                      //     ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          flex: 10,
          child: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(color: Colors.white),
              CompanyIdentityScreen(),
              HrScreen(),
              FinanceScreen()
            ],
          ),
        ),
        BottomBarRow()
        // ),
      ],
    );
  }
}

class SMController extends GetxController {
  var selectedItem = 'Admin'.obs;
  void changeSelectedItem(String newItem) {
    selectedItem.value = newItem;
  }
}

class ButtonSelectionController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void selectButton(int index) {
    selectedIndex.value = index;
  }
}

///
// Expanded(
//   child: PageView(
//     controller: _pageController,
//     physics: NeverScrollableScrollPhysics(),
//     children: [
//       Container(color: Colors.blue),
//       Container(color: Colors.green),
//       Container(color: Colors.orange),
//       Container(color: Colors.red),
//       Container(
//         color: Colors.teal,
//       )
//     ],
//   ),
// ),
///
//         Row(
//           children: [
//             Expanded(
//               child: Container(
//                 // color: Colors.yellow,
//                 height: 40,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     CustomTitleButton(
//                       height: 30,
//                       width: 100,
//                       onPressed: () {
//                         if (_pageController.page != 0) {
//                           _pageController.animateToPage(0,
//                               duration: Duration(milliseconds: 500),
//                               curve: Curves.ease);
//                         }
//                       },
//                       text: 'Dashboard',
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     CustomTitleButton(
//                       height: 30,
//                       width: 130,
//                       onPressed: () {
//                         if (_pageController.page != 1) {
//                           _pageController.animateToPage(1,
//                               duration: Duration(milliseconds: 500),
//                               curve: Curves.ease);
//                         }
//                       },
//                       text: 'Company Identity',
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     CustomDropdownButton(
//                       height: 30,
//                       width: 130,
//                       items: ['Finance', 'HR'],
//                     )
//                     // CustomButton(
//                     //   height: 30,
//                     //   width: 100,
//                     //   onPressed: () {
//                     //     if (_pageController.page != 2) {
//                     //       _pageController.animateToPage(2,
//                     //           duration: Duration(milliseconds: 500),
//                     //           curve: Curves.ease);
//                     //     }
//                     //   },
//                     //   text: 'Button 3',
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ),
// ),
// Expanded(
//   child: PageView(
//     controller: _pageController,
//     physics: NeverScrollableScrollPhysics(),
//     children: [
//       Container(color: Colors.blue),
//       Container(color: Colors.green),
//       Container(color: Colors.orange),
//     ],
//   ),
///
// Obx(() => CustomDropdownButton(
//       height: 35,
//       width: 130,
//       items: ['Finance', 'HR'],
//       selectedItem:
//           myController.selectedIndex.value == 2
//               ? 'Finance'
//               : 'HR',
//       onChanged: (newValue) {
//         if (newValue == 'Finance') {
//           myController.selectButton(2);
//         } else if (newValue == 'HR') {
//           myController.selectButton(3);
//         }
//       },
//     )),
///
// Obx(
//   () => CustomDropdownButton(
//     height: 35,
//     width: 130,
//     items: ['Finance', 'HR'],
//     selectedItem:
//         myController.selectedIndex.value == 2
//             ? 'Finance'
//             : 'HR',
//     onChanged: (newValue) {
//       if (newValue == 'Finance') {
//         myController.selectButton(2);
//       } else if (newValue == 'HR') {
//         myController.selectButton(3);
//       }
//     },
//   ),
// ),
// Obx(
//   () => CustomDropdownButton(
//     height: 35,
//     width: 130,
//     items: ['Finance', 'HR'],
//     selectedItem:
//         myController.selectedIndex.value == 2
//             ? 'Finance'
//             : 'HR',
//     onChanged: (newValue) {
//       if (newValue == 'Finance') {
//         myController.selectButton(2);
//       } else if (newValue == 'HR') {
//         myController.selectButton(3);
//       }
//       // Check if the selected value is 'HR'
//       if (newValue == 'HR') {
//         myController.selectButton(2);
//         _pageController.animateToPage(
//           1,
//           duration: Duration(milliseconds: 500),
//           curve: Curves.ease,
//         );
//       }
//     },
//   ),
// ),
