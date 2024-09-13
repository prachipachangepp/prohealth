import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/acknowledgement.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/banking_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/genaral_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/health_record_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/qualification_tab.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/const_string.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/value_manager.dart';
import '../manage/widgets/bottom_row.dart';

class NewOnboardScreen extends StatefulWidget {
  const NewOnboardScreen({super.key});

  @override
  State<NewOnboardScreen> createState() => _NewOnboardScreenState();
}

class _NewOnboardScreenState extends State<NewOnboardScreen> {
  final PageController _onboardPageController = PageController();
  int _selectedIndex = 0;
  int employeeIdCheck = 0;

  void _selectButton(int index,int employeeId) {
    setState(() {
      _selectedIndex = index;
      employeeIdCheck = employeeId;
    });
    _onboardPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingTabManage(managePageController: _onboardPageController, selectedIndex: _selectedIndex,
        selectButton: _selectButton, employeeId: employeeIdCheck,);
  }
}

class OnboardingTabManage extends StatefulWidget {
  final PageController managePageController;
  final int selectedIndex;
  final int employeeId;
  final void Function(int,int) selectButton;
  const OnboardingTabManage({super.key, required this.managePageController, required this.selectedIndex, required this.selectButton, required this.employeeId,
  });

  @override
  State<OnboardingTabManage> createState() => _OnboardingTabManageState();
}



class _OnboardingTabManageState extends State<OnboardingTabManage> {
  final List<String> _categories = [
    // AppString.general,
    AppString.qualification,
    AppString.banking,
    AppString.healthRecord,
    AppString.acknowledgement,
    AppString.formStatus
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorManager.white,
      child: Column(
        children: [
          if (widget.selectedIndex != 0)
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // InkWell(
                  //   onTap: (){
                  //     Navigator.pop(context);
                  //   },
                  //   child: Text(
                  //     'Go Back',
                  //     style: GoogleFonts.firaSans(
                  //       fontSize: FontSize.s12,
                  //       fontWeight: FontWeightManager.bold,
                  //       color: ColorManager.mediumgrey,
                  //       decoration: TextDecoration.underline,
                  //     ),
                  //   ),
                  // ),
                 // SizedBox(width: MediaQuery.of(context).size.width/6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: AppSize.s28,
                          width: MediaQuery.of(context).size.width / 1.68,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorManager.blueprime,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: _categories
                                .asMap()
                                .entries
                                .map(
                                  (entry) => InkWell(
                                child: Container(
                                  height: AppSize.s30,
                                  width: MediaQuery.of(context).size.width / 8.42,
                                  padding: EdgeInsets.symmetric(vertical: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: widget.selectedIndex - 1 == entry.key //color: widget.selectedIndex == entry.key
                                        ? Colors.white : null,
                                  ),
                                  child: Text(
                                    entry.value,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.firaSans(
                                      textStyle: TextStyle(
                                        fontSize: FontSize.s12,
                                        fontWeight: FontWeightManager.semiBold,
                                        color: widget.selectedIndex - 1 == entry.key //color: widget.selectedIndex == entry.key
                                            ? ColorManager.mediumgrey
                                            : ColorManager.white,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () => widget.selectButton(entry.key + 1,widget.employeeId),  //onTap: () => widget.selectButton(entry.key),
                              ),
                            )
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width / 45),
              child: PageView(
                controller: widget.managePageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  OnboardingGeneral(selectButton: widget.selectButton),
                  OnboardingQualification(employeeId: widget.employeeId,),
                  Banking(employeeId: widget.employeeId,),
                  HealthRecord(employeeId: widget.employeeId,),
                  Acknowledgement(employeeId: widget.employeeId,),
                  Acknowledgement(employeeId: widget.employeeId,),
                ],
              ),
            ),
          ),
          BottomBarRow(),
        ],
      ),
    );
  }
}