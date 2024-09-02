import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/manage_emp_doc.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/manage_work_schedule.dart';
import 'package:prohealth/presentation/screens/em_module/see_all_screen/see_all_screen.dart';
import '../../../app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import '../../widgets/app_bar/app_bar.dart';
import '../../widgets/widgets/const_appbar/controller.dart';
import '../hr_module/manage/widgets/bottom_row.dart';
import '../hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'company_identity/company_identity_screen.dart';
import 'manage_hr/hr_screen.dart';
import 'manage_hr/manage_pay_rates/finance_screen.dart';

class EMDesktopScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  final EMController smController = Get.put(EMController());
  final String? dropdownValue;
  final ValueChanged<String?>? onChanged;
  final HRController hrController = Get.put(HRController());
  final VoidCallback? onItem2Selected;
  String selectedOption = 'Select';

  bool showSelectOption = true;
  final ButtonSelectionController myController =
  Get.put(ButtonSelectionController());
  EMDesktopScreen({
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Column(
          children: [
            const ApplicationAppBar(headingText: "Establishment Manager"),
            ///2nd  buttons
            Container(
              margin: const EdgeInsets.symmetric(vertical: AppPadding.p20, horizontal: AppPadding.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(
                            () => CustomTitleButton(
                          height: 30,
                          width: 100,
                          onPressed: () {
                            //companyAll(context);
                            myController.selectButton(0);
                            _pageController.animateToPage(0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          text: 'Dashboard',
                          isSelected: myController.selectedIndex.value == 0,
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
                            // uploadCompanyLogoApi(context, 5, "employ");
                            companyByIdApi(context,);
                            // companyDetailsApi(context,5);
                            myController.selectButton(1);
                            _pageController.animateToPage(1,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          text: 'Company Identity',
                          isSelected: myController.selectedIndex.value == 1,
                        ),
                      ),

                      SizedBox(
                        width: 15,
                      ),
                      Obx(
                            () => Material(
                          elevation: 4,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: CustomDropdownButton(
                            height: 30,
                            width: 170,
                            items: [
                              DropdownMenuItem<String>(
                                value: 'Select a module',
                                child: Text(
                                  'Select a module',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.firaSans(
                                      fontSize: FontSize.s12,
                                      fontWeight: FontWeight.w700,
                                      color: ColorManager.textPrimaryColor
                                    // color: isSelected ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Users',
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    'Users',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.firaSans(
                                        fontSize: FontSize.s12,
                                        fontWeight: FontWeight.w400,
                                        color: ColorManager.textPrimaryColor
                                      // color: isSelected ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (myController.selectedIndex.value != 6) {
                                    myController.selectButton(6);
                                    _pageController.animateToPage(
                                      6,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  }
                                },
                              ),
                              DropdownMenuItem<String>(
                                value: 'HR',
                                child: Text(
                                  'HR',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.firaSans(
                                      fontSize: FontSize.s12,
                                      fontWeight: FontWeight.w700,
                                      color: ColorManager.textPrimaryColor
                                    // color: isSelected ? Colors.white : Colors.black,
                                  ),
                                ),
                                onTap: () {
                                  if (myController.selectedIndex.value != 2) {
                                    myController.selectButton(2);
                                    _pageController.animateToPage(
                                      2,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  }
                                },
                              ),
                              DropdownMenuItem<String>(
                                value: 'Designation Settings',
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Designation Settings',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.firaSans(
                                        fontSize: FontSize.s12,
                                        fontWeight: FontWeight.w400,
                                        color: ColorManager.textPrimaryColor
                                      // color: isSelected ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (myController.selectedIndex.value != 2) {
                                    myController.selectButton(2);
                                    _pageController.animateToPage(
                                      2,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  }
                                },
                              ),
                              DropdownMenuItem<String>(
                                value: 'Work Schedule',
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Work Schedule',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.firaSans(
                                        fontSize: FontSize.s12,
                                        fontWeight: FontWeight.w400,
                                        color: ColorManager.textPrimaryColor
                                      // color: isSelected ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (myController.selectedIndex.value != 3) {
                                    myController.selectButton(3);
                                    _pageController.animateToPage(
                                      3,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  }
                                },
                              ),
                              DropdownMenuItem<String>(
                                value: 'Employee Documents',
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Employee Documents',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.firaSans(
                                        fontSize: FontSize.s12,
                                        fontWeight: FontWeight.w400,
                                        color: ColorManager.textPrimaryColor
                                      // color: isSelected ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (myController.selectedIndex.value != 4) {
                                    myController.selectButton(4);
                                    _pageController.animateToPage(
                                      4,
                                      duration: Duration(milliseconds: 500),
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
                                      fontSize: FontSize.s12,
                                      fontWeight: FontWeight.w700,
                                      color: ColorManager.textPrimaryColor
                                    // color: isSelected ? Colors.white : Colors.black,
                                  ),
                                ),
                                onTap: () {
                                  if (myController.selectedIndex.value != 5) {
                                    myController.selectButton(5);
                                    _pageController.animateToPage(
                                      5,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  }
                                },
                              ),
                              DropdownMenuItem<String>(
                                value: 'Pay Rates',
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Pay Rates',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.firaSans(
                                        fontSize: FontSize.s12,
                                        fontWeight: FontWeight.w400,
                                        color: ColorManager.textPrimaryColor
                                      // color: isSelected ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (myController.selectedIndex.value != 5) {
                                    myController.selectButton(5);
                                    _pageController.animateToPage(
                                      5,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  }
                                },
                              ),
                            ],
                            selectedItem: myController.selectedIndex.value == 6
                                ? 'Users'
                                : myController.selectedIndex.value == 2
                                ? 'HR'
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
                      ),

                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                  //
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   children: [
                  //
                  //     Obx(
                  //       () => CustomTitleButton(
                  //         height: 30,
                  //         width: 100,
                  //         onPressed: () {
                  //           //companyAll(context);
                  //           myController.selectButton(6);
                  //           _pageController.animateToPage(6,
                  //               duration: Duration(milliseconds: 500),
                  //               curve: Curves.ease);
                  //         },
                  //         text: 'See All',
                  //         isSelected: myController.selectedIndex.value == 6,
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(color: ColorManager.white),
                  CompanyIdentityScreen(),
                  HrScreen(),
                  ManageWorkSchedule(),
                  ManageEmployDocument(),

                  FinanceScreen(),
                  SeeAllScreen(),

                  // WhitelabellingScreen()
                ],
              ),
            ),
            BottomBarRow()
          ],
        ),
      ]),
    );
  }
}

class EMController extends GetxController {
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: height + 5,
      decoration: selectedItem != 'Select a module'
          ? BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [
              Color(0xff51B5E6),
              Color(0xff008ABD),
            ],
          ))
          : const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          icon: Icon(
            Icons.arrow_drop_down,
            color: selectedItem == 'Select a module'
                ? ColorManager.textPrimaryColor
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
                    fontSize: FontSize.s12,
                    fontWeight: FontWeight.w700,
                    color: item.value == 'Select a module'
                        ? ColorManager.textPrimaryColor
                        : (selectedItem == item.value
                        ? Colors.white
                        : ColorManager.textPrimaryColor),
                  ),
                ),
              );
            }).toList();
          },

          dropdownColor: Colors.white,
        ),
      ),
    );
  }
}
