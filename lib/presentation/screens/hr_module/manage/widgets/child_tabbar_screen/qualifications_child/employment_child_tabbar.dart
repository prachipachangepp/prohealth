import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/add_employee_popup_const.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../icon_button_constant.dart';
import '../../row_container_widget_const.dart';

///done by saloni
class EmploymentContainerConstant extends StatefulWidget {
  @override
  State<EmploymentContainerConstant> createState() => _EmploymentContainerConstantState();
}

class _EmploymentContainerConstantState extends State<EmploymentContainerConstant> {
  @override
  Widget build(BuildContext context) {
    return WrapWidget(
        childern:List.generate(2, (index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
            child: Container(
              width: MediaQuery.of(context).size.width/2.5,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              height: 200,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 80,
                  vertical: MediaQuery.of(context).size.height / 120,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Employment #1',
                      style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 13,
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w500,
                      ),),
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
                        Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height/6,),
                            IconButtonWidget(
                                iconData: Icons.edit_outlined,
                                buttonText: 'Edit',
                                onPressed: () {
                                  setState(() {
                                    showDialog(context: context, builder: (BuildContext context){
                                      return CustomPopupConst();
                                    });
                                  });


                                }),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        })
        );


  }
}