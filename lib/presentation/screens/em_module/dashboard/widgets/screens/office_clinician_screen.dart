import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/dashboard/widgets/screens/widgets/const_linear_widget.dart';
import 'package:prohealth/presentation/screens/em_module/dashboard/widgets/screens/widgets/data_file.dart';
import 'package:prohealth/presentation/screens/em_module/dashboard/widgets/screens/widgets/office_clinician_const.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../em_dashboard_const.dart';

class OfficeClinicianScreen extends StatefulWidget {
   OfficeClinicianScreen({super.key});

  @override
  State<OfficeClinicianScreen> createState() => _OfficeClinicianScreenState();
}

class _OfficeClinicianScreenState extends State<OfficeClinicianScreen> {
  /// Bar Column chart data output ratio
  final List<BarChartEMData> barChartEMData = <BarChartEMData>[
    BarChartEMData('A', 50, 30),
    BarChartEMData('B', 40, 25),
    BarChartEMData('C', 100, 80),
    BarChartEMData('D', 80, 50),
  ];

  ///line graph
  final List<ChartData> chartData = [
    ChartData(2012, 40),
    ChartData(2014, 35),
    ChartData(2016, 60),
    ChartData(2018, 20),
    ChartData(2020, 10),
    ChartData(2022, 34),
    ChartData(2024, 40)
  ];

