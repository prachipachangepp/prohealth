import 'package:flutter/material.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../em_dashboard_const.dart';
///row1 col 1
class GeneralSettingConst extends StatelessWidget {
  const GeneralSettingConst({super.key});

  @override
  Widget build(BuildContext context) {
    return  EMDashboardContainerConst(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello',style: CustomTextStylesCommon.commonStyle(fontSize: 23,
                        color:ColorManager.bluebottom,fontWeight: FontWeight.w700),),
                    Text('"Empower Your Privacy with Precision Settings"',
                      style: CustomTextStylesCommon.commonStyle(fontSize: 14,
                          color: ColorManager.mediumgrey,fontWeight: FontWeight.w400),),
                  ],),
                SizedBox(width: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(child: Image.asset("images/em_dashboard/em_general_pic.png",fit: BoxFit.contain,)),
                  ],
                )
              ]),
        ));
  }
}

///row 1 col 2
class UserRoleDistribution extends StatelessWidget {
  const UserRoleDistribution({super.key});

  @override
  Widget build(BuildContext context) {
    return  EMDashboardAllBlueSideContainer(
        height: 150,
        child: Container());
  }
}
