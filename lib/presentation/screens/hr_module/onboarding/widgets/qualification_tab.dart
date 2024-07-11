import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/widgets/banking_tab_constant.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../em_module/company_identity/company_identity_screen.dart';
import '../../manage/controller/controller.dart';
import '../qualification_const_bar/widgets/onboarding_qualification.dart';

/// to do saloni
class OnboardingQualification extends StatefulWidget {
  late QualificationTabBarController controller;
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
    _tabPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(width: 50,),
              ///tabbar
              Container(
                //color: Colors.greenAccent,
                width: MediaQuery.of(context).size.width / 3,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => _selectButton(0),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 20,
                        child: Column(
                          children: [
                            Text(
                              "Employment",
                              style: GoogleFonts.firaSans(
                                fontSize: 12,
                                fontWeight: _selectedIndex == 0
                                    ? FontWeightManager.bold
                                    : FontWeightManager.regular,
                                color: _selectedIndex == 0
                                    ? ColorManager.blueprime
                                    : ColorManager.mediumgrey,
                              ),
                            ),
                            _selectedIndex == 0
                                ? Divider(
                                    color: ColorManager.blueprime,
                                    thickness: 4,
                                  )
                                : Offstage()
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => _selectButton(1),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 20, //80,
                        child: Column(
                          children: [
                            Text(
                              "Education",
                              style: GoogleFonts.firaSans(
                                fontSize: 12,
                                fontWeight: _selectedIndex == 1
                                    ? FontWeightManager.bold
                                    : FontWeightManager.regular,
                                color: _selectedIndex == 1
                                    ? ColorManager.blueprime
                                    : ColorManager.mediumgrey,
                              ),
                            ),
                            _selectedIndex == 1
                                ? Divider(
                                    color: ColorManager.blueprime,
                                    thickness: 4,
                                  )
                                : Offstage()
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => _selectButton(2),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 20, // 80,
                        child: Column(
                          children: [
                            Expanded(
                              child: Text(
                                "Reference",
                                style: GoogleFonts.firaSans(
                                  fontSize: 12,
                                  fontWeight: _selectedIndex == 2
                                      ? FontWeightManager.bold
                                      : FontWeightManager.regular,
                                  color: _selectedIndex == 2
                                      ? ColorManager.blueprime
                                      : ColorManager.mediumgrey,
                                ),
                              ),
                            ),
                            _selectedIndex == 2
                                ? Divider(
                                    color: ColorManager.blueprime,
                                    thickness: 4,
                                  )
                                : Offstage()
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => _selectButton(3),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 20, // 80,
                        child: Column(
                          children: [
                            Expanded(
                              child: Text(
                                "License",
                                style: GoogleFonts.firaSans(
                                  fontSize: 12,
                                  fontWeight: _selectedIndex == 3
                                      ? FontWeightManager.bold
                                      : FontWeightManager.regular,
                                  color: _selectedIndex == 3
                                      ? ColorManager.blueprime
                                      : ColorManager.mediumgrey,
                                ),
                              ),
                            ),
                            _selectedIndex == 3
                                ? Divider(
                                    color: ColorManager.blueprime,
                                    thickness: 4,
                                  )
                                : Offstage()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ///button
              _selectedIndex == 0
                  ? CustomElevatedButton(
                      icon: Icons.save_alt_outlined,
                      label: "Resume",
                      iconPosition: IconPosition.right,
                      onPressed: () {})
                  : _selectedIndex == 3
                      ? ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.bluebottom,
                            //foregroundColor: Color(0xff1696C8),
                            side: BorderSide(color: Color(0xff1696C8)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Li-censure",
                                style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w700,
                                  color: ColorManager.white
                                ),
                              ),
                              SizedBox(width: 6.0),
                              Icon(
                                Icons.file_copy,
                                size: 16.0,
                                color: ColorManager.white,
                              ),
                            ],
                          ),
                        )
                      : SizedBox(
                          width: 100,
                        ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 50),
            child: NonScrollablePageView(
              controller: _tabPageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                OnBoardingQualificationEmployment(),
                OnBoardingQualificationEducation(),
                OnBoardingQualificationReference(),
                OnBoardingQualificationLicense(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