  List<BarChartGroupData> _generateBarGroups() {
    return [
      // First bar
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 90,
            width: 30,
            borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(6)),
            color: Colors.greenAccent,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 100,
              color: ColorManager.white, // Background color
            ),
          ),
        ],
      ),
      // Second bar
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: 80,
            width: 30,
            borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(6)),
            color: Colors.blueAccent,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 100,
              color: ColorManager.white,
            ),
          ),
        ],
      ),
      // Third bar
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: 100,
            width: 30,
            borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(6)),
            color: Colors.orangeAccent,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 100,
              color: ColorManager.white,
            ),
          ),
        ],
      ),
      // Fourth bar
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            toY: 75,
            width: 30,
            borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(6)),
            color: Colors.purpleAccent,//Color(0xFF77AC4)
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 100,
              color: ColorManager.white,
            ),
          ),
        ],
      ),
    ];
  }

  String selectedValue = "Daily";
  final List<String> items = ["Daily", "Weekly", "Monthly"];

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
                child: OfficeClinicianConst()),
            SizedBox(width: AppSize.s15,),
            Expanded(
                flex: 2,
                child: EMDashboardContainerBBorderConst(
                  child: GestureDetector(
                      onTap: (){
                        showDialog(context: context, builder: (context) => OfficeClinicianPopup());
                      },
                      child: LinearCardWidget(headingText: 'Office Customer\nSatisfaction rating', totalCount: '04', totalValue: 04,icon: CupertinoIcons.bag_badge_plus,)),)),
            SizedBox(width: AppSize.s15,),
            Expanded(
                flex: 2,
                child: EMDashboardContainerBBorderConst(
                  child: LinearCardWidget(headingText: 'Continuing Education\nCredits', totalCount: '30', totalValue: 30,icon: Icons.cast_for_education,),)),
            SizedBox(width: AppSize.s15,),
            Expanded(
                flex: 2,
                child: EMDashboardContainerBBorderConst(
                  child: LinearCardWidget(headingText: 'Clinician Time Off', totalCount: '07:00:00 pm', totalValue: 100,icon: CupertinoIcons.clock_fill,),)),
          ],),
        SizedBox(height: AppSize.s15,),
        ///2nd row
        Row(children: [
          ///patients ration graph
         Expanded(
              flex: 4,
              child: EMDashboardContainerConst(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Clinicians to Patient ratio by Service type',
                        style: CustomTextStylesCommon.commonStyle(
                            fontSize: 14,
                            color: ColorManager.mediumgrey,
                            fontWeight: FontWeight.w700),
                      ),
                      Container(
                        height: 200,
                        child: SfCartesianChart(
                          backgroundColor: ColorManager.white,
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis: NumericAxis(
                            axisLabelFormatter: (AxisLabelRenderDetails details) {
                              // Appends '%' symbol to the Y-axis labels
                              return ChartAxisLabel('${details.text}%', details.textStyle);
                            },
                          ),
                          series: <CartesianSeries>[
                            ColumnSeries<BarChartEMData, String>(
                              color: ColorManager.relativeResult,
                              dataSource: barChartEMData,
                              xValueMapper: (BarChartEMData data, _) => data.x,
                              yValueMapper: (BarChartEMData data, _) => data.y,
                            ),
                            ColumnSeries<BarChartEMData, String>(
                              color: ColorManager.ClinicianRatio,
                              dataSource: barChartEMData,
                              xValueMapper: (BarChartEMData data, _) => data.x,
                              yValueMapper: (BarChartEMData data, _) => data.y1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))),
          SizedBox(width: AppSize.s15,),
          Expanded(
              flex: 6,
              child: EMDashboardContainerBBorderConst(
                height: 300,
                  child: Column(
                    children: [
                     AverageClinicianListview()
                    ],
                  ))),
        ],),
        SizedBox(height: AppSize.s15,),
        ///3rd row
        Row(children: [
          Expanded(
              flex: 4,
              child: EMDashboardContainerConst(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Number of clinician working overtime",
                           style:  CustomTextStylesCommon.commonStyle(
                                color: ColorManager.mediumgrey,
                                fontSize: FontSize.s14,
                                fontWeight: FontWeight.w700),),
                          Container(
                            width: 125,
                            height: 20,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFC9C9C9), width: 0.86),
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.transparent, // Ensure opacity 0 effect
                            ),
                            child: StatefulBuilder(
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return DropdownButtonHideUnderline(
                                    child: DropdownButton<
                                        String>(
                                      value: selectedValue,
                                      icon: const Icon(Icons
                                          .arrow_drop_down),
                                      iconSize: IconSize.I16,
                                      isExpanded: true,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10),
                                      items: items.map((
                                          String value) {
                                        return DropdownMenuItem<
                                            String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedValue =
                                          newValue!;
                                        });
                                      },
                                    ),
                                  );
                                }
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                    height: 210,
                    child: SfCartesianChart(
                        primaryYAxis: NumericAxis(
                          axisLabelFormatter: (AxisLabelRenderDetails details) {
                            // Format the y-axis label to append '%'
                            return ChartAxisLabel('${details.value.toInt()}%', TextStyle(fontSize: 12));
                          },
                        ),
                        series: <CartesianSeries>[
                          // Renders spline chart
                          SplineSeries<ChartData, int>(
                              dataSource: chartData,
                              xValueMapper:
                                  (ChartData data, _) =>
                              data.x,
                              yValueMapper:
                                  (ChartData data, _) =>
                              data.y)
                        ]),
                                  ),
                  ],
                ),)),
          SizedBox(width: AppSize.s15,),
          Expanded(
              flex: 4,
              child: EMDashboardContainerConst(child: OfficeHighestPatientList())),
        ],),
        SizedBox(height: AppSize.s15,),
        ///4th row
        Row(children: [
          Expanded(
              flex: 4,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Color(0xFFE7F6F8),
                  borderRadius: BorderRadius.circular(14),
                  // border: Border.symmetric(vertical: BorderSide.none,horizontal: BorderSide(width: 1,color: Color(0xFFBCBCBC)),),//all(width: 1, color: Color(0xFFBCBCBC)),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.mediumgrey.withOpacity(0.2),
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: const Offset(0, 4), // Downward shadow
                    ),
                  ],
                ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Average Clinician Score',
                  style:  CustomTextStylesCommon.commonStyle(
                      color: ColorManager.mediumgrey,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w700),),
                  Container(
                    height: 200,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: BarChart(
                      BarChartData(
                        baselineY:2 ,
                        maxY: 100, // Maximum value for the Y-axis
                        barGroups: _generateBarGroups(),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), // Hide left titles
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                // X-axis labels
                                switch (value.toInt()) {
                                  case 0:
                                    return Text('90%');
                                  case 1:
                                    return Text('80%');
                                  case 2:
                                    return Text('100%');
                                  case 3:
                                    return Text('75%');
                                  default:
                                    return Text('');
                                }
                              },
                            ),
                          ),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), // Hide top titles
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), // Hide right titles
                        ),
                        barTouchData: BarTouchData(enabled: false),
                        gridData: FlGridData(show: false), // Hide grid lines
                        borderData: FlBorderData(show: false), // Hide chart borders
                      ),
                    ),
                  ),
                ],
              ),)),
          SizedBox(width: AppSize.s15,),
          Expanded(
              flex: 3,
              child: EMDashboardContainerConst(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text("Average Office Clinician\nto patient ratio",
                    style:  CustomTextStylesCommon.commonStyle(
                        color: ColorManager.mediumgrey,
                        fontSize: FontSize.s14,
                        fontWeight: FontWeight.w700),),
                  ),
                  Center(
                    child: Container(
                      height: 200,
                      padding: EdgeInsets.only(left: 15),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer Circle
                          SizedBox(
                            width: 160,
                            height: 160,
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    color: ColorManager.pieChartGreen,
                                    value: 75, // Patients % value
                                    radius: 20,
                                    title: "",

                                  ),
                                  PieChartSectionData(
                                    color: Colors.grey[300],
                                    value: 25, // Remaining % value
                                    radius: 20,
                                    title: "",
                                  ),
                                ],
                                centerSpaceRadius: 60, // Space between inner and outer circle
                                sectionsSpace: 0,
                              ),
                            ),
                          ),
                          // Inner Circle
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    color: ColorManager.pieChartfGrey,
                                    value: 90, // Clinicians % value
                                    radius: 15,
                                    title: "",
                                  ),
                                  PieChartSectionData(
                                    color: Colors.grey[200],
                                    value: 10, // Remaining % value
                                    radius: 15,
                                    title: "",
                                  ),
                                ],
                                centerSpaceRadius: 40,
                                sectionsSpace: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 10.0,
                        height: 15.0,
                        decoration: BoxDecoration(
                          color: ColorManager.pieChartGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text("Patients",style: CustomTextStylesCommon.commonStyle(
                          color:  ColorManager.mediumgrey,
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w500),),
                      SizedBox(width: 10,),
                      Text("3225+",style: CustomTextStylesCommon.commonStyle(
                          color:  ColorManager.mediumgrey,
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 10.0,
                        height: 15.0,
                        decoration: BoxDecoration(
                          color: ColorManager.pieChartfGrey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text("Clinicians",style: CustomTextStylesCommon.commonStyle(
                          color:  ColorManager.mediumgrey,
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w500),),
                      SizedBox(width: 10,),
                      Text("309+",style: CustomTextStylesCommon.commonStyle(
                          color:  ColorManager.mediumgrey,
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w500),)
                    ],
                  ),

                ],
              ))),
          SizedBox(width: AppSize.s15,),
          ///attendance
          Expanded(
              flex: 5,
              child: EMDashboardContainerConst(child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Clinician Attendance Rate by office',
                      style: CustomTextStylesCommon.commonStyle(
                      color: ColorManager.mediumgrey,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w700)),
                  Row(
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                      // color: Colors.red,
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                color: ColorManager.mediumgrey,
                                value: 40,
                                title: '',
                                //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                radius: 40,
                              ),
                              PieChartSectionData(
                                color: ColorManager.pieChartGreen,
                                value: 20,
                                title: '',
                                //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                radius: 40,
                              ),
                              PieChartSectionData(
                                color: ColorManager.relativeResult,
                                value: 10,
                                title: '',
                                //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                radius: 40,
                              ),
                              PieChartSectionData(
                                color: ColorManager.pieChartBlue,
                                value: 25,
                                title: '',
                                //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                radius: 40,
                              ),
                            ],
                            centerSpaceRadius: 60,
                            centerSpaceColor: Colors.white,
                            sectionsSpace: 3,
                            borderData:
                            FlBorderData(show: false),
                            startDegreeOffset: -90,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          AttendanceRatioConst(officeName: "Office 1", attendance: "80%", containerColor: ColorManager.mediumgrey),
                          SizedBox(height: 10,),
                          AttendanceRatioConst(officeName: "Office 2", attendance: "95%", containerColor: ColorManager.pieChartGreen),
                          SizedBox(height: 10,),
                          AttendanceRatioConst(officeName: "Office 3", attendance: "50%", containerColor: ColorManager.pieChartBlue),
                            SizedBox(height: 10,),
                            AttendanceRatioConst(officeName: "Office 4", attendance: "20%", containerColor: ColorManager.relativeResult),
                        ],),
                      )
                    ],
                  )
                ],
              ))),
          SizedBox(width: AppSize.s15,),
          ///speedometer
          Expanded(
              flex: 3,
              child: EMDashboardContainerConst(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Office with Longest Average\nPatient Visit Duration',style: CustomTextStylesCommon.commonStyle(
                      color: ColorManager.mediumgrey,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w700)),
                  Container(
                    height:190,
                    width:250,
                   // color: Colors.pink,
                    child:SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          startAngle: 180, // Start from the bottom center
                          endAngle: 0,     // End at the bottom center
                          minimum: 0,      // Minimum value of the gauge
                          maximum: 100,    // Maximum value of the gauge
                          ranges: <GaugeRange>[
                            GaugeRange(startValue: 0, endValue: 80, color: ColorManager.blueprime),
                            GaugeRange(startValue: 80, endValue: 100, color: ColorManager.faintGrey),
                          ],
                          pointers: <GaugePointer>[
                            MarkerPointer(
                              value: 70, // The value where the marker points
                              markerHeight: 20, // Height of the marker
                              markerWidth: 40,  // Width of the marker
                            ),
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              widget: Text(
                                '70%',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              angle: 90,
                              positionFactor: 0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )

                ],
              ))),
        ],),
        SizedBox(height: AppSize.s15,),
      ],),),
    );
  }
}
