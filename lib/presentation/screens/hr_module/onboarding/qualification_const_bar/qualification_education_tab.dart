import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/qualificatin_emloyment_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/qualification_license_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/qualification_referance_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/widgets/qualification_education.dart';
import '../../../../../../app/resources/value_manager.dart';

class OnBoardingQualificationEmployment extends StatelessWidget {
  const OnBoardingQualificationEmployment({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [
              QualificationEmployment(),
              SizedBox(
                height: AppSize.s8,
              )
            ],
          );
        });
  }
}


class OnBoardingQualificationEducation extends StatelessWidget {
  const OnBoardingQualificationEducation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [
              QualificationEducation(),
              SizedBox(
                height: AppSize.s8,
              )
            ],
          );
        });
  }
}

class OnBoardingQualificationReference extends StatelessWidget {
  const OnBoardingQualificationReference({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [
              QualificationReferance(),
              SizedBox(
                height: AppSize.s8,
              )
            ],
          );
        });
  }
}

class OnBoardingQualificationLicense extends StatelessWidget {
  const OnBoardingQualificationLicense({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [
              QualificationLicense(),
              SizedBox(
                height: AppSize.s8,
              )
            ],
          );
        });
  }
}



