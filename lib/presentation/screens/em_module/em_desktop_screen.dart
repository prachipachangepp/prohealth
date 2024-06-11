import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/whitelabelling_screen.dart';
import 'package:prohealth/presentation/screens/em_module/manage_emp_document/manage_emp_doc.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/manage_work_schedule.dart';
import 'package:prohealth/presentation/screens/home_module/home_screen.dart';

import '../../../../app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import '../../widgets/widgets/const_appbar/controller.dart';
import '../hr_module/manage/widgets/bottom_row.dart';
import '../hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'company_identity/company_identity_screen.dart';
import 'company_identity/manage_button_screen.dart';
import 'manage_hr/hr_screen.dart';
import 'manage_hr/manage_pay_rates/finance_screen.dart';

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

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                height: 460,
                width: 500,
                decoration: const BoxDecoration(
                  // color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    // Add your content here
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void navigateToPage2() {
    if (_pageController.page != 2) {
      _pageController.animateToPage(
        2,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Image.asset(
                      'images/logo_login.png',
                      fit: BoxFit.fill,
                    ),
                  )),
              Expanded(
                flex: 10,
                child: Material(
                  elevation: 8,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: Container(
                    // padding: EdgeInsets.only(left: 10),
                    height: MediaQuery.of(context).size.height / 13,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff51B5E6),
                          Color(0xff008ABD),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ///ask klip
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(22),
                              elevation: 4,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xff51B5E6),
                                        Color(0xff008ABD),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(22)),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset("images/mike.png"),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Ask',
                                          style: GoogleFonts.jost(
                                              color: Colors.white,
                                              fontSize: 10,
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.w400),
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
                                ),
                              ),
                            ),
                          ),
                          ///em text
                          Expanded(
                            flex: 3,
                            child: Container(
                              //color: Colors.red,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          color: Colors.white,
                                          boxShadow: [
                                            const BoxShadow(
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
                                              style: GoogleFonts.firaSans(
                                                fontSize: FontSize.s13,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xff2B647F),
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HomeScreen()));
                                              },
                                              child: Icon(
                                                Icons.close,
                                                color: const Color(0xff434343),
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    100,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),

                                      ///add button
                                      Container(
                                        width: 33,
                                        height: 33,
                                        decoration: const BoxDecoration(
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
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const HomeScreen()));
                                            },
                                            child: const Icon(
                                              Icons.add,
                                              color: Color(
                                                  0xff2B647F), // Icon color
                                              size: 20, // Icon size
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //Container()
                                  Material(
                                    elevation: 4,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                23,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                10,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18)),
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
                                              ),
                                              SvgPicture.asset(
                                                'images/message_app_bar.svg',
                                              ),
                                              SvgPicture.asset(
                                                'images/email_app_bar.svg',
                                              ),
                                            ])),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          ///dropdown
                          Expanded(
                            flex: 2,
                            child: Container(
                              //color: Colors.pink,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 25,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                      color: Colors.transparent,
                                    ),
                                    child: Obx(
                                      () => Center(
                                        child: DropdownButton<String>(
                                          icon: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                          dropdownColor: ColorManager.white,
                                          style: GoogleFonts.firaSans(
                                            fontSize: FontSize.s12,
                                            fontWeight: hrController
                                                    .selectedItem
                                                    .value
                                                    .isNotEmpty
                                                ? FontWeight.bold
                                                : FontWeight.w500,
                                            color: hrController.selectedItem
                                                    .value.isNotEmpty
                                                ? Colors.white
                                                : const Color(0xff9B9B9B),
                                          ),
                                          underline: Container(),
                                          value:
                                              hrController.selectedItem.value,
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
                                                          ? ColorManager.white
                                                          : const Color(
                                                              0xff9B9B9B),
                                                      fontFamily: 'FiraSans',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        splashColor:
                                            Colors.white, // Splash color
                                        onTap: () {},
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                37,
                                            height: 25,
                                            child: Icon(
                                              Icons.notifications_none_outlined,
                                              color: Colors.white,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  68,
                                            )),
                                      ),
                                      InkWell(
                                        splashColor: Colors.white,
                                        onTap: () {},
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                37,
                                            height: 25,
                                            child: Icon(
                                              Icons.settings_outlined,
                                              color: Colors.white,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  68,
                                            )),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 6,
                                        right:
                                            MediaQuery.of(context).size.width /
                                                90),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.white,
                                          child: Image.asset(
                                            "images/profile.png",
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          "William Christiana",
                                          style: GoogleFonts.firaSans(
                                            color: Colors.white,
                                            fontSize: FontSize.s9,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),

          ///2nd  buttons
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(
                  () => CustomTitleButton(
                    height: 10,
                    width: 100,
                    onPressed: () {
                      //companyAll(context);
                      myController.selectButton(0);
                      _pageController.animateToPage(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    text: 'Dashboard',
                    isSelected: myController.selectedIndex.value == 0,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Obx(
                  () => CustomTitleButton(
                    height: 30,
                    width: 140,
                    onPressed: () {
                      // uploadCompanyLogoApi(context, 5, "employ");
                      companyByIdApi(context, 18);
                      // companyDetailsApi(context,5);
                      myController.selectButton(1);
                      _pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    text: 'Company Identity',
                    isSelected: myController.selectedIndex.value == 1,
                  ),
                ),

                const SizedBox(
                  width: 15,
                ),
                Obx(
                  () => CustomDropdownButton(
                    height: 30,
                    width: 170,
                    items: [
                      DropdownMenuItem<String>(
                        value: 'Select a module',
                        child: Text(
                          'Select a module',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onTap: () {
                          myController.selectButton(1);
                        },
                      ),
                      DropdownMenuItem<String>(
                        value: 'HR',
                        child: Text(
                          'HR',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            // color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        onTap: () {
                          if (myController.selectedIndex.value != 2) {
                            myController.selectButton(2);
                            _pageController.animateToPage(
                              2,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          }
                        },
                      ),
                      DropdownMenuItem<String>(
                        value: 'All from HR',
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'All from HR',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              // color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        onTap: () {
                          if (myController.selectedIndex.value != 2) {
                            myController.selectButton(2);
                            _pageController.animateToPage(
                              2,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          }
                        },
                      ),
                      DropdownMenuItem<String>(
                        value: 'Work Schedule',
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Work Schedule',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              // color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        onTap: () {
                          if (myController.selectedIndex.value != 3) {
                            myController.selectButton(3);
                            _pageController.animateToPage(
                              3,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          }
                        },
                      ),
                      DropdownMenuItem<String>(
                        value: 'Employee Documents',
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Employee Documents',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        onTap: () {
                          if (myController.selectedIndex.value != 4) {
                            myController.selectButton(4);
                            _pageController.animateToPage(
                              4,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          }
                        },
                      ),
                      DropdownMenuItem<String>(
                        value: 'Finance',
                        child: Text(
                          'Finance',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                            fontSize: MediaQuery.of(context).size.width / 120,
                            fontWeight: FontWeight.w700,

                          ),
                        ),
                        onTap: () {
                          if (myController.selectedIndex.value != 5) {
                            myController.selectButton(5);
                            _pageController.animateToPage(
                              5,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          }
                        },
                      ),
                      DropdownMenuItem<String>(
                        value: 'Pay Rates',
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Pay Rates',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              // color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        onTap: () {
                          if (myController.selectedIndex.value != 5) {
                            myController.selectButton(5);
                            _pageController.animateToPage(
                              5,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          }
                        },
                      ),
                    ],
                    selectedItem: myController.selectedIndex.value == 2
                        ? 'All from HR'
                        : myController.selectedIndex.value == 3
                            ? 'Work Schedule'
                            : myController.selectedIndex.value == 4
                                ? 'Employee Documents'
                                : myController.selectedIndex.value == 5
                                    ? 'Finance'
                                    : 'Select a module',
                    onChanged: (newValue) {
                      // Not needed for this implementation
                    },
                  ),
                ),

                const SizedBox(
                  width: 15,
                ),
                Obx(
                  () => CustomTitleButton(
                    height: 30,
                    width: 100,
                    onPressed: () {
                      //companyAll(context);
                      myController.selectButton(6);
                      _pageController.animateToPage(6,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    text: 'Manage',
                    isSelected: myController.selectedIndex.value == 6,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Obx(
                  () => CustomTitleButton(
                    height: 30,
                    width: 100,
                    onPressed: () {
                      //companyAll(context);
                      myController.selectButton(8);
                      _pageController.animateToPage(8,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    text: 'White-labelling',
                    isSelected: myController.selectedIndex.value == 8,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: PageView(
              controller: _pageController,
              physics:  NeverScrollableScrollPhysics(),
              children: [
                Container(color: ColorManager.white),
                CompanyIdentityScreen(),
                HrScreen(),
                ManageWorkSchedule(),
                ManageEmployDocument(),
                FinanceScreen(),
                ManagePopUpScreen(),
                WhitelabellingScreen()
              ],
            ),
          ),
         BottomBarRow()
        ],
      ),
    ]);
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

class CustomDropdownButton extends StatelessWidget {
  final double height;
  final double width;
  final List<DropdownMenuItem<String>> items;
  final String selectedItem;
  final void Function(String?)? onChanged;

  const CustomDropdownButton({
    required this.height,
    required this.width,
    required this.items,
    required this.selectedItem,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          gradient: selectedItem == 'Select a module'
              ? const LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : const LinearGradient(
                  colors: [
                    Color(0xff51B5E6),
                    Color(0xff008ABD),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            icon: Icon(
              Icons.arrow_drop_down,
              color: selectedItem == 'Select a module'
                  ? const Color(0xff9B9B9B)
                  : Colors.white,
            ),
            value: selectedItem,
            onChanged: onChanged,
            items: items,
            selectedItemBuilder: (BuildContext context) {
              return items.map<Widget>((DropdownMenuItem<String> item) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.value ?? '',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.firaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: item.value == 'Select a module'
                          ? const Color(0xff9B9B9B)
                          : (selectedItem == item.value
                              ? Colors.white
                              : const Color(0xff9B9B9B)),
                    ),
                  ),
                );
              }).toList();
            },
            dropdownColor: Colors.white,
            // style: GoogleFonts.firaSans(
            //   fontSize: 12,
            //   fontWeight: FontWeight.w700,
            //   color: Colors.black
            // ),
          ),
        ),
      ),
    );

    //   Container(
    //   padding: EdgeInsets.all(2),
    //   height: height,
    //   width: width,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.all(Radius.circular(10)),
    //     color: selectedItem == 'Select a module' ? Colors.white : ColorManager.blueprime,
    //   ),
    //   child: DropdownButtonHideUnderline(
    //     child: DropdownButton<String>(
    //       value: selectedItem,
    //       onChanged: onChanged,
    //       items: items,
    //     ),
    //   ),
    // );
  }
}

///
// Obx(
//       () => CustomDropdownButton(
//     height: 34,
//     width: 140,
//     items: [
//       'Select a module',
//       'HR',
//       'All from HR',
//       'Work Schedule',
//       'Employee Documents',
//       'Finance',
//       'Pay Rates',
//     ],
//     selectedItem: myController.selectedIndex.value == 2
//         ? 'HR'
//         : myController.selectedIndex.value == 3
//         ? 'Work Schedule'
//         : myController.selectedIndex.value == 4
//         ? 'Employee Documents'
//         : myController.selectedIndex.value == 5
//         ? 'Finance'
//         : 'Select a module',
//     onChanged: (newValue) {
//       if (newValue == 'HR' || newValue == 'All from HR') {
//         myController.selectButton(2);
//         _pageController.animateToPage(
//           2,
//           duration: Duration(milliseconds: 500),
//           curve: Curves.ease,
//         );
//       } else if (newValue == 'Work Schedule') {
//         myController.selectButton(3);
//         _pageController.animateToPage(
//           3,
//           duration: Duration(milliseconds: 500),
//           curve: Curves.ease,
//         );
//       } else if (newValue == 'Employee Documents') {
//         myController.selectButton(4);
//         _pageController.animateToPage(
//           4,
//           duration: Duration(milliseconds: 500),
//           curve: Curves.ease,
//         );
//       } else if (newValue == 'Finance' || newValue == 'Pay Rates') {
//         myController.selectButton(5);
//         _pageController.animateToPage(
//           5,
//           duration: Duration(milliseconds: 500),
//           curve: Curves.ease,
//         );
//       }
//     },
//   ),
// ),