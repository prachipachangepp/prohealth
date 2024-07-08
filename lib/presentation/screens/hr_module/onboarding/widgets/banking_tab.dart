import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/widgets/banking_tab_constant.dart';

import '../../../../../../app/resources/value_manager.dart';
import '../../manage/widgets/child_tabbar_screen/qualifications_child/employment_child_tabbar.dart';

///prachi
class Banking extends StatelessWidget {
  const Banking({Key? key}) : super(key: key);

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
                      // EmploymentContainerConstant(),
                      BankingTabContainerConstant(),
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
