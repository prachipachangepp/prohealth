import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/widgets/constant_employment.dart';

import '../../../../../app/resources/value_manager.dart';


class QualificationEmployment extends StatelessWidget {
  const QualificationEmployment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      OnboardingEmployement(),
                      SizedBox(
                        height: AppSize.s8,
                      )
                    ],
                  );
                }))
      ],
    );
  }
}
