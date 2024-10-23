import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/banking_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/form_status.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/genaral_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/qualification_tab.dart';
import '../../../../app/resources/color.dart';
import '../../../../app/resources/const_string.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/value_manager.dart';
import '../manage/widgets/bottom_row.dart';


class NewOnboardScreen extends StatefulWidget {
  final VoidCallback onBackPressed;
  const NewOnboardScreen({super.key, required this.onBackPressed});

  @override
  State<NewOnboardScreen> createState() => _NewOnboardScreenState();
}

class _NewOnboardScreenState extends State<NewOnboardScreen> {
  final PageController _onboardPageController = PageController();
  int _selectedIndex = 0;
  int employeeIdCheck = 0;
  String employeeName = '';

  void _selectButton(int index, int employeeId, String name) {
    setState(() {
      _selectedIndex = index;
      employeeIdCheck = employeeId;
      employeeName = name;
    });
    _onboardPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void _handleBackButton(bool value) {
    if (value) {
      setState(() {
        _selectedIndex = 0;
      });
      _onboardPageController.jumpToPage(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingTabManage(
      managePageController: _onboardPageController,
      selectedIndex: _selectedIndex,
      selectButton: _selectButton,
      employeeId: employeeIdCheck,
      employeeName: employeeName,
      backButtonCallBack: _handleBackButton, onBackPressed: widget.onBackPressed,
    );
  }
}


///
typedef BackButtonCallBack = void Function(bool val);

class OnboardingTabManage extends StatefulWidget {
  final PageController managePageController;
  final int selectedIndex;
  final int employeeId;
  final String employeeName;
  final BackButtonCallBack backButtonCallBack;
  final VoidCallback onBackPressed;
  final void Function(int,int, String) selectButton;
  OnboardingTabManage({super.key, required this.managePageController, required this.selectedIndex, required this.selectButton,
    required this.employeeId, required this.employeeName,required this.backButtonCallBack, required this.onBackPressed,
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
   color: Colors.white  ,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.selectedIndex != 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 340,vertical: 2),
              child: Container(
                //color: ColorManager.red,
                child: Text(
                  widget.employeeName,
                  style: CompanyIdentityManageHeadings.customTextStyle(context),
                ),
              ),
            ),
          SizedBox(height: 20,),
          if (widget.selectedIndex != 0)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: (){
                        widget.backButtonCallBack(true);
                      },
                    child:Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 15,
                          color: ColorManager.mediumgrey,

                        ),

                        SizedBox(width: 1,),
                        Text(
                          'Back',
                          style: DefineWorkWeekStyle.customTextStyle(context),
                        ),
                      ],
                    )
                  ),


                  Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   children: [
                      //     if (widget.selectedIndex != 0)
                      //       Padding(
                      //         padding: const EdgeInsets.only(bottom: AppPadding.p10),
                      //         child: Container(
                      //           //color: ColorManager.red,
                      //           child: Text(
                      //             widget.employeeName,
                      //             style: TextStyle(
                      //               fontSize: FontSize.s15,
                      //               color: ColorManager.white,
                      //               fontWeight: FontWeight.w700,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //
                      //   ],
                      // ),
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
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                    child: Container(
                                      height: AppSize.s30,
                                      width: MediaQuery.of(context).size.width / 8.42,
                                      padding: EdgeInsets.symmetric(vertical: 3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: widget.selectedIndex - 1 == entry.key //color: widget.selectedIndex == entry.key
                                            ? Colors.white : null,
                                      ),
                                      child: Text(
                                        entry.value,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: FontSize.s14,
                                            fontWeight: FontWeight.w600,
                                            color: widget.selectedIndex - 1 == entry.key //color: widget.selectedIndex == entry.key
                                                ? ColorManager.mediumgrey
                                                : ColorManager.white,
                                        ),
                                      ),
                                    ),
                                    onTap: () => widget.selectButton(entry.key + 1,widget.employeeId, widget.employeeName),  //onTap: () => widget.selectButton(entry.key),
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
                  if (widget.selectedIndex != 0)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppPadding.p5),
                      child: Container(
                        //color: ColorManager.red,
                        child: Text(
                          widget.employeeName,
                          style: TextStyle(
                            fontSize: FontSize.s15,
                            color: ColorManager.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width / 45),
              child:
              PageView(
                controller: widget.managePageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  OnboardingGeneral(selectButton: widget.selectButton, goBackButtion: widget.onBackPressed),
                  OnboardingQualification(employeeId: widget.employeeId,),
                  Banking(employeeId: widget.employeeId,),
                  HealthRecord(employeeId: widget.employeeId,),
                  Acknowledgement(employeeId: widget.employeeId,),
                  FormStatusScreen(employeeId: widget.employeeId,),
                ],
              ),
            ),
          ),
         // BottomBarRow(),
        ],
      ),
    );
  }
}