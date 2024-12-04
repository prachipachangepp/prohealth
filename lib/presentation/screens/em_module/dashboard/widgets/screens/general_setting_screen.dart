import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/em_module/dashboard/widgets/screens/widgets/general_setting_const.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/header_content_const.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../em_dashboard_const.dart';

class GeneralSettingScreen extends StatelessWidget {
  const GeneralSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                flex: 4,
                child: Column(children: [
                  ///white first container
                 GeneralSettingConst(),
                  SizedBox(height: 20,),
                  ///border blue big container row 2
                  EMDashboardAllBlueSideContainer(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                  width: 50,
                                  height: 50,
                                  color: ColorManager.bluebottom,
                                  child: Icon(Icons.lock_clock,color: ColorManager.white,size: 24,)
                                // Image.asset(
                                //   imageTile, // Replace with your image path
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Text("User Password Expiry Status" ,
                              style: CustomTextStylesCommon.commonStyle(fontSize: 16,
                                  color: ColorManager.mediumgrey,fontWeight: FontWeight.w400),),
                          ],
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Expire withing 2 days",
                              style: CustomTextStylesCommon.commonStyle(
                                fontSize: FontSize.s10, color: ColorManager.mediumgrey,
                              ),),
                          ],
                        ),
                      ],)),
                  SizedBox(height: AppPadding.p20,),
                  Row(children: [
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: 100,
                          child: BlueBorderContainerConst(imageTile: Icons.calendar_today_outlined,
                            headText: 'System Uptime current month', subText: '', bottomText: '',)),
                    ),
                    SizedBox(width: 30,),
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: 100,
                          child: BlueBorderContainerConst(imageTile: Icons.error_outline,
                            headText: 'System Error Log Entries', subText: '12', bottomText: 'Last 24 hours',)),
                    ),
                  ],),
                  SizedBox(height: AppPadding.p10,),
                  Row(children: [
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: 100,
                          child: BlueBorderContainerConst(imageTile: Icons.history_outlined,
                            headText: 'Number of Data Deletion Requests', subText: '12', bottomText: '',) ),
                    ),
                    SizedBox(width: 30,),
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: 100,
                          child: BlueBorderContainerConst(imageTile: Icons.arrow_circle_right_outlined,
                            headText: 'Failed Login Attempts', subText: '  02', bottomText: 'Last 24 hours',)),
                    ),
                  ],),
                  SizedBox(height: AppPadding.p10,),
                  Row(children: [
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: 100,
                          child: BlueBorderContainerConst(imageTile: Icons.shield_moon_outlined,
                            headText: 'Multi-Factor Authentication Adoption Rate', subText: '12       ', bottomText: '',)),
                    ),
                    SizedBox(width: 30,),
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: 100,
                          child: BlueBorderContainerConst(imageTile: Icons.personal_injury_outlined,
                            headText: 'Number of Active Users', subText: '26', bottomText: '',),)
                    ),
                  ],),
                  SizedBox(height: AppPadding.p10,),
                  Row(children: [
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: 100,
                          child: BlueBorderContainerConst(imageTile: Icons.stacked_line_chart_outlined,
                            headText: 'Number of Active security protocols', subText: '12  ', bottomText: '',),)
                    ),
                    SizedBox(width: 30,),
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: 100,
                          child: BlueBorderContainerConst(imageTile: Icons.calendar_today_outlined,
                            headText: 'Last Software Update', subText: '', bottomText: 'Last updated on 14/11/2024',)),
                    ),
                  ],),
                ],),
              ),
              SizedBox(width: AppSize.s20,),

              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    UserRoleDistribution(),
                    SizedBox(height: 20,),
                    Container(
                      height: 550,
                      padding: EdgeInsets.all(AppPadding.p10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        // border: Border.symmetric(vertical: BorderSide.none,horizontal: BorderSide(width: 1,color: Color(0xFFBCBCBC)),),//all(width: 1, color: Color(0xFFBCBCBC)),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.black.withOpacity(0.2),
                            blurRadius: 6.3,
                            spreadRadius: 0,
                            offset: const Offset(0, 14), // Downward shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Text(" Encryption Key Rotation Schedule ",
                          style: CustomTextStylesCommon.commonStyle(fontSize: 24,
                              color:ColorManager.mediumgrey,fontWeight: FontWeight.w700),),
                          Stack(
                            alignment: Alignment.center,
                            children:[
                              Container(
                              //width: 450,
                              height: 450,
                              child: PieChart(
                                PieChartData(
                                  sections: [
                                    PieChartSectionData(
                                      color: ColorManager.blueKeyGraph,
                                      value: 20,
                                      title: '01\nGeneration',
                                      titleStyle:  TextStyle(
                                          fontSize: 10, fontWeight: FontWeight.bold, color: ColorManager.white),
                                      radius: 100,
                                    ),
                                    PieChartSectionData(
                                      color: ColorManager.blueKeyGraph,
                                      value: 20,
                                      title: '02\nDistribution',
                                      titleStyle:  TextStyle(
                                          fontSize: 10, fontWeight: FontWeight.bold, color: ColorManager.white),
                                      radius: 100,
                                    ),
                                    PieChartSectionData(
                                      color: ColorManager.blueKeyGraph,
                                      value: 20,
                                      title: '03\nUse',
                                      titleStyle:  TextStyle(
                                          fontSize: 10, fontWeight: FontWeight.bold, color: ColorManager.white),
                                      radius: 100,
                                    ),
                                    PieChartSectionData(
                                      color: ColorManager.blueKeyGraph,
                                      value: 20,
                                      title: '04\nStorage',
                                      titleStyle:  TextStyle(
                                          fontSize: 10, fontWeight: FontWeight.bold, color: ColorManager.white),
                                      radius: 100,
                                    ),
                                    PieChartSectionData(
                                      color: ColorManager.blueKeyGraph,
                                      value: 20,
                                      title: '05\nRotation',
                                      titleStyle:  TextStyle(
                                          fontSize: 10, fontWeight: FontWeight.bold, color: ColorManager.white),
                                      radius: 100,
                                    ),
                                    PieChartSectionData(
                                      color: ColorManager.blueKeyGraph,
                                      value: 20,
                                      title: '06\nBackup\nRecovery',
                                      titleStyle:  TextStyle(
                                          fontSize: 10, fontWeight: FontWeight.bold, color: ColorManager.white),
                                      radius: 100,
                                    ),
                                    PieChartSectionData(
                                      color: ColorManager.blueKeyGraph,
                                      value: 20,
                                      title: '07\nRevocation',
                                      titleStyle:  TextStyle(
                                          fontSize: 10, fontWeight: FontWeight.bold, color: ColorManager.white),
                                      radius: 100,
                                    ),

                                  ],
                                  centerSpaceRadius: 100,
                                  centerSpaceColor: Colors.white,
                                  sectionsSpace: 2,
                                  borderData: FlBorderData(show: true),
                                  startDegreeOffset: -90,
                                ),
                              ),
                            ),
                              Positioned(
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage('images/em_dashboard/dashboard_key.png'), // Replace with your image path
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),),
                            ]
                          ),
                        ],
                      ),),
                  ],
                ),
              ),
            ],),
            SizedBox(height: AppSize.s30,),
        ],),
      ),
    );
  }
}
