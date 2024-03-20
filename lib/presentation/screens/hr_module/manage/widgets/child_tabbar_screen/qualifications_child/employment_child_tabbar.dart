import 'package:flutter/material.dart';
import 'package:prohealth/app/theme_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/icon_button_constant.dart';
import '../../row_container_widget_const.dart';

///done by saloni
class EmploymentContainerConstant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width/80,
            vertical: MediaQuery.of(context).size.height/100),
        child: TwoContainersRow(
            child1: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Employment #1',
                          style: TextStyle(
                            fontFamily: 'FiraSans',
                            fontSize: 13,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.bold,
                          ),),
                        SizedBox(height: 10,),
                        Text('Final Position Title',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(height: 7,),
                        Text('Start Date',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(height: 7,),
                        Text('End Date',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(height: 7,),
                        Text('Employer',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(height: 7,),
                        Text('Emergency Contact',
                            style: ThemeManager.customTextStyle(context)),

                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/40,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(''),
                        SizedBox(height: 10,),
                        Text('Developer',
                          style: ThemeManagerDark.customTextStyle(context),),
                        SizedBox(height: 7,),
                        Text('01-03-24',
                          style: ThemeManagerDark.customTextStyle(context),),
                        SizedBox(height: 7,),
                        Text('22-03-24',
                          style: ThemeManagerDark.customTextStyle(context),),
                        SizedBox(height: 7,),
                        Text('John Smith',
                          style: ThemeManagerDark.customTextStyle(context),),
                        SizedBox(height: 7,),
                        Text('9845632156',
                          style: ThemeManagerDark.customTextStyle(context),),
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(''),
                        SizedBox(height: 10,),
                        Text('Reason of Leaving',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(height: 7,),
                        Text('Last Supervisor’s Name',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(height: 7,),
                        Text('SuperVisor\'s Phone No.',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(height: 7,),
                        Text('City',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(height: 7,),
                        Text('Country',
                            style: ThemeManager.customTextStyle(context)),
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/40,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(''),
                        SizedBox(height: 10,),
                        Text('Personal',
                          style: ThemeManagerDark.customTextStyle(context),),
                        SizedBox(height: 7,),
                        Text('Jerry Christ',
                          style: ThemeManagerDark.customTextStyle(context),),
                        SizedBox(height: 7,),
                        Text('T4541564214',
                          style: ThemeManagerDark.customTextStyle(context),),
                        SizedBox(height: 7,),
                        Text('Hamburg',
                          style: ThemeManagerDark.customTextStyle(context),),
                        SizedBox(height: 7,),
                        Text('Germany',
                          style: ThemeManagerDark.customTextStyle(context),),
                      ],
                    ),
                    // SizedBox(width: MediaQuery.of(context).size.width/25,),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 130.0),
                    //   child: IconButtonWidget(
                    //       iconData: Icons.edit,
                    //       buttonText: 'Edit',
                    //       onPressed: (){}),
                    // )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButtonWidget(
                        iconData: Icons.edit,
                        buttonText: 'Edit',
                        onPressed: (){}),
                  ],
                )
              ],
            ),
            child2: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Employment #2',
                          style: TextStyle(
                            fontFamily: 'FiraSans',
                            fontSize: 13,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.bold,
                          ),),
                        SizedBox(height: 10,),
                        Text('Final Position Title',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(height: 7,),
                        Text('Start Date',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(height: 7,),
                        Text('End Date',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(height: 7,),
                        Text('Employer',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(height: 7,),
                        Text('Emergency Contact',
                            style: ThemeManager.customTextStyle(context)),

                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/40,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(''),
                        SizedBox(height: 10,),
                        Text('Developer',
                          style: ThemeManagerDark.customTextStyle(context),),
                        SizedBox(height: 7,),
                        Text('01-03-24',
                          style: ThemeManagerDark.customTextStyle(context),),
                        SizedBox(height: 7,),
                        Text('22-03-24',
                          style: ThemeManagerDark.customTextStyle(context),),
                        SizedBox(height: 7,),
                        Text('John Smith',
                          style: ThemeManagerDark.customTextStyle(context),),
                        SizedBox(height: 7,),
                        Text('9845632156',
                          style: ThemeManagerDark.customTextStyle(context),),
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(''),
                        SizedBox(height: 10,),
                        Text('Reason of Leaving',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(height: 7,),
                        Text('Last Supervisor’s Name',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(height: 7,),
                        Text('SuperVisor\'s Phone No.',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(height: 7,),
                        Text('City',
                            style: ThemeManager.customTextStyle(context)),
                        SizedBox(height: 7,),
                        Text('Country',
                            style: ThemeManager.customTextStyle(context)),
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/40,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(''),
                        SizedBox(height: 10,),
                        Text('Personal',
                          style: ThemeManagerDark.customTextStyle(context),),
                        SizedBox(height: 7,),
                        Text('Jerry Christ',
                          style: ThemeManagerDark.customTextStyle(context),),
                        SizedBox(height: 7,),
                        Text('T4541564214',
                          style: ThemeManagerDark.customTextStyle(context),),
                        SizedBox(height: 7,),
                        Text('Hamburg',
                          style: ThemeManagerDark.customTextStyle(context),),
                        SizedBox(height: 7,),
                        Text('Germany',
                          style: ThemeManagerDark.customTextStyle(context),),
                      ],
                    ),
                    // SizedBox(width: MediaQuery.of(context).size.width/25,),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 130.0),
                    //   child: IconButtonWidget(
                    //       iconData: Icons.edit,
                    //       buttonText: 'Edit',
                    //       onPressed: (){}),
                    // )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButtonWidget(
                        iconData: Icons.edit,
                        buttonText: 'Edit',
                        onPressed: (){}),
                  ],
                )
              ],
            ))
    );
  }
}