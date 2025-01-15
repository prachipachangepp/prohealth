import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/em_dashboard_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/provider/navigation_provider.dart';
import 'package:prohealth/app/resources/screen_route_name.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/company_identity.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/manage_emp_doc.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/manage_work_schedule.dart';
import 'package:prohealth/presentation/screens/em_module/see_all_screen/see_all_screen.dart';
import 'package:prohealth/presentation/screens/em_module/dashboard/dashboard_main_button_screen.dart';
import 'package:provider/provider.dart';
import '../../../app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import '../../widgets/app_bar/app_bar.dart';
import '../../widgets/widgets/const_appbar/controller.dart';
import '../hr_module/manage/widgets/bottom_row.dart';
import '../hr_module/manage/widgets/custom_icon_button_constant.dart';
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
              const ApplicationAppBar(headingText: EmDashboardStringManager.em),
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
                            height: AppSize.s30,
                            width: AppSize.s100,
                            onPressed: () {
                              myController.selectButton(0);
                              _pageController.animateToPage(0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              pgeControllerId = 0;
                            },
                            text: EmDashboardStringManager.dashboard,
                            isSelected: myController.selectedIndex.value == 0,
                          ),
                        ),
                        SizedBox(
                          width: AppSize.s10,
                        ),
                        Obx(
                          () => CustomTitleButton(
                            height: AppSize.s30,
                            width: AppSize.s140,
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
                            text: EmDashboardStringManager.companyIdentity,
                            isSelected: myController.selectedIndex.value == 1,
                          ),
                        ),
                        SizedBox(width: AppSize.s15,),
                        Obx(
                          () => Material(
                            elevation: 4,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: CustomDropdownButton(
                              height: AppSize.s30,
                              width: AppSize.s170,
                              items: [
                                DropdownMenuItem<String>(
                                  enabled:false,
                                  value: EmDashboardStringManager.selectModule,
                                  child: Text(
                                    EmDashboardStringManager.selectModule,
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
                                  enabled:false,
                                  value: EmDashboardStringManager.usermanagement,
                                  child: Text(
                                    EmDashboardStringManager.usermanagement,
                                    textAlign: TextAlign.center,
                                    style: AppbarCustomDropdownStyle.customTextStyle(context),
                                  ),
                                  onTap: () {  },
                                ),
                                DropdownMenuItem<String>(
                                  value: EmDashboardStringManager.Users,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: AppPadding.p20),
                                    child: Text(
                                      EmDashboardStringManager.Users,
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
                                  value: EmDashboardStringManager.roleManager,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: AppPadding.p20),
                                    child: Text(
                                        EmDashboardStringManager.roleManager,
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
                                  enabled:false,
                                  value: EmDashboardStringManager.clinical,
                                  child: Text(
                                    EmDashboardStringManager.clinical,
                                    textAlign: TextAlign.center,
                                    style: AppbarCustomDropdownStyle.customTextStyle(context),
                                  ),
                                  onTap: () { },
                                ),
                                DropdownMenuItem<String>(
                                  value: EmDashboardStringManager.visits,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: AppPadding.p20),
                                    child: Text(
                                      EmDashboardStringManager.visits,
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
                                  enabled:false,
                                  value: 'HR',
                                  child: Text(
                                    'HR',
                                    textAlign: TextAlign.center,
                                    style: AppbarCustomDropdownStyle.customTextStyle(context),
                                  ),
                                  onTap: () { },
                                ),
                                DropdownMenuItem<String>(
                                  value: EmDashboardStringManager.designationSetting,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: AppPadding.p20),
                                    child: Text(
                                      EmDashboardStringManager.designationSetting,
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
                                  value: EmDashboardStringManager.workSchedule,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: AppPadding.p20),
                                    child: Text(
                                      EmDashboardStringManager.workSchedule,
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
                                  value: EmDashboardStringManager.empDoc,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: AppPadding.p20),
                                    child: Text(
                                      EmDashboardStringManager.empDoc,
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
                                  enabled:false,
                                  value: 'Finance',
                                  child: Text(
                                    'Finance',
                                    textAlign: TextAlign.center,
                                    style: AppbarCustomDropdownStyle.customTextStyle(context),
                                  ),
                                  onTap: () {},
                                ),
                                DropdownMenuItem<String>(
                                  value: EmDashboardStringManager.payRates,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: AppPadding.p20),
                                    child: Text(
                                      EmDashboardStringManager.payRates,
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
                                  enabled:false,
                                  value: 'Org Document',
                                  child: Text(
                                    'Org Document',
                                    textAlign: TextAlign.center,
                                    style: AppbarCustomDropdownStyle.customTextStyle(context),
                                  ),
                                  onTap: () {},
                                ),
                                DropdownMenuItem<String>(
                                  value: EmDashboardStringManager.docDefination,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: AppPadding.p20),
                                    child: Text(
                                        EmDashboardStringManager.docDefination,
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
                                  ? EmDashboardStringManager.visits
                                  : myController.selectedIndex.value == 7
                                      ? EmDashboardStringManager.roleManager
                                      : myController.selectedIndex.value == 6
                                          ? EmDashboardStringManager.Users
                                          : myController.selectedIndex.value == 2
                                              ? EmDashboardStringManager.designationSetting
                                              : myController.selectedIndex.value == 3
                                                  ? EmDashboardStringManager.workSchedule
                                                  : myController.selectedIndex.value == 4
                                                      ? EmDashboardStringManager.empDoc
                                                      : myController.selectedIndex.value == 5
                                                          ? EmDashboardStringManager.payRates
                                                            : myController.selectedIndex.value == 9
                                                            ? EmDashboardStringManager.docDefination
                                                               : EmDashboardStringManager.selectModule,
                              onChanged: (newValue) {},
                            ),
                          ),
                        ),
                        SizedBox(width: AppSize.s15,),
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
                    ChangeNotifierProvider(
                        create: (_) => ManageEmployDocumentProvider(),
                        child: ManageEmployDocument()),
                    ChangeNotifierProvider(
                        create: (_) => FinanceProvider(),
                        child: FinanceScreen()),
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
      decoration: selectedItem != EmDashboardStringManager.selectModule
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
              color: selectedItem == EmDashboardStringManager.selectModule
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
                      color: selectedItem == EmDashboardStringManager.selectModule
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

