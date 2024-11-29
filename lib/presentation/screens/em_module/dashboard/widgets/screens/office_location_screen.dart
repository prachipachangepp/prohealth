import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prohealth/presentation/screens/em_module/dashboard/widgets/screens/widgets/const_linear_widget.dart';
import 'package:prohealth/presentation/screens/em_module/dashboard/widgets/screens/widgets/office_location_const.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
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
                  child: OfficeLocationConst()),
              SizedBox(width: AppSize.s15,),
              Expanded(
                  flex: 2,
                  child: EMDashboardContainerBBorderConst(
                    child: LinearCardWidget(headingText: 'Total Number Of Office', totalCount: '10', totalValue: 10,icon: CupertinoIcons.building_2_fill,),)),
              SizedBox(width: AppSize.s15,),
              Expanded(
                  flex: 2,
                  child: EMDashboardContainerBBorderConst(
                    child: LinearCardWidget(headingText: 'Office Occupancy rate', totalCount: '4', totalValue:4,icon: FontAwesomeIcons.userDoctor,),)),
              SizedBox(width: AppSize.s15,),
              Expanded(
                  flex: 2,
                  child: EMDashboardContainerBBorderConst(
                    child: LinearCardWidget(headingText: 'Average Daily Attendance\nper Office', totalCount: '100%', totalValue: 100,icon: Icons.calendar_today_outlined,),)),
            ],),
          SizedBox(height: AppSize.s15,),
          ///2nd row
          Row(children: [
            Expanded(
                flex: 3,
                child: EMDashboardContainerConst(
                    height: 600,
                    child: Container())),
            SizedBox(width: AppSize.s15,),
            Expanded(
              flex: 3,
              child: Column(children: [
                ///listview
                EMDashboardContainerBBorderConst(
                    height: 240,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Office Equipment Inventory',style: CustomTextStylesCommon.commonStyle(
                                color: ColorManager.mediumgrey,
                                fontSize: FontSize.s16,
                                fontWeight: FontWeight.w700)),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "View More",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: FontSize.s12,
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.bluebottom,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],),
                        SizedBox(height: 10,),
                        OfficeEquipmentHead(),
                        OfficeEquipmentData()
                      ],
                    )),
                SizedBox(height: AppPadding.p20,),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    ///graph
                    Expanded(
                      flex:2,
                      child: EMDashboardContainerBBorderConst(
                          height: 340,
                          child: Row(
                            children: [
                              Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GraphMenuConst(text: 'Onsite Staff', squareColor: ColorManager.pieChartGreen,),
                                  GraphMenuConst(text: 'Remote Staff', squareColor: ColorManager.pieChartBlue,)
                                ],
                              ),
                            ],
                          )),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      flex:1,
                      child: EMDashboardContainerBBorderConst(
                          height: 170,
                          child: Container()),
                    ),
                  ],
                ),
              ],),
            )
          ],),
          SizedBox(height: AppSize.s30,),
        ],),),
    );
  }
}
