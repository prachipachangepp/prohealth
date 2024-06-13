import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../widgets/widgets/const_appbar/controller.dart';
import '../../../../widgets/widgets/profile_bar/profile_bar.dart';
import '../../../em_module/em_desktop_screen.dart';

import '../widgets/custom_icon_button_constant.dart';

class HrManageScreen extends StatelessWidget {
  final HRController hrController = Get.put(HRController());
  final PageController _pageController = PageController();
  final ButtonSelectionController myController =
      Get.put(ButtonSelectionController());

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      /// green blue container
      ProfileBar(),
      ///TabBar
      Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 100),
              child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() => CustomTitleButton(
                          height: 30,
                          width: 100,
                          onPressed: () {
                            myController.selectButton(0);
                            _pageController.animateToPage(0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          text: 'Dashboard',
                          isSelected: myController.selectedIndex.value == 0,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(() => CustomTitleButton(
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
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(() => CustomTitleButton(
                          height: 30,
                          width: 100,
                          onPressed: () {
                            myController.selectButton(2);
                            _pageController.animateToPage(2,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          text: 'Add Employee',
                          isSelected: myController.selectedIndex.value == 2,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(() => CustomTitleButton(
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
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(() => CustomTitleButton(
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
                        )),
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
            Container(color: Colors.green),
            // ManageScreen(),
            // AddEmployeeHomeScreen(),
            // RegisterScreen(),
            // OnBoardingScreen(),
            // Container(color: Colors.orange),
            // Container(color: Colors.blue),
          ],
        ),
      ),

      /// bottom row
      // BottomBarRow(),
    ]);
  }
}
