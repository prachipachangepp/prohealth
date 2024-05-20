import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/desktop_module/hr_module/onboarding/qualification_const_bar/widgets/constant_employment.dart';

import '../../../../../../app/resources/value_manager.dart';

class QualificationReferance extends StatelessWidget {
  const QualificationReferance({Key? key}) : super(key: key);

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
