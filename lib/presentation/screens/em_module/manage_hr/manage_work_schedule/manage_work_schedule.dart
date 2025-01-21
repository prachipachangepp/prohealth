import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:provider/provider.dart';
import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import 'work_schedule/define_holidays.dart';
import 'work_schedule/define_work_weeks.dart';

class WorkScheduleProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  int get selectedIndex => _selectedIndex;
  PageController get pageController => _pageController;

  void selectButton(int index) {
    _selectedIndex = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    notifyListeners();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class WorkSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final workScheduleProvider = Provider.of<WorkScheduleProvider>(context);

    return Material(
      color: Colors.white,
      child: Column(
        children: [
          // Header Buttons
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p15,top: AppPadding.p20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: AppSize.s30,
                    width:AppSize.s315,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorManager.blueprime,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Shift & Batch Button
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () => workScheduleProvider.selectButton(0),
                          child: Container(
                            height: AppSize.s30,
                            width: AppSize.s160,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              color: workScheduleProvider.selectedIndex == 0
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                AppStringEM.shiftbatch,
                                style:  BlueBgTabbar.customTextStyle(0, workScheduleProvider.selectedIndex),
                              ),
                              ),
                            ),
                          ),
                        // Define Holiday Button
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () => workScheduleProvider.selectButton(1),
                          child: Container(
                            height: AppSize.s30,
                            width: AppSize.s155,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              color: workScheduleProvider.selectedIndex == 1
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                AppStringEM.defineHoliday,
                                style:  BlueBgTabbar.customTextStyle(1, workScheduleProvider.selectedIndex),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Page View Content
          Expanded(
            flex: 10,
            child: Stack(
              children: [
                workScheduleProvider.selectedIndex == 1
                    ? const Offstage()
                    : Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F9FC),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.faintGrey,
                        blurRadius: 2,
                        spreadRadius: -2,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 45,
                  ),
                  child: PageView(
                    controller: workScheduleProvider.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      DefineWorkWeek(),
                      ChangeNotifierProvider(
                          create: (_) => DefineHolidaysProvider(),
                          child: DefineHolidays()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
