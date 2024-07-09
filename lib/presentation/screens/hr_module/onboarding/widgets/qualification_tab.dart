import 'package:flutter/material.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../manage/controller/controller.dart';
import '../qualification_const_bar/qualification_tabbar_const.dart';
import '../qualification_const_bar/widgets/onboarding_qualification.dart';

/// to do saloni
class OnboardingQualification extends StatefulWidget {
  late QualificationTabBarController controller;
  @override
  State<OnboardingQualification> createState() =>
      _OnboardingQualificationState();
}

class _OnboardingQualificationState extends State<OnboardingQualification> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QualificationTabarConstant(QualificationTabBarController(tabs: [
          Tab(text: AppString.employment),
          Tab(text: AppString.education),
          Tab(text: AppString.referance),
          Tab(text:AppString.license),
        ], tabViews: [
          OnBoardingQualificationEmployment(),
          OnBoardingQualificationEducation(),
          OnBoardingQualificationReference(),
          OnBoardingQualificationLicense(),
        ])),
      ],
    );
  }
}
// EmploymentContainerConstant(),
