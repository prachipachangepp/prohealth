import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/provider/navigation_provider.dart';
import 'package:prohealth/app/resources/screen_route_name.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/company_identity.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/manage_emp_doc.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/manage_work_schedule.dart';
import 'package:prohealth/presentation/screens/em_module/see_all_screen/see_all_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/hr_home_screen/dashboard_main_button_screen.dart';
import 'package:provider/provider.dart';
import '../../../app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import '../../widgets/app_bar/app_bar.dart';
import '../../widgets/widgets/const_appbar/controller.dart';
import '../hr_module/manage/widgets/bottom_row.dart';
import '../hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'company_identity/company_identity_screen.dart';
import 'company_identity/widgets/ci_tab_widget/ci_org_document.dart';
import 'company_identity/widgets/ci_tab_widget/ci_role_manager.dart';
import 'company_identity/widgets/ci_tab_widget/ci_visit.dart';
import 'manage_hr/hr_screen.dart';
import 'manage_hr/manage_pay_rates/finance_screen.dart';

class EMDesktopScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  final EMController smController = Get.put(EMController());
  final String? dropdownValue;
  final ValueChanged<String?>? onChanged;
  final HRController hrController = Get.put(HRController());
  final VoidCallback? onItem2Selected;
  //String selectedOption = 'Select ';
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
  void navigateToPage(BuildContext context, String routeName) {
    Provider.of<RouteProvider>(
        context,
        listen: false)
        .setRoute(
        routeName);
    //Navigator.pushNamed(context, routeName);
    switch (routeName) {
      case RouteStrings.emCompanyIdentity:
        _pageController.animateToPage(1,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease);
        break;
      // case RoutesManager.companyIdentityRoute:
      //   _pageController.jumpToPage(1);
      //   break;
      default:
        break;
    }
  }
  int pgeControllerId = 0;
  Future<bool> _onWillPop() async {
    if (pgeControllerId == 0) {
      _pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
      // return false; // Prevent the default back navigation
    }else if(pgeControllerId == 1){
      myController.selectButton(0);
      _pageController.animateToPage(0,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);
      return false;
    }else if(pgeControllerId == 6){
      myController.selectButton(1);
      _pageController.animateToPage(1,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);
      return false;
    }
    // else if(pgeControllerId == 2){
    //   myController.selectButton(1);
    //   _pageController.animateToPage(1,
    //       duration: Duration(milliseconds: 500),
    //       curve: Curves.ease);
    //   return false;
    // }else if(pgeControllerId == 3){
    //   myController.selectButton(2);
    //   _pageController.animateToPage(2,
    //       duration: Duration(milliseconds: 500),
    //       curve: Curves.ease);
    //   return false;
    // }
    return true; // Allow the back navigation to exit the app
  }
  //final int companyId = await TokenManager.getCompanyId();
  @override
  Widget build(BuildContext context) {
    // RoutesManager routesManager = RoutesManager();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Column(
            children: [
              const ApplicationAppBar(headingText: "Establishment Manager"),
              ///2nd  buttons
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: AppPadding.p20, horizontal: AppPadding.p20),
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
                              myController.selectButton(0);
                              _pageController.animateToPage(0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              pgeControllerId = 0;
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
                              companyByIdApi(
                                context,
                              );
                              myController.selectButton(1);
                              _pageController.animateToPage(1, duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              pgeControllerId = 1;
                            },
                            text: 'Company Identity',
                            isSelected: myController.selectedIndex.value == 1,
                          ),
                        ),
                        SizedBox(width: 15,),
                        Obx(
                          () => Material(
                            elevation: 4,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: CustomDropdownButton(
                              height: 30,
                              width: 170,
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'Select a Module',
                                  child: Text(
                                    'Select a Module',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: FontSize.s14,
                                      fontWeight: FontWeight.w700,
                                      color: ColorManager.textPrimaryColor,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'User Management',
                                  child: Text(
                                    'User Management',
                                    textAlign: TextAlign.center,
                                    style: AppbarCustomDropdownStyle.customTextStyle(context),
                                  ),
                                  onTap: () {  },
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Users',
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Users',
                                      textAlign: TextAlign.center,
                                      style: AppbarCustomDropdownSubItem.customTextStyle(context)
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
                                      pgeControllerId = 6;
                                    }
                                  },
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Role Manager',
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Role Manager',
                                      textAlign: TextAlign.center,
                                      style: AppbarCustomDropdownSubItem.customTextStyle(context)
                                    ),
                                  ),
                                  onTap: () {
                                    if (myController.selectedIndex.value != 7) {
                                      myController.selectButton(7);
                                      _pageController.animateToPage(
                                        7,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                ),

                                ///clinical
                                DropdownMenuItem<String>(
                                  value: 'Clinical',
                                  child: Text(
                                    'Clinical',
                                    textAlign: TextAlign.center,
                                    style: AppbarCustomDropdownStyle.customTextStyle(context),
                                  ),
                                  onTap: () { },
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Visits',
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Visits',
                                      textAlign: TextAlign.center,
                                      style: AppbarCustomDropdownSubItem.customTextStyle(context)
                                    ),
                                  ),
                                  onTap: () {
                                    if (myController.selectedIndex.value != 8) {
                                      myController.selectButton(8);
                                      _pageController.animateToPage(
                                        8,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                ),

                                ///hr
                                DropdownMenuItem<String>(
                                  value: 'HR',
                                  child: Text(
                                    'HR',
                                    textAlign: TextAlign.center,
                                    style: AppbarCustomDropdownStyle.customTextStyle(context),
                                  ),
                                  onTap: () { },
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Designation Settings',
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Designation Settings',
                                      textAlign: TextAlign.center,
                                      style: AppbarCustomDropdownSubItem.customTextStyle(context)
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
                                      style:AppbarCustomDropdownSubItem.customTextStyle(context)
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
                                      style: AppbarCustomDropdownSubItem.customTextStyle(context)
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

                                ///finance
                                DropdownMenuItem<String>(
                                  value: 'Finance',
                                  child: Text(
                                    'Finance',
                                    textAlign: TextAlign.center,
                                    style: AppbarCustomDropdownStyle.customTextStyle(context),
                                  ),
                                  onTap: () {},
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Pay Rates',
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Pay Rates',
                                      textAlign: TextAlign.center,
                                      style: AppbarCustomDropdownSubItem.customTextStyle(context)
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

                                ///org doc
                                ///finance
                                DropdownMenuItem<String>(
                                  value: 'Org Document',
                                  child: Text(
                                    'Org Document',
                                    textAlign: TextAlign.center,
                                    style: AppbarCustomDropdownStyle.customTextStyle(context),
                                  ),
                                  onTap: () {},
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Document Defination',
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                        'Document Defination',
                                        textAlign: TextAlign.center,
                                        style: AppbarCustomDropdownSubItem.customTextStyle(context)
                                    ),
                                  ),
                                  onTap: () {
                                    if (myController.selectedIndex.value != 9) {
                                      myController.selectButton(9);
                                      _pageController.animateToPage(9,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                ),
                              ],

                              selectedItem: myController.selectedIndex.value == 8
                                  ? 'Visits'
                                  : myController.selectedIndex.value == 7
                                      ? 'Role Manager'
                                      : myController.selectedIndex.value == 6
                                          ? 'Users'
                                          : myController.selectedIndex.value == 2
                                              ? 'Designation Settings'
                                              : myController.selectedIndex.value == 3
                                                  ? 'Work Schedule'
                                                  : myController.selectedIndex.value == 4
                                                      ? 'Employee Documents'
                                                      : myController.selectedIndex.value == 5
                                                          ? 'Pay Rates'
                                                            : myController.selectedIndex.value == 9
                                                            ? 'Document Defination'
                                                               : 'Select a Module',
                              onChanged: (newValue) {},
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 8,
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children:
                  [
                    DashboardMainButtonScreen(),
                    CompanyIdentity(),
                    //CompanyIdentityScreen(),
                    HrScreen(),
                    WorkSchedule(),
                    ManageEmployDocument(),
                    FinanceScreen(),
                    SeeAllScreen(),
                    CiRoleManager(),
                    CiVisitScreen(),
                    CiOrgDocument
                      (
                      //officeId:
                    //widget.officeId ??
                        //'Office 01',
                      //companyId: companyId,
                    ),
                  ],
                              ),
              ),
              BottomBarRow()
            ],
          ),
        ]),
      ),
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
      decoration: selectedItem != 'Select a Module'
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [
                  Color(0xff51B5E6),
                  Color(0xff008ABD),
                ],
              ))
          : const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.white),
      child: DropdownButtonHideUnderline(
        child: Theme(
          data: Theme.of(context).copyWith(
            hoverColor: Colors.transparent,
          ),
          child: DropdownButton<String>(
            icon: Icon(
              Icons.arrow_drop_down,
              color: selectedItem == 'Select a Module'
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
                    style: TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w700,
                      color: selectedItem == 'Select a Module'
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
      ),
    );
  }
}

