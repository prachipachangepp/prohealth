import 'package:flutter/material.dart';

import '../../../../../../app/resources/value_manager.dart';
import '../em_dashboard_const.dart';

class OfficeLocationScreen extends StatelessWidget {
  const OfficeLocationScreen({super.key});

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
                flex: 3,
                child: EMDashboardContainerConst(
                    height: 500,
                    child: Container())),
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
          SizedBox(height: AppSize.s30,),
        ],),),
    );
  }
}
