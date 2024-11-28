import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import '../em_dashboard_const.dart';

class OfficeClinicianScreen extends StatelessWidget {
  const OfficeClinicianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p14
      ),
      child: Column(children: [
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
        Row(children: [
         Expanded(
              flex: 4,
              child: EMDashboardContainerConst(child: Container())),
          SizedBox(width: AppSize.s15,),
          Expanded(
              flex: 6,
              child: EMDashboardContainerConst(child: Container())),
        ],),
        SizedBox(height: AppSize.s15,),
        ///3rd row
        Row(children: [
          Expanded(
              flex: 4,
              child: EMDashboardContainerConst(child: Container())),
          SizedBox(width: AppSize.s15,),
          Expanded(
              flex: 4,
              child: EMDashboardContainerConst(child: Container())),
        ],),
        SizedBox(height: AppSize.s15,),
        ///4th row
        Row(children: [
          Expanded(
              flex: 2,
              child: EMDashboardContainerConst(child: Container())),
          SizedBox(width: AppSize.s15,),
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
      ],),),
    );
  }
}
