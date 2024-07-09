import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prohealth/presentation/screens/em_module/see_all_screen/see_all_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/dashboard/dashoboard_screen.dart';

import '../../../../app/resources/color.dart';
import '../../../widgets/app_bar/app_bar.dart';
import '../../../widgets/widgets/const_appbar/controller.dart';
import '../../em_module/em_desktop_screen.dart';
import '../add_employee/add_employee_screen.dart';
import '../manage/web_manage/manage_screen.dart';
import '../manage/widgets/custom_icon_button_constant.dart';
import '../onboarding/onboarding_screen.dart';
import '../register/register_screen.dart';

class HomeHrScreen extends StatefulWidget {
  const HomeHrScreen({super.key});

  @override
  State<HomeHrScreen> createState() => _HomeHrScreenState();
}

class _HomeHrScreenState extends State<HomeHrScreen> {
  final PageController _pageController = PageController();
  final SMController smController = Get.put(SMController());
  late final String? dropdownValue;
  late final ValueChanged<String?>? onChanged;
  final HRController hrController = Get.put(HRController());
  late final VoidCallback? onItem2Selected;
  bool showSelectOption = true;
  final ButtonSelectionController myController =
  Get.put(ButtonSelectionController());
  String selectedOption = 'Select';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ///log appbar
          ApplicationAppBar(headingText: "Human Resource Manager"),
          ///appbar titles
          Container(
            // color: Colors.pink,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///heading bar
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
                          myController.selectButton(1);
                          _pageController.animateToPage(1,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        text: 'Manage',
                        isSelected: myController.selectedIndex.value == 1,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Obx(
                          () => CustomTitleButton(
                        height: 30,
                        width: 140,
                        onPressed: () {
                          myController.selectButton(2);
                          _pageController.animateToPage(2,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        text: 'Add Employee',
                        isSelected: myController.selectedIndex.value == 2
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Obx(
                          () => CustomTitleButton(
                        height: 30,
                        width: 140,
                        onPressed: () {
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        text: 'Register',
                        isSelected: myController.selectedIndex.value == 3,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Obx(
                          () => CustomTitleButton(
                        height: 30,
                        width: 140,
                        onPressed: () {
                          myController.selectButton(4);
                          _pageController.animateToPage(4,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        text: 'Onboarding',
                        isSelected: myController.selectedIndex.value == 4,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(
                          () => CustomTitleButton(
                        height: 30,
                        width: 100,
                        onPressed: () {
                          //companyAll(context);
                          myController.selectButton(6);
                          _pageController.animateToPage(6,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        text: 'See All',
                        isSelected: myController.selectedIndex.value == 6,
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
          ///page view
          Expanded(
            flex: 8,
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
               DashBoardScreen(),
                ManageScreen(),
                AddEmployeeHomeScreen(),
                RegisterScreen(),
                OnBoardingScreen(),
               SeeAllScreen()
                // WhitelabellingScreen()
              ],
            ),
          ),
          // BottomAppBar()
        ],
      ),
    );
  }
}