///06
// class EMDesktopScreen extends StatefulWidget {
//   final String? dropdownValue;
//   final ValueChanged<String?>? onChanged;
//   final VoidCallback? onItem2Selected;
//
//   EMDesktopScreen({
//     this.dropdownValue,
//     this.onChanged,
//     this.onItem2Selected,
//   });
//
//   @override
//   State<EMDesktopScreen> createState() => _EMDesktopScreenState();
// }
//
// class _EMDesktopScreenState extends State<EMDesktopScreen> {
//   final PageController _pageController = PageController();
//
//   final EMController smController = Get.put(EMController());
//
//   final HRController hrController = Get.put(HRController());
//
//   String selectedOption = 'Select';
//
//
//   bool showSelectOption = true;
//
//   final ButtonSelectionController myController =
//   Get.put(ButtonSelectionController());
//
//   void navigateToPage2() {
//     if (_pageController.page != 2) {
//       _pageController.animateToPage(
//         2,
//         duration: Duration(milliseconds: 500),
//         curve: Curves.ease,
//       );
//     }
//   }
//
//   String? selectedMainCategory;
//
//   String? selectedSubItem;
//
//   OverlayEntry? overlayEntry;
//
//   Map<String, List<Map<String, dynamic>>> menuOptions = {
//     'User Management': [
//       {'title': 'Users', 'pageIndex': 2},
//       {'title': 'Role Manager', 'pageIndex': 3},
//     ],
//     'Clinical': [
//       {'title': 'Visits', 'pageIndex': 4},
//     ],
//     'HR': [
//       {'title': 'Designation Settings', 'pageIndex': 5},
//       {'title': 'Work Schedule', 'pageIndex': 6},
//       {'title': 'Employee Documents', 'pageIndex': 7},
//     ],
//     'Finance': [
//       {'title': 'Pay Rates', 'pageIndex': 8},
//     ],
//   };
//
//   List<String> mainCategories = ['User Management', 'Clinical', 'HR', 'Finance'];
//
//   final GlobalKey mainDropdownKey = GlobalKey();
//   String? isSelected;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(children: [
//         Column(
//           children: [
//             const ApplicationAppBar(headingText: "Establishment Manager"),
//             ///2nd  buttons
//             Container(
//               margin: const EdgeInsets.symmetric(vertical: AppPadding.p20, horizontal: AppPadding.p20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Obx(
//                             () => CustomTitleButton(
//                           height: 30,
//                           width: 100,
//                           onPressed: () {
//                             //companyAll(context);
//                             myController.selectButton(0);
//                             _pageController.animateToPage(0,
//                                 duration: Duration(milliseconds: 500),
//                                 curve: Curves.ease);
//                           },
//                           text: 'Dashboard',
//                           isSelected: myController.selectedIndex.value == 0,
//                         ),
//                       ),
//                       SizedBox(width: 10,),
//                       Obx(
//                             () => CustomTitleButton(
//                           height: 30,
//                           width: 140,
//                           onPressed: () {
//                             // uploadCompanyLogoApi(context, 5, "employ");
//                             companyByIdApi(context,);
//                             // companyDetailsApi(context,5);
//                             myController.selectButton(1);
//                             _pageController.animateToPage(1,
//                                 duration: Duration(milliseconds: 500),
//                                 curve: Curves.ease);
//                           },
//                           text: 'Company Identity',
//                           isSelected: myController.selectedIndex.value == 1,
//                         ),
//                       ),
//                       SizedBox(width: 15,),
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         height: 30,
//                         decoration: selectedMainCategory == null || selectedMainCategory == 'Select a module'
//                             ? const BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                           color: Colors.white, // White color for initial state
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black12, // Shadow color
//                               blurRadius: 8,        // Softness of the shadow
//                               offset: Offset(2, 2), // Position of the shadow (horizontal and vertical)
//                             ),
//                           ],
//                         )
//                             : BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           gradient: const LinearGradient(
//                             colors: [
//                               Color(0xff51B5E6),
//                               Color(0xff008ABD),
//                             ],
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black26, // Darker shadow for gradient state
//                               blurRadius: 10,
//                               offset: Offset(2, 4),
//                             ),
//                           ],
//                         ),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton<String>(
//                             key: mainDropdownKey,
//                             hint: Text(
//                               'Select a module',
//                               style: GoogleFonts.firaSans(
//                                 fontSize: FontSize.s12,
//                                 fontWeight: FontWeight.w700,
//                                 color: selectedMainCategory == null || selectedMainCategory == 'Select a module'
//                                     ? Colors.black
//                                     : Colors.white,
//                               ),
//                             ),
//                             value: selectedMainCategory == 'Select a module' ? null : selectedMainCategory,
//                             icon: Icon(
//                               Icons.arrow_drop_down,
//                               color: selectedMainCategory == null || selectedMainCategory == 'Select a module'
//                                   ? Colors.black
//                                   : Colors.white,
//                             ),
//                             items: mainCategories.map((String category) {
//                               return DropdownMenuItem<String>(
//                                 value: category,
//                                 child: Text(
//                                   category,
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: FontSize.s12,
//                                     fontWeight: FontWeight.w700,
//                                     color: selectedMainCategory == category
//                                         ? Colors.white
//                                         : ColorManager.textPrimaryColor,
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                             onChanged: (value) {
//                               if (value != null) {
//                                 setState(() {
//                                   selectedMainCategory = value;
//                                 });
//
//                                 showSubmenuDropdown(context, value);
//                               }
//                             },
//                           ),
//                         ),
//                       )
//
//
//
//
//                       ///
//
//
//                       // Container(
//                       //   padding: const EdgeInsets.symmetric(horizontal: 20),
//                       //   height: 40,
//                       //   decoration: selectedMainCategory != 'Select a module'
//                       //       ? BoxDecoration(
//                       //     borderRadius: BorderRadius.circular(12),
//                       //     gradient: const LinearGradient(
//                       //       colors: [
//                       //         Color(0xff51B5E6),
//                       //         Color(0xff008ABD),
//                       //       ],
//                       //       begin: Alignment.topCenter,
//                       //       end: Alignment.bottomCenter,
//                       //     ),
//                       //   )
//                       //       : const BoxDecoration(
//                       //     borderRadius: BorderRadius.all(Radius.circular(10)),
//                       //     color: Colors.white,
//                       //   ),
//                       //   child: DropdownButtonHideUnderline(
//                       //     child: DropdownButton<String>(
//                       //       key: mainDropdownKey,
//                       //       hint: Text('Select a module',
//                       //       style: GoogleFonts.firaSans(
//                       //                 fontSize: FontSize.s12,
//                       //                 fontWeight: FontWeight.w700,
//                       //                 // color: ColorManager.textPrimaryColor
//                       //               color: isSelected ? Colors.white : Colors.black,
//                       //             ),),
//                       //       value: selectedMainCategory,
//                       //       items: mainCategories.map((String category) {
//                       //         return DropdownMenuItem<String>(
//                       //           value: category,
//                       //           child: Text(category,
//                       //             style: GoogleFonts.firaSans(
//                       //             fontSize: FontSize.s12,
//                       //             fontWeight: FontWeight.w700,
//                       //             color: ColorManager.textPrimaryColor
//                       //           ),),
//                       //         );
//                       //       }).toList(),
//                       //       onChanged: (value) {
//                       //         if (value != null) {
//                       //           setState(() {
//                       //             selectedMainCategory = value;
//                       //           });
//                       //           // Show the overlay dropdown for sub-items
//                       //           showSubmenuDropdown(context, value);
//                       //         }
//                       //       },
//                       //     ),
//                       //   ),
//                       // ),
//
//                     ],
//                   ),
//                       SizedBox(width: 15,),
//                     ],
//                   ),
//
//               ),
//
//             Expanded(
//               flex: 8,
//               child: PageView(
//                 controller: _pageController,
//                 physics: NeverScrollableScrollPhysics(),
//                 children: [
//                   Container(child:Image.asset('images/EMDASHBOARD.jpg',fit: BoxFit.contain,)),
//                   CompanyIdentityScreen(),
//                   SeeAllScreen(),
//                   CiRoleManager(),
//                   CiVisitScreen(),
//                   HrScreen(),
//                   ManageWorkSchedule(),
//                   ManageEmployDocument(),
//                   FinanceScreen(),
//
//                 ],
//               ),
//             ),
//             BottomBarRow()
//           ],
//         ),
//       ]),
//     );
//   }
//
//   // Show an overlay dropdown with submenu items for the selected main category
//   void showSubmenuDropdown(BuildContext context, String mainCategory) {
//     // Remove the previous overlay if it exists
//     if (overlayEntry != null && overlayEntry!.mounted) {
//       overlayEntry!.remove();
//     }
//
//     // Get the position and size of the main dropdown
//     final RenderBox renderBox = mainDropdownKey.currentContext!.findRenderObject() as RenderBox;
//     final size = renderBox.size;
//     final offset = renderBox.localToGlobal(Offset.zero);
//
//     // Create a new overlay entry for submenu
//     overlayEntry = OverlayEntry(
//       builder: (context) {
//         return Positioned(
//           left: offset.dx, // Position it below the dropdown
//           top: offset.dy + size.height, // Just below the main dropdown
//           width: size.width, // Use the same width as the main dropdown
//           child: Material(
//             elevation: 4.0,
//             child: ConstrainedBox(
//               constraints: BoxConstraints(maxHeight: 200), // Limit dropdown height if needed
//               child: ListView(
//                 padding: EdgeInsets.zero,
//                 shrinkWrap: true,
//                 children: menuOptions[mainCategory]!.map((subItem) {
//                   return ListTile(
//                     title: Text(subItem['title'],style: GoogleFonts.firaSans(
//                       fontSize: FontSize.s12,
//                       fontWeight: FontWeight.w700,
//                       color: subItem.values == 'Select a module'
//                           ? ColorManager.textPrimaryColor
//                           : (selectedSubItem == subItem.values
//                           ? Colors.white
//                           : ColorManager.textPrimaryColor),
//                     ),),
//                     onTap: () {
//                       setState(() {
//                         selectedSubItem = subItem['title'];
//                         if (overlayEntry != null) {
//                           overlayEntry!.remove(); // Close the submenu when an item is selected
//                         }
//                       });
//                       _navigateToPage(subItem['pageIndex']);
//                     },
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//
//     // Insert the overlay entry into the overlay stack
//     Overlay.of(context)?.insert(overlayEntry!);
//   }
//
//   void _navigateToPage(int pageIndex) {
//     // Navigate to the corresponding page
//     _pageController.animateToPage(
//       pageIndex,
//       duration: Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//   }
// }
//
//
