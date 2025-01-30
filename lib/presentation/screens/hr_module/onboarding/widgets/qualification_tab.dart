import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/widgets/banking_tab_constant.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../em_module/company_identity/company_identity_screen.dart';
import '../../../em_module/company_identity/widgets/ci_tab_widget/widget/upper_menu_buttons.dart';
import '../../manage/controller/controller.dart';
import '../qualification_const_bar/widgets/onboarding_qualification.dart';

/// to do saloni
class OnboardingQualification extends StatefulWidget {
  late QualificationTabBarController controller;
  final int employeeId;
  final int departmentId;
  OnboardingQualification({required this.employeeId, required this.departmentId});
  @override
  State<OnboardingQualification> createState() =>
      _OnboardingQualificationState();
}

class _OnboardingQualificationState extends State<OnboardingQualification> {
  final PageController _tabPageController = PageController();

  int _selectedIndex = 0;
  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _tabPageController.jumpToPage(index);
    // _tabPageController.animateToPage(
    //   index,
    //   duration: Duration(milliseconds: 500),
    //   curve: Curves.ease,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        body: Column(children: [
          Padding(
            padding: EdgeInsets.only(right:  MediaQuery.of(context).size.width/65),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 14,),
              //padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/65),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(width: MediaQuery.of(context).size.width/50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UpperMenuButtons(
                          onTap: (int index) {
                            _selectButton(index);
                          },
                          index: 0,
                          grpIndex: _selectedIndex,
                          heading: "Employment"),
                      UpperMenuButtons(
                          onTap: (int index) {
                            _selectButton(index);
                          },
                          index: 1,
                          grpIndex: _selectedIndex,
                          heading: "Education"),
                      UpperMenuButtons(
                          onTap: (int index) {
                            _selectButton(index);
                          },
                          index: 2,
                          grpIndex: _selectedIndex,
                          heading: "Reference"),
                      UpperMenuButtons(
                          onTap: (int index) {
                            _selectButton(index);
                          },
                          index: 3,
                          grpIndex: _selectedIndex,
                          heading: "License"),

                     widget.departmentId == 1 ? UpperMenuButtons(
                          onTap: (int index) {
                            _selectButton(index);
                          },
                          index: 4,
                          grpIndex: _selectedIndex,
                          heading: "Clinical Licenses"):Offstage(),
                    ],
                  ),
                  // _selectedIndex == 0
                  //                 ? CustomElevatedButton(
                  //                     icon: Icons.save_alt_outlined,
                  //                     label: "Resume",
                  //                     iconPosition: IconPosition.right,
                  //                     onPressed: () {})
                  //                 : _selectedIndex == 3
                  //                     ? ElevatedButton(
                  //                         onPressed: () {},
                  //                         style: ElevatedButton.styleFrom(
                  //                           backgroundColor: ColorManager.bluebottom,
                  //                           //foregroundColor: Color(0xff1696C8),
                  //                           side: BorderSide(color: Color(0xff1696C8)),
                  //                           shape: RoundedRectangleBorder(
                  //                             borderRadius: BorderRadius.circular(8),
                  //                           ),
                  //                         ),
                  //                         child: Row(
                  //                           mainAxisSize: MainAxisSize.min,
                  //                           children: [
                  //                             Text(
                  //                               "Li-censure",
                  //                               style: GoogleFonts.firaSans(
                  //                                 fontSize: 10.0,
                  //                                 fontWeight: FontWeight.w700,
                  //                                 color: ColorManager.white
                  //                               ),
                  //                             ),
                  //                             SizedBox(width: 6.0),
                  //                             Icon(
                  //                               Icons.file_copy,
                  //                               size: 16.0,
                  //                               color: ColorManager.white,
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       )
                  //                     : SizedBox(width: 100,),
                            ],
                          ),
                        ),
          ),
          Expanded(
            flex: 1,
            child: NonScrollablePageView(
              controller: _tabPageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                  // documentTypeGet(context);
                });
              },
              children:  [
                OnBoardingQualificationEmployment(employeeId: widget.employeeId,),
                              OnBoardingQualificationEducation(employeeId: widget.employeeId,),
                              OnBoardingQualificationReference(employeeId: widget.employeeId,),
                              OnBoardingQualificationLicense(employeeId: widget.employeeId,),
               widget.departmentId == 1? OnBoardingQualificationGeneralLicenses(employeeId:widget.employeeId):Offstage()
              ],
            ),
          ),

        ]));
  }
}
