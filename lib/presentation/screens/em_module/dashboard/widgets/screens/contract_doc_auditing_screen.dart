import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/dashboard/widgets/em_dashboard_const.dart';

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
                  child: EMDashboardContainerConst(height: 150,child: Container(),)),
              SizedBox(width: AppSize.s15,),
              Expanded(
                  flex: 2,
                  child: EMDashboardContainerBBorderConst(child: Container(),)),
              SizedBox(width: AppSize.s15,),
              Expanded(
                  flex: 2,
                  child: EMDashboardContainerBBorderConst(child: Container(),)),
              SizedBox(width: AppSize.s15,),
              Expanded(
                  flex: 2,
                  child: EMDashboardContainerBBorderConst(child: Container(),)),
            ],),
            SizedBox(height: AppSize.s15,),
            ///2nd row
            Row(
              children: [
                Expanded(
                    flex: 4,
                    child: EMDashboardAllBlueSideContainer(child: Container(),)),
                SizedBox(width: AppSize.s15,),
                Expanded(
                    flex: 2,
                    child: EMDashboardContainerBBorderConst(child: Container(),)),
                SizedBox(width: AppSize.s15,),
                Expanded(
                    flex: 2,
                    child: EMDashboardContainerBBorderConst(child: Container(),)),
                SizedBox(width: AppSize.s15,),
                Expanded(
                    flex: 2,
                    child: EMDashboardContainerBBorderConst(child: Container(),)),
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
