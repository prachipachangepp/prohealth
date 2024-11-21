import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/hr_resources/hr_theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/dashboard/widgets/em_dashboard_const.dart';
import 'package:prohealth/presentation/screens/em_module/dashboard/widgets/screens/widget/const_linear_widget.dart';

class ContractDocAuditingScreen extends StatelessWidget {
  const ContractDocAuditingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
        child: Column(
          children: [
            ///first row
            Row(
              mainAxisAlignment:MainAxisAlignment.start,
              children: [
              Expanded(
                  flex: 4,
                  child: EMDashboardContainerConst(height: 150,child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hello',style: TextStyle(fontSize: 25,color: ColorManager.blueprime),),
                              SizedBox(height: 20,),
                              Text("Securing Your Success,\nOne Document at a Time.",style: GraphHeadingHRDashboard.customTextStyle(context),)
                            ],
                          ),
                          CircleAvatar(
                            radius: 30,
                          )
                        ],
                      ),
                    ),
                  ),)),
              SizedBox(width: AppSize.s15,),
              Expanded(
                  flex: 2,
                  child: EMDashboardContainerBBorderConst(child: Container(
                    child: LinearCardWidget(headingText: 'Total Number Of Active\nContracts', totalCount: '12', totalValue: 12,),
                  ),)),
              SizedBox(width: AppSize.s15,),
              Expanded(
                  flex: 2,
                  child: EMDashboardContainerBBorderConst(child: Container(
                    child: LinearCardWidget(headingText: 'Number Of Random\nAufits Passed', totalCount: '20', totalValue: 20,),
                  ),)),
              SizedBox(width: AppSize.s15,),
              Expanded(
                  flex: 2,
                  child: EMDashboardContainerBBorderConst(child: Container(
                    child: LinearCardWidget(headingText: 'Number of Non-Compliant\nOffices', totalCount: '02', totalValue: 2,),
                  ),)),
            ],),
            SizedBox(height: AppSize.s15,),
            ///2nd row
            Row(
              children: [
                Expanded(
                    flex: 4,
                    child: EMDashboardAllBlueSideContainer(child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          children:[
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  child: Icon(Icons.file_copy_outlined,color: ColorManager.white,),
                                ),
                                SizedBox(width: 20,),
                                Text("Contracts Expring Soon",style: TextStyle(fontSize: 14,fontWeight:FontWeight.w500,color: ColorManager.mediumgrey,),),
                              ],
                            ),
                            Text("Next 30 Days",style: TextStyle(fontSize: 12,color: ColorManager.red),),
                          ]
                        ),
                      )
                    ),)),
                SizedBox(width: AppSize.s15,),
                Expanded(
                    flex: 2,
                    child: EMDashboardContainerBBorderConst(child: Container(
                      child: LinearCardWidget(headingText: 'Audit Penalty Amounts', totalCount: '\$1000', totalValue: 80,),
                    ),)),
                SizedBox(width: AppSize.s15,),
                Expanded(
                    flex: 2,
                    child: EMDashboardContainerBBorderConst(child: Container(
                      child: LinearCardWidget(headingText: 'Compliance Incident\nReporting Rate', totalCount: '04', totalValue: 30,),
                    ),)),
                SizedBox(width: AppSize.s15,),
                Expanded(
                    flex: 2,
                    child: EMDashboardContainerBBorderConst(child: Container(
                      child: LinearCardWidget(headingText: 'Number Of Government\nAudits Passed', totalCount: '20', totalValue: 20,),
                    ),)),
              ],),
            SizedBox(height: AppSize.s15,),
            ///3rd row
            Row(children: [
              Expanded(
                flex: 2,
                  child: EMDashboardContainerConst(child: Container())),
              SizedBox(width: AppSize.s15,),
              Expanded(
                  flex: 4,
                  child: EMDashboardContainerConst(child: Container())),
              SizedBox(width: AppSize.s15,),
              Expanded(
                  flex: 3,
                  child: EMDashboardContainerConst(child: Container())),
            ],),
            SizedBox(height: AppSize.s15,),
            ///4th row
            Row(children: [
              Expanded(
                  flex: 3,
                  child: EMDashboardContainerConst(child: Container())),
              SizedBox(width: AppSize.s15,),
              Expanded(
                  flex: 3,
                  child: EMDashboardContainerConst(child: Container())),
              SizedBox(width: AppSize.s15,),
              Expanded(
                  flex: 2,
                  child: EMDashboardContainerConst(child: Container())),
            ],),
            SizedBox(height: AppSize.s15,),
            ///5th row
            Row(children: [
              Expanded(
                  flex: 4,
                  child: EMDashboardContainerConst(
                    height: 500,
                    child: Container(),)),
              SizedBox(width: AppSize.s15,),
              Expanded(
                flex: 3,
                child: Column(children: [
                  EMDashboardContainerConst(
                      height: 240,
                      child: Container()),
                  SizedBox(height: AppPadding.p20,),
                  EMDashboardContainerConst(
                      height: 240,
                      child: Container()),
                ],),
              )
            ],),
            SizedBox(height: AppSize.s15,),
            ///6th row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p50),
              child: Row(children: [
                Expanded(flex: 3,child: EMDashboardContainerConst(child: Container(),)),
                SizedBox(width: AppPadding.p20,),
                Expanded(flex: 5,child: EMDashboardContainerConst(child: Container(),)),
              ],),
            ),
            SizedBox(height: AppSize.s15,),
          ],
        ),
      ),
    );
  }
}
