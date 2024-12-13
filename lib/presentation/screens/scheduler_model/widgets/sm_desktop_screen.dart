import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_calender/sm_calender.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_dashboard/sm_dashboard_screen.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_live_view/sm_live_view_screen.dart';
import '../../../../app/resources/value_manager.dart';
import '../../../widgets/app_bar/app_bar.dart';
import '../../../widgets/widgets/const_appbar/controller.dart';
import '../../hr_module/manage/widgets/bottom_row.dart';
import '../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../sm_Intake/intake_main_screen.dart';
import '../sm_scheduler/widget/schedular/schedular_new_screen.dart';

class SMDesktopScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  final SMController smController = Get.put(SMController());
  // final String? dropdownValue;
  final ValueChanged<String?>? onChanged;
  final HRController hrController = Get.put(HRController());
  final VoidCallback? onItem2Selected;
  String selectedOption = 'Select';

  bool showSelectOption = true;
  final ButtonSelectionSMController myController =
  Get.put(ButtonSelectionSMController());
  SMDesktopScreen({

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
            const ApplicationAppBar(headingText: "Scheduling Manager"),
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
                          height: AppSize.s30,
                          width: AppSize.s100,
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
                        width: AppSize.s10,
                      ),
                      Obx(
                            () => CustomTitleButton(
                          height: AppSize.s30,
                          width: AppSize.s140,
                          onPressed: () {

                            //companyByIdApi(context,);
                            // companyDetailsApi(context,5);
                            myController.selectButton(1);
                            _pageController.animateToPage(1,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          text: 'Intake',
                          isSelected: myController.selectedIndex.value == 1,
                        ),
                      ),

                      SizedBox(
                        width: 15,
                      ),

                      Obx(
                            () => CustomTitleButton(
                          height: AppSize.s30,
                          width: AppSize.s140,
                          onPressed: () {

                            //companyByIdApi(context,);
                            // companyDetailsApi(context,5);
                            myController.selectButton(2);
                            _pageController.animateToPage(2,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          text: 'Scheduler',
                          isSelected: myController.selectedIndex.value == 2,
                        ),
                      ),
                      SizedBox(
                        width: AppSize.s15,
                      ),
                      Obx(
                            () => CustomTitleButton(
                          height: AppSize.s30,
                          width: AppSize.s140,
                          onPressed: () {

                            //companyByIdApi(context,);
                            // companyDetailsApi(context,5);
                            myController.selectButton(3);
                            _pageController.animateToPage(3,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          text: 'Calender',
                          isSelected: myController.selectedIndex.value == 3,
                        ),
                      ),
                      SizedBox(
                        width: AppSize.s15,
                      ),

                      Obx(
                            () => CustomTitleButton(
                          height: AppSize.s30,
                          width: AppSize.s140,
                          onPressed: () {

                            //companyByIdApi(context,);
                            // companyDetailsApi(context,5);
                            myController.selectButton(4);
                            _pageController.animateToPage(4,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          text: 'Live View',
                          isSelected: myController.selectedIndex.value == 4,
                        ),
                      ),
                      SizedBox(
                        width: AppSize.s15,
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
                children: [
                  SMDashboardScreen(),
                 // IntakeMainScreen(),
                 SMIntakeScreen(),
                  NewSchedulerScreen(),
                  SmCalenderScreen(),
                  SmLiveViewMapScreen(),


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


class SMController extends GetxController {
  var selectedItem = 'Admin'.obs;
  void changeSelectedItem(String newItem) {
    selectedItem.value = newItem;
  }
}

class ButtonSelectionSMController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void selectButton(int index) {
    selectedIndex.value = index;
  }
}
