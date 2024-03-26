import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/controller/controller.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/qualificatin_emloyment_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/qualification_education_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/qualification_license_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/qualification_referance_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/qualification_tabbar_const.dart';

/// to do prachi
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
          Tab(text: 'Employment'),
          Tab(text: 'Education'),
          Tab(text: 'Referance'),
          Tab(text: 'License'),
        ], tabViews: [
          QualificationEmployment(),
          QualificationEducation(),
          QualificationLicense(),
          QualificationReferance(),
        ])),
      ],
    );
  }
}
// EmploymentContainerConstant(),
