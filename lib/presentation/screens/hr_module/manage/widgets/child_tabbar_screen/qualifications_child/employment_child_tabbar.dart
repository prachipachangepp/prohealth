import 'package:flutter/material.dart';
import 'package:prohealth/app/theme_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/icon_button_constant.dart';

class EmploymentContainerConstant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ConstantWidget(),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              height: 200, // Adjust height as needed
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 50,
                    vertical: MediaQuery.of(context).size.width / 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Employment #1',
                          style: TextStyle(
                            fontFamily: 'FiraSans',
                            fontSize: 13,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Final Position Title',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Start Date',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('End Date',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Employer',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Emergency Contact',
                            style: ThemeManager.customTextStyle(context)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(''),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Personal',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Jerry Christ',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'T4541564214',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Hamburg',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Germany',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(''),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Reason of Leaving',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Last Supervisor’s Name',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('SuperVisor\'s Phone No.',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('City',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Country',
                            style: ThemeManager.customTextStyle(context)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(''),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Developer',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '01-03-24',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '22-03-24',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'John Smith',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '9845632156',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 120.0),
                      child: IconButtonWidget(
                          iconData: Icons.edit,
                          buttonText: 'Edit',
                          onPressed: () {}),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 50),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              height: 200,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 50,
                    vertical: MediaQuery.of(context).size.width / 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Employment #2',
                          style: TextStyle(
                            fontFamily: 'FiraSans',
                            fontSize: 13,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Final Position Title',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Start Date',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('End Date',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Employer',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Emergency Contact',
                            style: ThemeManager.customTextStyle(context)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(''),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Personal',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Jerry Christ',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'T4541564214',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Hamburg',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Germany',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(''),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Reason of Leaving',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Last Supervisor’s Name',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('SuoerVisor\'s Phone No.',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('City',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Country',
                            style: ThemeManager.customTextStyle(context)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(''),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Developer',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '01-03-24',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '22-03-24',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'John Smith',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '9845632156',
                          style: ThemeManagerDark.customTextStyle(context),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 120.0),
                      child: IconButtonWidget(
                          iconData: Icons.edit,
                          buttonText: 'Edit',
                          onPressed: () {}),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
