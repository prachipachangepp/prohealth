import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_calender/sm_calender.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_dashboard/sm_dashboard_screen.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_dashboard/widgets/sub_widgets/highest_code_view_more.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_live_view/sm_live_view_screen.dart';
import '../../../../app/resources/value_manager.dart';
import '../../../widgets/app_bar/app_bar.dart';
import '../../../widgets/widgets/const_appbar/controller.dart';
import '../../hr_module/manage/widgets/bottom_row.dart';
import '../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../sm_Intake/intake_main_screen.dart';
import '../sm_scheduler/widget/schedular/schedular_new_screen.dart';

class SMDesktopScreen extends StatefulWidget {
  final ValueChanged<String?>? onChanged;
  final VoidCallback? onItem2Selected;

  SMDesktopScreen({this.onChanged,this.onItem2Selected,});

  @override
  State<SMDesktopScreen> createState() => _SMDesktopScreenState();
}

class _SMDesktopScreenState extends State<SMDesktopScreen> {
  final PageController _pageController = PageController();

  final SMController smController = Get.put(SMController());

  final HRController hrController = Get.put(HRController());

  String selectedOption = 'Select';

  bool showSelectOption = true;

  final ButtonSelectionSMController myController = Get.put(ButtonSelectionSMController());

  void navigateToPage2() {
    if (_pageController.page != 2) {
      _pageController.animateToPage(
        2,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  bool _showHighestCaseViewMoreScreen = false;
  bool _showHighesClinicianTypeViewMoreScreen = false;

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
             // color: Colors.pink,
              margin: const EdgeInsets.symmetric(vertical: AppPadding.p20, horizontal: AppPadding.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Obx(
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
                  ),
                  SizedBox(
                    width: AppSize.s60,
                  ),
                  Expanded(
                    child: Obx(
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
                  ),

                  SizedBox(
                    width: AppSize.s60,
                  ),

                  Expanded(
                    child: Obx(
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
                  ),
                  SizedBox(
                    width: AppSize.s60,
                  ),
                  Expanded(
                    child: Obx(
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
                  ),
                  SizedBox(
                    width: AppSize.s60,
                  ),

                  Expanded(
                    child: Obx(
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
                  ),
                  SizedBox(
                    width: AppSize.s60,
                  ),
                  Expanded(
                    child: Obx(
                          () => CustomTitleButton(
                        height: AppSize.s30,
                        width: AppSize.s140,
                        onPressed: () {

                          //companyByIdApi(context,);
                          // companyDetailsApi(context,5);
                          myController.selectButton(5);
                          _pageController.animateToPage(5,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        text: 'Today',
                        isSelected: myController.selectedIndex.value == 5,
                      ),
                    ),
                  ),
                  Expanded(child: Container(),flex: 2,)
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: _showHighestCaseViewMoreScreen
              ? HigestCaseViewMoreScreen(
                onGoBackHigestCase:  () {
                  setState(() {
                    _showHighestCaseViewMoreScreen = false; // Show PageView
                  });
                },
              )
              : _showHighesClinicianTypeViewMoreScreen
              ? HigestCaseClinicianTypeViewScreen(
                onGoBackClinicianType: () {
                  setState(() {
                    _showHighesClinicianTypeViewMoreScreen = false; // Show PageView
                  });
                },)
              : PageView(
                controller: _pageController,
                onPageChanged: (index){
                  myController.selectButton(index);
                },
                physics: NeverScrollableScrollPhysics(),
                children: [
                  SMDashboardScreen(pageController: _pageController,
                    onViewMoreTap: () {
                      setState(() {
                        _showHighestCaseViewMoreScreen = true; // Show view-more screen
                      });
                    },
                  onViewMoreClinicianTypeTap: (){
                    setState(() {
                      _showHighesClinicianTypeViewMoreScreen = true; // Show view-more screen
                    });
                  },
                  ),
                  IntakeMainScreen(),
                 // SMIntakeScreen(),
                  NewSchedulerScreen(),
                  SmCalenderScreen(),
                  SmLiveViewMapScreen(),
                  Container(color:Colors.white)


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
