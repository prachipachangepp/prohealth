import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/acknowledgement.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/banking_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/genaral_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/health_record_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/qualification_tab.dart';

import '../../../../../app/resources/const_string.dart';
import '../../../widgets/widgets/profile_bar/profile_bar.dart';
import '../manage/controller/controller.dart';
import 'onboarding_tab_bar_const.dart';


///prachi
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      /// green blue container
      ProfileBar(),
      SizedBox(
        height: MediaQuery.of(context).size.width / 88,
      ),
      OnboardingTabBar(OnboardingController(tabs: [
        Tab(text: AppString.general),
        Tab(text: AppString.qualification),
        Tab(text: AppString.banking),
        Tab(text: AppString.healthRecord),
        Tab(text: AppString.acknowledgement)
      ], tabViews: [
        OnboardingGeneral(),
        OnboardingQualification(),
        Banking(),
        HealthRecordTab(),
        AcknowledgementTab()
      ]))
    ]);
  }
}
