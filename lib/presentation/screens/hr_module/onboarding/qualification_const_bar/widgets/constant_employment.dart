import 'package:flutter/material.dart';
import 'package:prohealth/app/theme_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/row_container_widget_const.dart';

class OnboardingEmployement extends StatelessWidget {
  const OnboardingEmployement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 80,
            vertical: MediaQuery.of(context).size.height / 100),
        child: TwoContainersRow(
          child1: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text(
                    'Employment #1',
                    style: TextStyle(
                      fontFamily: 'FiraSans',
                      fontSize: 13,
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Final Position Title',
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Start Date',
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('End Date',
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Employer',
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Emergency Contact',
                          style: ThemeManager.customTextStyle(context)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Developer',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '01-03-24',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '22-03-24',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'John Smith',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '9845632156',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Reason of Leaving',
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Last Supervisor’s Name',
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('SuperVisor\'s Phone No.',
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('City',
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Country',
                          style: ThemeManager.customTextStyle(context)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Jerry Christ',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'T4541564214',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Hamburg',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Germany',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButtonTransparent(
                      onPressed: () {},
                      text: 'Reject',
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 99,
                    ),
                    CustomIconButton(text: 'Approve', onPressed: () {}),
                  ],
                ),
              )
            ],
          ),
          child2: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text(
                    'Employment #2',
                    style: TextStyle(
                      fontFamily: 'FiraSans',
                      fontSize: 13,
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Final Position Title',
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Start Date',
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('End Date',
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Employer',
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Emergency Contact',
                          style: ThemeManager.customTextStyle(context)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Developer',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '01-03-24',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '22-03-24',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'John Smith',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '9845632156',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Reason of Leaving',
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Last Supervisor’s Name',
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('SuperVisor\'s Phone No.',
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('City',
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Country',
                          style: ThemeManager.customTextStyle(context)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Jerry Christ',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'T4541564214',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Hamburg',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Germany',
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButtonTransparent(
                      onPressed: () {},
                      text: 'Reject',
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 99,
                    ),
                    CustomIconButton(text: 'Approve', onPressed: () {}),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
