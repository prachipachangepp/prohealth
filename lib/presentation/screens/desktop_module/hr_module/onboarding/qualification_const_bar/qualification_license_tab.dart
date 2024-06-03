import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/desktop_module/hr_module/onboarding/qualification_const_bar/widgets/constant_employment.dart';

class QualificationLicense extends StatelessWidget {
  const QualificationLicense({Key? key}) : super(key: key);

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
                    ],
                  );
                }))
      ],
    );
  }
}
