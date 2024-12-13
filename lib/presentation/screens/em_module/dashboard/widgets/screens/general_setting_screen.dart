import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/common_resources/em_dashboard_theme.dart';
import 'package:prohealth/app/resources/establishment_resources/em_dashboard_string_manager.dart';
import 'package:prohealth/presentation/screens/em_module/dashboard/widgets/screens/widgets/general_setting_const.dart';
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
                  SizedBox(height: AppSize.s20,),
                  ///border blue big container row 2
                  EMDashboardAllBlueSideContainer(
                      height: AppSize.s100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                  width: AppSize.s50,
                                  height: AppSize.s50,
                                  color: ColorManager.bluebottom,
                                  child: Icon(Icons.lock_clock,color: ColorManager.white,size: IconSize.I24,)
                                // Image.asset(
                                //   imageTile, // Replace with your image path
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                            ),
                            SizedBox(width: AppSize.s20,),
                            Text( EmDashboardStringManager.userPassExp ,
                              style: EmDashText.customTextStyle(context),),
                          ],
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(EmDashboardStringManager.expDays,
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
                          height: AppSize.s100,
                          child: BlueBorderContainerConst(imageTile: Icons.calendar_today_outlined,
                            headText: EmDashboardStringManager.systemUpdate, numberText: '', bottomText: '',)),
                    ),
                    SizedBox(width: AppSize.s30,),
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: AppSize.s100,
                          child: BlueBorderContainerConst(imageTile: Icons.error_outline,
                            headText: EmDashboardStringManager.systemError, numberText: '12', bottomText: 'Last 24 hours',)),
                    ),
                  ],),
                  SizedBox(height: AppSize.s10,),
                  Row(children: [
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: AppSize.s100,
                          child: BlueBorderContainerConst(imageTile: Icons.history_outlined,
                            headText: EmDashboardStringManager.NoDataDelet, numberText: '12', bottomText: '',) ),
                    ),
                    SizedBox(width: AppSize.s30,),
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: AppSize.s100,
                          child: BlueBorderContainerConst(imageTile: Icons.arrow_circle_right_outlined,
                            headText: EmDashboardStringManager.failedLoginAttempt, numberText: '  02', bottomText: 'Last 24 hours',)),
                    ),
                  ],),
                  SizedBox(height: AppSize.s10,),
                  Row(children: [
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: AppSize.s100,
                          child: BlueBorderContainerConst(imageTile: Icons.shield_moon_outlined,
                            headText: EmDashboardStringManager.multiAuthenticate, numberText: '12       ', bottomText: '',)),
                    ),
                    SizedBox(width: AppSize.s30,),
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: AppSize.s100,
                          child: BlueBorderContainerConst(imageTile: Icons.personal_injury_outlined,
                            headText: EmDashboardStringManager.ActiveUsers, numberText: '26', bottomText: '',),)
                    ),
                  ],),
                  SizedBox(height: AppSize.s10,),
                  Row(children: [
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: AppSize.s100,
                          child: BlueBorderContainerConst(imageTile: Icons.stacked_line_chart_outlined,
                            headText: EmDashboardStringManager.ActiveUsersSecurity, numberText: '12  ', bottomText: '',),)
                    ),
                    SizedBox(width: AppSize.s30,),
                    Expanded(
                      child: EMDashboardAllBlueSideContainer(
                          height: AppSize.s100,
                          child: BlueBorderContainerConst(imageTile: Icons.calendar_today_outlined,
                            headText: EmDashboardStringManager.lastSoftUpdate, numberText: '', bottomText: 'Last updated on 14/11/2024',)),
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
                    SizedBox(height: AppSize.s20,),
                    Container(
                      height: AppSize.s550,
                      padding: EdgeInsets.all(AppPadding.p10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
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
                          SizedBox(height: AppSize.s10,),
                          Text(EmDashboardStringManager.encryptionKey,
                          style: CustomTextStylesCommon.commonStyle(fontSize: 24,
                              color:ColorManager.mediumgrey,fontWeight: FontWeight.w700),),
                          Stack(
                            alignment: Alignment.center,
                            children:[
                              Container(
                              //width: 450,
                              height: AppSize.s450,
                              child: PieChart(
                                PieChartData(
                                  sections: [
                                    PieChartSectionData(
                                      color: ColorManager.blueKeyGraph,
                                      value: 30,
                                      title: "",
                                      badgeWidget: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '01\n',
                                              style: GeneralSettingNumStyle.customTextStyle(context),
                                            ),
                                            TextSpan(
                                              text: 'Generation', // Remaining text
                                              style: GeneralSettingTextStyle.customTextStyle(context),
                                            ),
                                          ],
                                        ),
                                      ),
                                      radius: 100, // Adjust the radius if needed
                                    ),
                                    PieChartSectionData(
                                      color: ColorManager.blueKeyGraph,
                                      value: 30,
                                      title: "",
                                      badgeWidget: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '02\n',
                                              style: GeneralSettingNumStyle.customTextStyle(context),
                                            ),
                                            TextSpan(
                                              text: 'Distribution',
                                              style: GeneralSettingTextStyle.customTextStyle(context),
                                            ),
                                          ],
                                        ),
                                      ),
                                      radius: 100, // Adjust the radius as required
                                    ),
                                    PieChartSectionData(
                                      color: ColorManager.blueKeyGraph,
                                      value: 30,
                                      title: "",
                                      badgeWidget: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '03\n',
                                              style: GeneralSettingNumStyle.customTextStyle(context),
                                            ),
                                            TextSpan(
                                              text: 'Use',
                                              style: GeneralSettingTextStyle.customTextStyle(context),
                                            ),
                                          ],
                                        ),
                                      ),
                                      radius: 100, // Adjust the radius as required
                                    ),
                                    PieChartSectionData(
                                      color: ColorManager.blueKeyGraph,
                                      value: 30,
                                      title: "",
                                      badgeWidget: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '04\n',
                                              style: GeneralSettingNumStyle.customTextStyle(context),
                                            ),
                                            TextSpan(
                                              text: 'Storage',
                                              style: GeneralSettingTextStyle.customTextStyle(context),
                                            ),
                                          ],
                                        ),
                                      ),
                                      radius: 100, // Adjust the radius as required
                                    ),
                                    PieChartSectionData(
                                      color: ColorManager.blueKeyGraph,
                                      value: 30,
                                      title: "",
                                      badgeWidget: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '05\n',
                                              style: GeneralSettingNumStyle.customTextStyle(context),
                                            ),
                                            TextSpan(
                                              text: 'Rotation',
                                              style: GeneralSettingTextStyle.customTextStyle(context),
                                            ),
                                          ],
                                        ),
                                      ),
                                      radius: 100, // Adjust the radius as required
                                    ),
                                    PieChartSectionData(
                                      color: ColorManager.blueKeyGraph,
                                      value: 30,
                                      title: "",
                                      badgeWidget: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '06\n',
                                              style: GeneralSettingNumStyle.customTextStyle(context),
                                            ),
                                            TextSpan(
                                              text: 'Backup /\nRecovery',
                                              style: GeneralSettingTextStyle.customTextStyle(context),
                                            ),
                                          ],
                                        ),
                                      ),
                                      radius: 100, // Adjust the radius as required
                                    ),
                                    PieChartSectionData(
                                      color: ColorManager.blueKeyGraph,
                                      value: 30,
                                      title: "",
                                      badgeWidget: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '07\n',
                                              style: GeneralSettingNumStyle.customTextStyle(context),
                                            ),
                                            TextSpan(
                                              text: 'Revocation',
                                              style: GeneralSettingTextStyle.customTextStyle(context),
                                            ),
                                          ],
                                        ),
                                      ),
                                      radius: 100, // Adjust the radius as required
                                    ),
                                  ],
                                  centerSpaceRadius: 100,
                                  centerSpaceColor: Colors.white,
                                  sectionsSpace: 5,
                                  borderData: FlBorderData(show: true),
                                  startDegreeOffset: -90,
                                ),
                              ),
                            ),
                              Positioned(
                                  child: Container(
                                    width: AppSize.s80,
                                    height: AppSize.s80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage('images/em_dashboard/dashboard_key.png'), // Replace with your image path
                                        fit: BoxFit.contain,
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
