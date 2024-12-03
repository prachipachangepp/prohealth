import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
                    child: GestureDetector(
                        onTap: (){
                          showDialog(context: context, builder: (context) => OfficeLocationPopup());
                        },
                        child: LinearCardWidget(headingText: 'Average Daily Attendance\nper Office', totalCount: '100%', totalValue: 100,icon: Icons.calendar_today_outlined,)),)),
            ],),
          SizedBox(height: AppSize.s15,),
          ///2nd row
          Row(children: [
            Expanded(
                flex: 3,
                child: EMDashboardContainerConst(
                    height: 600,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Average Distance between Office',style: CustomTextStylesCommon.commonStyle(
                              color: ColorManager.mediumgrey,
                              fontSize: FontSize.s14,
                              fontWeight: FontWeight.w700)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              height: 420,// Adjust the height as needed
                               child: GoogleMap(
                                initialCameraPosition:
                                CameraPosition(
                                  target: LatLng(
                                  //  double.parse(snapshot.data![index].lat),
                                    double.parse("18.516726"),
                                   // double.parse(snapshot.data![index].long),
                                    double.parse("73.856255"),
                                  ),
                                  zoom: 15.0,
                                ),
                                markers: {
                                  Marker(
                                    markerId: MarkerId(''),
                                    position: LatLng(
                                      double.parse("18.516726"),
                                      double.parse("73.856255"),
                                    ),
                                  ),
                                },
                                zoomControlsEnabled: false,
                                mapToolbarEnabled: false,
                              ),
                            ),
                          ),
                          Text('1 hr ( 30 km )',style: CustomTextStylesCommon.commonStyle(
                              color: ColorManager.mediumgrey,
                              fontSize: FontSize.s16,
                              fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),)),
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
                      flex:3,
                      child: EMDashboardContainerBBorderConst(
                          height: 340,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0,right: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                  Text("Onsite Staff",
                                  style: CustomTextStylesCommon.commonStyle(
                                      color: ColorManager.black,
                                      fontSize: FontSize.s16,
                                      fontWeight: FontWeight.w600),),
                                  SizedBox(width: 70,),
                                  Text("Remote Staff",
                                  style: CustomTextStylesCommon.commonStyle(
                                      color: ColorManager.black,
                                      fontSize: FontSize.s16,
                                      fontWeight: FontWeight.w600),),
                                ],),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(height: 100,),
                                        GraphMenuConst(text: 'Onsite Staff  ', squareColor: ColorManager.pieChartGreen,),
                                        SizedBox(height: 10,),
                                        GraphMenuConst(text: 'Remote Staff', squareColor: ColorManager.pieChartBlue,),

                                      ],
                                    ),
                                    SizedBox(width: 40,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 250,
                                          child: PieChart(
                                            PieChartData(
                                              sections: [
                                                PieChartSectionData(
                                                  color: ColorManager.pieChartGreen,
                                                  value: 60,
                                                  title: '65%',
                                                  titleStyle:  TextStyle(
                                                      fontSize: 10, fontWeight: FontWeight.bold, color: ColorManager.mediumgrey),
                                                  radius: 75,
                                                ),
                                                PieChartSectionData(
                                                  color: ColorManager.pieChartBlue,
                                                  value: 40,
                                                  title: '35%',
                                                  titleStyle:  TextStyle(
                                                      fontSize: 10, fontWeight: FontWeight.bold, color: ColorManager.mediumgrey),
                                                  radius: 65,
                                                ),
                                              ],
                                              centerSpaceRadius: 40,
                                              centerSpaceColor: Colors.white,
                                              sectionsSpace: 2,
                                              borderData: FlBorderData(show: true),
                                              startDegreeOffset: -90,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      flex:2,
                      child: EMDashboardContainerBBorderConst(
                          height: 170,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Text('Offices by service Availability',style: CustomTextStylesCommon.commonStyle(
                                    color: ColorManager.mediumgrey,
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeight.w700)),
                              ],),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Column(children: [
                                  Icon(Icons.home,color: ColorManager.bluebottom,size: 30,),
                                  SizedBox(height: 8,),
                                  Text("Home",style: CustomTextStylesCommon.commonStyle(
                                      color: ColorManager.mediumgrey,
                                      fontSize: FontSize.s14,
                                      fontWeight: FontWeight.w400))
                                ],),
                                Column(children: [
                                  Icon(Icons.local_hospital,color: ColorManager.bluebottom,size: 30,),
                                  SizedBox(height: 8,),
                                  Text("Health",style: CustomTextStylesCommon.commonStyle(
                                      color: ColorManager.mediumgrey,
                                      fontSize: FontSize.s14,
                                      fontWeight: FontWeight.w400))
                                ],),
                                Column(children: [
                                  Icon(Icons.location_on_outlined,color: ColorManager.bluebottom,size: 30,),
                                  SizedBox(height: 8,),
                                  Text("Hospice",style: CustomTextStylesCommon.commonStyle(
                                      color: ColorManager.mediumgrey,
                                      fontSize: FontSize.s14,
                                      fontWeight: FontWeight.w400))
                                ],),
                              ],),
                            ],
                          )),
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
