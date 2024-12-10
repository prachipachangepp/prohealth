import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/dashboard/hr_dashboard/hr_dashboard_graph_manager.dart';
import 'package:prohealth/app/services/api/managers/dashboard/hr_dashboard/hr_dashboard_manager.dart';
import 'package:prohealth/data/api_data/dashboard/hr_dashboard/hr_dashboard_graph_model.dart';
import 'package:prohealth/data/api_data/dashboard/hr_dashboard/hr_dashboard_part_one_data.dart';
import 'package:prohealth/presentation/screens/hr_module/dashboard/widgets/barChart_const_data.dart';
import 'package:prohealth/presentation/screens/hr_module/dashboard/widgets/dataModel_barchart.dart';
import 'package:prohealth/presentation/screens/hr_module/dashboard/widgets/hr_dashboard_const.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';

class DashBoardScreen extends StatefulWidget {
  DashBoardScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  // List<String> _bottomTitle = ['Sat','Sun','Mon','Tue','Wed','Thu','Fri'];

  /// Bar Column chart data output ratio
  final List<ComboChartData> CombochartData = <ComboChartData>[
    ComboChartData('Sat', 50, 30),
    ComboChartData('Sun', 40, 25),
    ComboChartData('Mon', 100, 80),
    ComboChartData('Tue', 80, 50),
    ComboChartData('Wed', 90, 75),
    ComboChartData('Thu', 80, 65),
    ComboChartData('Fri', 80, 40),
  ];
  String? emptype;
  // List<DataModel> _list = List<DataModel>.empty(growable:true);
  // List<BarChartGroupData> _chartGroups(){
  //   List<BarChartGroupData> list = List<BarChartGroupData>.empty(growable: true);
  //   for(int i = 0; i< _list.length; i++){
  //     list.add(BarChartGroupData(x: i, barRods: [BarChartRodData(toY: double.parse(_list[i].value!), color:ColorManager.barChartBlue)]));
  //   }
  //   return list;
  // }
  // SideTitles get _bottomTitles => SideTitles(
  //     showTitles: true,
  //     getTitlesWidget: (value, meta){
  //       String text ='';
  //       switch (value.toInt()){
  //         case 0:
  //           text = 'Sat';
  //           break;
  //
  //         case 1:
  //           text = 'Sun';
  //           break;
  //
  //         case 2:
  //           text = 'Mon';
  //           break;
  //
  //         case 3:
  //           text = 'Tus';
  //           break;
  //
  //         case 4:
  //           text = 'Wed';
  //           break;
  //
  //         case 5:
  //           text = 'Thu';
  //           break;
  //
  //         case 6:
  //           text = 'Fri';
  //           break;
  //
  //       }
  //       return Text(text,style: const TextStyle(fontSize: 10),);
  //     }
  // );

  /// pie chart data
  List<PieChartSectionData> _getSections() {
    return [
      PieChartSectionData(
        color: ColorManager.pieChartGreen,
        value: 34,
        title: '34%',
        titleStyle: const TextStyle(
            fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
        radius: 45,
      ),
      PieChartSectionData(
        color: ColorManager.pieChartBBlue,
        value: 7,
        title: '7%',
        titleStyle: const TextStyle(
            fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
        radius: 40,
      ),
      PieChartSectionData(
        color: ColorManager.pieChartBlue,
        value: 60,
        title: '60%',
        titleStyle: const TextStyle(
            fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
        radius: 40,
      ),
    ];
  }

  /// Spline chart data
  // final List<ChartData> chartData = [
  //   ChartData(2012, 40),
  //   ChartData(2014, 35),
  //   ChartData(2016, 60),
  //   ChartData(2018, 20),
  //   ChartData(2020, 10),
  //   ChartData(2022, 34),
  //   ChartData(2024, 40)
  // ];

  /// Area chart
  final List<ChartAreaData> AreachartData = <ChartAreaData>[
    ChartAreaData(2010, 10.53, 3.3),
    ChartAreaData(2011, 9.5, 5.4),
    ChartAreaData(2012, 10, 2.65),
    ChartAreaData(2013, 9.4, 2.62),
    ChartAreaData(2014, 5.8, 1.99),
    ChartAreaData(2015, 4.9, 1.44),
    ChartAreaData(2016, 4.5, 2),
    ChartAreaData(2017, 3.6, 1.56),
    ChartAreaData(2018, 3.43, 2.1),

  ];

  /// TrackBall chart
  // late TrackballBehavior _trackballBehavior;
  // final List<TrackBallChartData> data = <TrackBallChartData>[
  //   TrackBallChartData('John', 15, 60),
  //   TrackBallChartData('Eva', 20, 55),
  //   TrackBallChartData('Ana', 25, 48),
  //   TrackBallChartData('Rio', 21, 57),
  //   TrackBallChartData('Jenie', 13, 62),
  //   TrackBallChartData('Roy', 18, 64),
  //   TrackBallChartData('Jeh', 24, 57),
  // ];
  @override
  void initState() {
    super.initState();
    // _trackballBehavior = TrackballBehavior(
    //   enable: true,
    //     tooltipDisplayMode: TrackballDisplayMode.groupAllPoints
    // );
    // _list.add(DataModel(key:"0",value: "10"));
    // _list.add(DataModel(key:"10%",value: "6"));
    // _list.add(DataModel(key:"20%",value: "8"));
    // _list.add(DataModel(key:"30%",value: "4"));
    // _list.add(DataModel(key:"40%",value: "6"));
    // _list.add(DataModel(key:"50%",value: "7"));
    // _list.add(DataModel(key:"60%",value: "2"));
  }
  String selectedValue = "Daily";

  final List<String> items = ["Daily", "Weekly", "Monthly"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p10, horizontal: AppPadding.p14),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: AppSize.s150,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE9F2F5), // Color(0xFFF2F9FC),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 80),
                      child: Row(
                        children: [
                          Expanded(
                            child: FutureBuilder<NewJoineeDash?>(
                              future: HrDashNewJoineeGet(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return HrDashboardContainerConst(
                                    headText: "Total Employees",
                                    headSubTextColor: ColorManager.skini,
                                    subText: "0",
                                    imageTile: 'images/hr_dashboard/total.png',
                                  );
                                } else if (snapshot.hasError) {
                                  return HrDashboardContainerConst(
                                    headText: "Total Employees",
                                    headSubTextColor: ColorManager.skini,
                                    subText: "Error",
                                    imageTile: 'images/hr_dashboard/total.png',
                                  );
                                } else if (snapshot.hasData &&
                                    snapshot.data != null) {
                                  final newEmpCount =
                                      snapshot.data!.totalEmployees ?? 0;
                                  return HrDashboardContainerConst(
                                    headText: "Total Employees",
                                    headSubTextColor: ColorManager.skini,
                                    subText: newEmpCount.toString(),
                                    imageTile: 'images/hr_dashboard/total.png',
                                  );
                                } else {
                                  return HrDashboardContainerConst(
                                    headText: "Total Employees",
                                    headSubTextColor: ColorManager.skini,
                                    subText: "0",
                                    imageTile: 'images/hr_dashboard/total.png',
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Expanded(
                            child: FutureBuilder<NewJoineeDash?>(
                              future: HrDashNewJoineeGet(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return HrDashboardContainerConst(
                                    headText: "New Joining's",
                                    headSubTextColor: ColorManager.blueDash,
                                    subText: "0",
                                    imageTile: 'images/hr_dashboard/joinies.png',
                                  );
                                } else if (snapshot.hasError) {
                                  return HrDashboardContainerConst(
                                    headText: "New Joining's",
                                    headSubTextColor: ColorManager.blueDash,
                                    subText: "Error",
                                    imageTile: 'images/hr_dashboard/joinies.png',
                                  );
                                } else if (snapshot.hasData &&
                                    snapshot.data != null) {
                                  final newJoineesCount =
                                      snapshot.data!.newJoineesCount ?? 0;
                                  return HrDashboardContainerConst(
                                    headText: "New Joining's",
                                    headSubTextColor: ColorManager.blueDash,
                                    subText: newJoineesCount.toString(),
                                    imageTile: 'images/hr_dashboard/joinies.png',
                                  );
                                } else {
                                  return HrDashboardContainerConst(
                                    headText: "New Joining's",
                                    headSubTextColor: ColorManager.blueDash,
                                    subText: "0",
                                    imageTile: 'images/hr_dashboard/joinies.png',
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Expanded(
                            child: HrDashboardContainerConst(
                              headText: "Today’s Attendance",
                              headSubTextColor: ColorManager.pink,
                              subText: "90%",
                              imageTile: 'images/hr_dashboard/attendies.png',
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Expanded(
                            child: HrDashboardContainerConst(
                              headText: "Employees on Leave",
                              headSubTextColor: ColorManager.purpleBlack,
                              subText: "08",
                              imageTile: 'images/hr_dashboard/emp_leave.png',
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25.0,bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: true,
                          useSafeArea: true,
                          context: context,
                          builder: (BuildContext context) {
                            return FractionallySizedBox(
                              heightFactor: 0.8,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: AppPadding.p80,
                                    right: AppPadding.p80,
                                    bottom: AppPadding.p50),
                                child: Column(
                                  children: [
                                    SizedBox(height: 20,),
                                     Row( crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Go Back",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontSize: FontSize.s12,
                                            fontWeight: FontWeight.w700,
                                            color: ColorManager.mediumgrey,
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      )
                                    ],),
                                    SizedBox(height: 20,),
                                    ///
                                    Expanded(
                                      child: ScrollConfiguration(
                                        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: 15,
                                          itemBuilder: (context, index) {
                                            return const Column(
                                              children: [
                                                SizedBox(height: AppSize.s5),
                                                HRDashBottomSheetData(),
                                                SizedBox(height: AppSize.s5),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        "View Document Expired List",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.bluebottom,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ///graph section
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p15,
                    right: AppPadding.p15,
                    bottom: AppPadding.p10),
                child: Container(
                  height: 980,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      vertical: AppPadding.p10, horizontal: 5),
                  child: Column(
                    children: [
                      ///row 1
                      Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: HrDashboadGraphContainer(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Output Relative to Input",
                                                  textAlign: TextAlign.center,
                                                  style: GraphHeadingHRDashboard
                                                      .customTextStyle(context),
                                                ),
                                              ],
                                            ),
                                            Row(children: [
                                              TextCircleConst(text: 'Work Hours', circleColor: ColorManager.emptenure,textColor: ColorManager.blackForLoginTexts,),
                                              SizedBox(width:5),
                                              TextCircleConst(text: 'Result', circleColor: ColorManager.relativeResult, textColor: ColorManager.blackForLoginTexts,),
                                            ],),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 125,
                                                 // height: 20,
                                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                                  // decoration: BoxDecoration(
                                                  //   border: Border.all(color: Color(0xFFC9C9C9), width: 0.86),
                                                  //   borderRadius: BorderRadius.circular(6),
                                                  //   color: Colors.transparent, // Ensure opacity 0 effect
                                                  // ),
                                                  child: StatefulBuilder(
                                                    builder: (BuildContext context,
                                                       void Function(void Function()) setState) {
                                                      return CustomDropdownTextFieldwidh(
                                                        items: ["Daily", "Weekly", "Monthly"],
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            selectedValue =
                                                            newValue!;
                                                          });
                                                        },

                                                      );
                                                      // return DropdownButtonHideUnderline(
                                                      //   child: DropdownButton<
                                                      //       String>(
                                                      //     value: selectedValue,
                                                      //     icon: const Icon(Icons
                                                      //         .arrow_drop_down),
                                                      //     iconSize: IconSize.I16,
                                                      //     isExpanded: true,
                                                      //     style: TextStyle(
                                                      //         color: Colors.black,
                                                      //         fontSize: 10),
                                                      //     items: items.map((
                                                      //         String value) {
                                                      //       return DropdownMenuItem<
                                                      //           String>(
                                                      //         value: value,
                                                      //         child: Text(value),
                                                      //       );
                                                      //     }).toList(),
                                                      //     onChanged: (newValue) {
                                                      //       setState(() {
                                                      //         selectedValue =
                                                      //         newValue!;
                                                      //       });
                                                      //     },
                                                      //   ),
                                                      // );
                                                    }
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
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
                                            ColumnSeries<ComboChartData, String>(
                                              color: ColorManager.emptenure,
                                              dataSource: CombochartData,
                                              xValueMapper: (ComboChartData data, _) => data.x,
                                              yValueMapper: (ComboChartData data, _) => data.y,
                                            ),
                                            ColumnSeries<ComboChartData, String>(
                                              color: ColorManager.relativeResult,
                                              dataSource: CombochartData,
                                              xValueMapper: (ComboChartData data, _) => data.x,
                                              yValueMapper: (ComboChartData data, _) => data.y1,
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Container(
                                      //     height: 200,
                                      //     child: SfCartesianChart(
                                      //         backgroundColor: ColorManager.white,
                                      //         primaryXAxis: CategoryAxis(),
                                      //         series: <CartesianSeries>[
                                      //           ColumnSeries<ComboChartData,
                                      //                   String>(
                                      //               color: ColorManager.emptenure,
                                      //               dataSource: CombochartData,
                                      //               xValueMapper: (ComboChartData data, _) => data.x,
                                      //               yValueMapper: (ComboChartData data, _) => data.y),
                                      //           ColumnSeries<ComboChartData, String>(
                                      //               color: ColorManager.relativeResult,
                                      //               dataSource: CombochartData,
                                      //               xValueMapper: (ComboChartData data, _) => data.x,
                                      //               yValueMapper: (ComboChartData data, _) => data.y1),
                                      //         ])
                                      //     ),
                                    ],
                                  ))),
                          const SizedBox(width: AppSize.s15,),
                          ///diverity
                          Expanded(
                           flex: 3,
                            child: HrDashboadGraphContainer(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Metrics on Ethnic Diversity',
                                        textAlign: TextAlign.start,
                                        style: GraphHeadingHRDashboard.customTextStyle(context),
                                      ),
                                      Container(
                                        height: 200,
                                        width: 200,
                                        // color: Colors.red,
                                        child: PieChart(
                                          PieChartData(
                                            sections: [
                                              PieChartSectionData(
                                                color: ColorManager.pieChartFYellow,
                                                value: 40,
                                                title: '',
                                                //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                radius: 40,
                                              ),
                                              PieChartSectionData(
                                                color: ColorManager.pieChartpurple,
                                                value: 20,
                                                title: '',
                                                //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                radius: 40,
                                              ),
                                              PieChartSectionData(
                                                color: ColorManager.pieChartFpurple,
                                                value: 10,
                                                title: '',
                                                //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                radius: 40,
                                              ),
                                              PieChartSectionData(
                                                color: ColorManager.pieChartYellow,
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
                                    ],
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 150,
                                      width: 190,
                                    padding: EdgeInsets.only(left: 30),
                                     //color: Colors.greenAccent,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            TextCircleConst(text: 'American', circleColor: ColorManager.pieChartpurple),
                                            TextCircleConst(text: 'African', circleColor: ColorManager.pieChartYellow),
                                            TextCircleConst(text: 'Asian', circleColor: ColorManager.pieChartFpurple),
                                            TextCircleConst(text: 'American African', circleColor: ColorManager.pieChartFYellow),

                                          ],
                                        ),
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSize.s15,),
                          Expanded(
                            flex: 2,
                            child: HrDashboadGraphContainer(
                                child: SingleChildScrollView(
                                    child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10),
                              child: Container(
                              //color: Colors.purple,
                                height: 220,
                               // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                child: ListView.builder(
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         children: [
                                           Text(
                                               'Offer Acceptance Rate',
                                               style: GraphHeadingHRDashboard.customTextStyle(context)),
                                           Text(
                                             '15%',
                                             style: CustomTextStylesCommon.commonStyle(
                                             color: ColorManager.dashListviewData,
                                            fontSize: FontSize.s12,
                                            fontWeight: FontWeight.w500),
                                         )
                                         ],
                                         ),
                                      );
                                    }),
                              ),
                            ))),
                          )
                        ],
                      ),
                      const SizedBox(height: AppSize.s15,),

                      ///row 2
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                           Expanded(
                             flex: 2,
                            child: HrDashboadGraphContainer(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Attendance & Punctuality Rates',style:
                                    TableHeadHRDashboard.customTextStyle(
                                        context),),
                                    // Container(
                                    //   height: 190,
                                    //   width: 250,
                                    //   child: SfRadialGauge(
                                    //     axes: <RadialAxis>[
                                    //       RadialAxis(
                                    //         startAngle: 180,
                                    //         endAngle: 0,
                                    //         minimum: 0,
                                    //         maximum: 100,
                                    //         radiusFactor: 0.8,
                                    //         axisLineStyle: AxisLineStyle(thickness: 20),
                                    //         ranges: <GaugeRange>[
                                    //           GaugeRange(
                                    //             startValue: 0,
                                    //             endValue: 100,
                                    //             gradient: SweepGradient(
                                    //               colors: [Color(0xffA158F7), Color(0xff2B98B5)],
                                    //               stops: [0.0, 1.0],
                                    //             ),
                                    //             startWidth: 20,
                                    //             endWidth: 20,
                                    //           ),
                                    //         ],
                                    //         pointers: <GaugePointer>[
                                    //           MarkerPointer(
                                    //             value: 70,
                                    //             markerHeight: 20,
                                    //             markerWidth: 40,
                                    //           ),
                                    //         ],
                                    //         annotations: <GaugeAnnotation>[
                                    //           GaugeAnnotation(
                                    //             widget: Text(
                                    //               '70%',
                                    //               style: TextStyle(
                                    //                 fontSize: 18,
                                    //                 fontWeight: FontWeight.bold,
                                    //               ),
                                    //             ),
                                    //             angle: 90,
                                    //             positionFactor: 0.75,
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    Divider(),
                                    Container(
                                      height:190,
                                      width:250,
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
                                                positionFactor: 0.75,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15,),
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      HrDashboardSmallcontainer(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Audit Readiness\nScore',
                                                  textAlign: TextAlign.start,
                                                  style: CustomTextStylesCommon.commonStyle(
                                                    fontSize: FontSize.s12,
                                                    fontWeight: FontWeight.w500,
                                                    color: ColorManager.mediumgrey,),
                                                ),
                                                Text(
                                                  '92%',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(color: ColorManager.blueBorderText,  fontWeight: FontWeight.w500,
                                                      fontSize: AppSize.s30),
                                                )
                                              ],
                                            ),
                                            Container(
                                              height: 120,
                                              width: 120,
                                              alignment: Alignment.center,
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  ShaderMask(
                                                    shaderCallback: (rect) {
                                                      return RadialGradient(
                                                        colors: [
                                                          Color(0xff59A9F4),
                                                          Color(0xff34628E),
                                                        ],
                                                        center: Alignment.center,
                                                        radius: 0.5,
                                                      ).createShader(rect);
                                                    },
                                                    blendMode: BlendMode.srcATop,
                                                    child: PieChart(
                                                      PieChartData(
                                                        sections: [
                                                          PieChartSectionData(
                                                            color: Colors.transparent,
                                                            value: 20,
                                                            title: '',
                                                            radius: 27,
                                                          ),
                                                          PieChartSectionData(
                                                            color: Colors.white,
                                                            value: 90,
                                                            title: '',
                                                            radius: 27,
                                                          ),
                                                        ],
                                                        centerSpaceRadius: 10,
                                                        centerSpaceColor: Colors.white,
                                                        sectionsSpace: 0,
                                                        borderData: FlBorderData(show: false),
                                                        startDegreeOffset: 0,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            ///old
                                            // Container(
                                            //   height: 120,
                                            //   width: 100,
                                            //   child: PieChart(
                                            //     PieChartData(
                                            //       sections: [
                                            //         PieChartSectionData(
                                            //           color: ColorManager.pieChartNBlue,
                                            //           value: 92,
                                            //           title: '',
                                            //           //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                            //           radius: 35,
                                            //         ),
                                            //         PieChartSectionData(
                                            //           color: ColorManager
                                            //               .faintGrey,
                                            //           value: 8,
                                            //           title: '',
                                            //           //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                            //           radius: 35,
                                            //         ),
                                            //       ],
                                            //       centerSpaceRadius: 10,
                                            //       centerSpaceColor:
                                            //           Colors.white,
                                            //       sectionsSpace: 2,
                                            //       borderData:
                                            //           FlBorderData(show: false),
                                            //       startDegreeOffset: -90,
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      ///Employee Ratio
                                      HrDashboardSmallcontainer(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Hr Staff To\nEmployee Ratio',
                                              textAlign: TextAlign.start,
                                              style: CustomTextStylesCommon.commonStyle(
                                                fontSize: FontSize.s12,
                                                fontWeight: FontWeight.w500,
                                                color: ColorManager.mediumgrey,),
                                            ),
                                            Text(
                                              '56%',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(color: ColorManager.blueBorderText,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: AppSize.s30),
                                            ),
                                            // Container(
                                            //   child: PieChart(
                                            //     PieChartData(
                                            //       sections: [PieChartSectionData(
                                            //         color: ColorManager.blueprime,
                                            //         value: 12,
                                            //         //title: '34%',
                                            //         //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                            //         radius: 45,
                                            //       ),PieChartSectionData(
                                            //         color: ColorManager.mediumgrey,
                                            //         value: 88,
                                            //         //title: '34%',
                                            //         //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                            //         radius: 45,
                                            //       ),],
                                            //       centerSpaceRadius: 20,
                                            //       centerSpaceColor: Colors.white,
                                            //       sectionsSpace: 2,
                                            //       borderData: FlBorderData(show: false),
                                            //       startDegreeOffset: -90,
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 15,),

                                Expanded(
                                  child: Column(
                                    children: [
                                      ///Attrition Rate
                                      HrDashboardSmallcontainer(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Filter',
                                                  textAlign: TextAlign.start,
                                                  style: CustomTextStylesCommon.commonStyle(
                                                    fontSize: FontSize.s12,
                                                    fontWeight: FontWeight.w500,
                                                    color: ColorManager.mediumgrey,),
                                                ),
                                                SizedBox(width: 10,),
                                                IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt_outlined,size: 14,))
                                              ],),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Attrition Rate',
                                                      textAlign: TextAlign.start,
                                                      style: CustomTextStylesCommon.commonStyle(
                                                        fontSize: FontSize.s12,
                                                        fontWeight: FontWeight.w500,
                                                        color: ColorManager.mediumgrey,),
                                                    ),
                                                    Text(
                                                      '12%',
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(color: ColorManager.blueBorderText,  fontWeight: FontWeight.w500,
                                                          fontSize: AppSize.s30),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        width: 100,
                                                        height: 55,
                                                        child: Image.asset('images/hr_dashboard/person.png',fit: BoxFit.contain,))
                                                  ],
                                                ),

                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      ///hiring ratio
                                      HrDashboardSmallcontainer(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Hiring Ratio',
                                                    textAlign: TextAlign.start,
                                                    style: CustomTextStylesCommon.commonStyle(
                                                      fontSize: FontSize.s12,
                                                      fontWeight: FontWeight.w500,
                                                      color: ColorManager.mediumgrey,),
                                                  ),
                                                  Text(
                                                    '56%',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(color: ColorManager.blueBorderText,  fontWeight: FontWeight.w500,
                                                        fontSize: AppSize.s30),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 150,
                                              width: 120,
                                              child: PieChart(
                                                PieChartData(
                                                  sections: [
                                                    PieChartSectionData(
                                                      color: ColorManager.greenGraph,
                                                      value: 56,
                                                      title: '',
                                                      //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                      radius: 30,
                                                    ),
                                                    PieChartSectionData(
                                                      color: ColorManager
                                                          .faintGrey.withOpacity(0.5),
                                                      value: 88,
                                                      title: '',
                                                      //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                      radius: 30,
                                                    ),
                                                  ],
                                                  centerSpaceRadius: 20,
                                                  centerSpaceColor: Colors.white,
                                                  sectionsSpace: 2,
                                                  borderData: FlBorderData(show: false),
                                                  startDegreeOffset: -150,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15,),
                          ///incidence and violation
                          Expanded(
                            flex: 2,
                            child: HrDashboadGraphContainer(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Incident and violation tracking",
                                          textAlign: TextAlign.start,
                                          style: GraphHeadingHRDashboard.customTextStyle(context),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 200,
                                    child: SfCartesianChart(
                                      primaryXAxis: NumericAxis(
                                        isVisible: false,
                                      ),
                                      primaryYAxis: NumericAxis(
                                        isVisible: false,
                                      ),
                                      series: <CartesianSeries>[
                                        SplineAreaSeries<ChartAreaData, int>(
                                          color: ColorManager.incidentBlue.withOpacity(0.2),
                                          borderColor: ColorManager.incidentBlue,
                                          borderWidth: 2,
                                          dataSource: AreachartData,
                                          xValueMapper: (ChartAreaData data, _) => data.x,
                                          yValueMapper: (ChartAreaData data, _) => data.y,
                                        ),
                                        SplineAreaSeries<ChartAreaData, int>(
                                          color: ColorManager.incidentskin.withOpacity(0.3),
                                          borderColor: ColorManager.incidentskin,
                                          borderWidth: 2,
                                          dataSource: AreachartData,
                                          yValueMapper: (ChartAreaData data, _) => data.y1,
                                          xValueMapper: (ChartAreaData data, _) => data.x,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextCircleConst(text: "Safety Incidents", circleColor: ColorManager.incidentBlue, textColor: ColorManager.black,),
                                      TextCircleConst(text:  "Policy Breaches", circleColor: ColorManager.incidentskin, textColor: ColorManager.black)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 15,),
                          ///employee tenure
                          Expanded(
                           flex: 2,
                            child: HrDashboadGraphContainer(
                                child: Container(
                                  //color: Colors.purple,
                                  //height: 210,
                                //  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Employee Tenure",
                                        textAlign: TextAlign.center,
                                        style: CustomTextStylesCommon.commonStyle(
                                          fontSize: FontSize.s12,
                                          fontWeight: FontWeight.w700,
                                          color: ColorManager.mediumgrey,),
                                      ),
                                      Divider(),
                                      SizedBox(height: 10,),
                                      Row(
                                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          CustomRadioListTile(
                                            title: 'Age Wise',
                                            value: 'Age Wise',
                                            groupValue: emptype,
                                            onChanged: (value) {
                                              setState(() {
                                                emptype = value;
                                              });
                                            },
                                          ),
                                          CustomRadioListTile(
                                            title: 'Service Wise',
                                            value: 'Service Wise',
                                            groupValue: emptype,
                                            onChanged: (value) {
                                              setState(() {
                                                emptype = value;
                                              });
                                            },
                                          ),

                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Row(children: [
                                          Text(
                                            "Oldest",
                                            textAlign: TextAlign.center,
                                            style: CustomTextStylesCommon.commonStyle(
                                              fontSize: FontSize.s14,
                                              fontWeight: FontWeight.w700,
                                              color: ColorManager.bluebottom,),
                                          ),
                                          SizedBox(width: 100,),
                                          Text(
                                            "Youngest",
                                            textAlign: TextAlign.center,
                                            style: CustomTextStylesCommon.commonStyle(
                                              fontSize: FontSize.s14,
                                              fontWeight: FontWeight.w700,
                                              color: ColorManager.bluebottom,),
                                          ),
                                        ],),
                                      ),
                                      Divider(),
                                      Expanded(
                                        child: Container(
                                          //color: Colors.green,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 60,
                                                    height: 60,
                                                    padding: EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                      color: ColorManager.bluebottom,
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(30),
                                                      child: SizedBox(
                                                        width: 50,
                                                        height: 50,
                                                        child: Image.asset(
                                                          'images/hr_dashboard/man.png', // Replace with your image path
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Ross G",
                                                    textAlign: TextAlign.center,
                                                    style: CustomTextStylesCommon.commonStyle(
                                                      fontSize: FontSize.s12,
                                                      fontWeight: FontWeight.w700,
                                                      color: ColorManager.bluebottom,),
                                                  ),
                                                  Text(
                                                    "Age 49Y",
                                                    textAlign: TextAlign.center,
                                                    style: CustomTextStylesCommon.commonStyle(
                                                      fontSize: FontSize.s14,
                                                      fontWeight: FontWeight.w500,
                                                      color: ColorManager.mediumgrey,),
                                                  ),
                                                ],),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                Container(
                                                  width: 60,
                                                  height: 60,
                                                  padding: EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.bluebottom,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(30),
                                                    child: SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child: Image.asset(
                                                        'images/hr_dashboard/man.png', // Replace with your image path
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "Ross G",
                                                  textAlign: TextAlign.center,
                                                  style: CustomTextStylesCommon.commonStyle(
                                                    fontSize: FontSize.s12,
                                                    fontWeight: FontWeight.w700,
                                                    color: ColorManager.bluebottom,),
                                                ),
                                                Text(
                                                  "Age 49Y",
                                                  textAlign: TextAlign.center,
                                                  style: CustomTextStylesCommon.commonStyle(
                                                    fontSize: FontSize.s14,
                                                    fontWeight: FontWeight.w500,
                                                    color: ColorManager.mediumgrey,),
                                                ),
                                              ],),
                                            ],
                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                )),
                          ),
                          // Expanded(
                          //   child: Container(
                          //       height: 250,
                          //       decoration: BoxDecoration(
                          //         color: Colors.white,
                          //         borderRadius: BorderRadius.circular(10),
                          //         border: Border.all(
                          //           width: 0.75,
                          //           color: ColorManager.ContainerBorder //.withOpacity(0.2)
                          //           ,
                          //         ),
                          //         boxShadow: [
                          //           const BoxShadow(
                          //             color: Color(0xFFDADEE8),
                          //             blurRadius: 13.53,
                          //             spreadRadius: 1,
                          //             offset: Offset(-6.01, 9.02),
                          //           ),
                          //         ],
                          //       ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          //     child: Column(
                          //       children: [
                          //         Row(
                          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //           children: [
                          //             Row(
                          //               children: [
                          //                 Text(
                          //                   "Employee Tenure & Documentation",
                          //                   textAlign: TextAlign.start,
                          //                   style: GraphHeadingHRDashboard.customTextStyle(context),
                          //                 ),
                          //               ],
                          //             ),
                          //             Row(children: [
                          //               TextCircleConst(text: 'Tenure', circleColor: ColorManager.emptenure,textColor: ColorManager.blackForLoginTexts,),
                          //               SizedBox(width:5),
                          //               TextCircleConst(text: 'Documentation', circleColor: ColorManager.empdoc, textColor: ColorManager.blackForLoginTexts,),
                          //             ],)
                          //           ],
                          //         ),
                          //         Container(
                          //           height:200,
                          //           child: SfCartesianChart(
                          //               primaryXAxis: CategoryAxis(),
                          //               trackballBehavior: _trackballBehavior,
                          //               series: <LineSeries<TrackBallChartData, String>>[
                          //                 LineSeries<TrackBallChartData, String>(
                          //                   color: ColorManager.emptenure,
                          //                     dataSource: data,
                          //                     xValueMapper: (TrackBallChartData data, _) => data.empName,
                          //                     yValueMapper: (TrackBallChartData data, _) => data.firstSale),
                          //                 LineSeries<TrackBallChartData, String>(
                          //                     color: ColorManager.empdoc,
                          //                     dataSource: data,
                          //                     xValueMapper: (TrackBallChartData data, _) => data.empName,
                          //                     yValueMapper: (TrackBallChartData data, _) => data.secondSale),
                          //
                          //               ]
                          //           )
                          //         )
                          //       ],
                          //     ),
                          //   ),),
                          // ),
                        ],
                      ),
                      const SizedBox(height: AppSize.s30,),

                      ///listview section
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 15,
                          itemBuilder: (context, index) {
                            //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                            // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                            // EmployeeDocumentModal employeedoc = paginatedData[index];
                            return const Column(
                              children: [
                                SizedBox(height: AppSize.s5),
                                HRDashboardListViewData(),
                                SizedBox(height: AppSize.s5),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ///listview section
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: AppPadding.p25,
              //       right: AppPadding.p25,
              //       bottom: AppPadding.p10),
              //   child: Container(
              //     height: AppSize.s450,
              //     color: Colors.white,
              //     child:
              //     Column(
              //       children: [
              //         const HrDashboardListviewHeading(),
              //         const SizedBox(height: AppSize.s10),
              //
              //         ///
              //         Expanded(
              //           child: ListView.builder(
              //             scrollDirection: Axis.vertical,
              //             itemCount: 15,
              //             itemBuilder: (context, index) {
              //               //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
              //              // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
              //              // EmployeeDocumentModal employeedoc = paginatedData[index];
              //               return const Column(
              //                 children: [
              //                   SizedBox(height: AppSize.s5),
              //                   HRDashboardListViewData(),
              //                   SizedBox(height: AppSize.s5),
              //                 ],
              //               );
              //             },
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

///sex ratio
// Expanded(
//     flex: 1,
//     child: HrDashboadGraphContainer(
//       child: FutureBuilder<EmployeeSexRatioData>(
//         future: getSexRation(context: context),
//         builder: (context, snapshot) {
//           if(snapshot.connectionState == ConnectionState.waiting){
//             return SizedBox();
//           }
//           if(snapshot.hasData){
//             return Stack(
//               children: [
//                 PieChart(
//                 PieChartData(
//                   sections: [
//                     ...List.generate(snapshot.data!.genderStatistics.length, (index){
//                      String percentage =  snapshot.data!.genderStatistics[index].percentage.replaceAll("%", "");
//                       return PieChartSectionData(
//                         color: ColorManager.pieChartGreen,
//                         value: double.parse(percentage),
//                         title: '${snapshot.data!.genderStatistics[index].percentage}',
//                         titleStyle: const TextStyle(
//                             fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
//                         radius: 45,
//                       );
//                     })
//                     ],
//                   centerSpaceRadius: 40,
//                   centerSpaceColor: Colors.white,
//                   sectionsSpace: 2,
//                   borderData: FlBorderData(show: false),
//                   startDegreeOffset: -90,
//                 ),
//               ),
//                 Positioned(
//                     top:103,
//                     left: 80,
//                     child: Text('Sex Ratio',style:TableHeadHRDashboard.customTextStyle(context),)),
//
//               ],
//             );
//           }
//           else{
//             return SizedBox();
//           }
//
//         }
//       ),
//     )),

// BarChart(
//   BarChartData(
//     backgroundColor: ColorManager.white,
//     barGroups: _chartGroups(),
//     borderData: FlBorderData(
//       border: const Border(bottom: BorderSide(),left: BorderSide())
//     ),
//     gridData: const FlGridData(show: false),
//     titlesData: FlTitlesData(
//       bottomTitles: AxisTitles(sideTitles: _bottomTitles),
//       leftTitles:AxisTitles(sideTitles: SideTitles(
//         showTitles:true,
//         interval:1,
//         getTitlesWidget: (value, meta){
//           return Text(value.toString(),style:const TextStyle(fontSize: 10));
//         }
//       )),
//       topTitles: const AxisTitles(sideTitles:SideTitles(showTitles:false)),
//       rightTitles:const AxisTitles(sideTitles:SideTitles(showTitles:false)),
//     ),
//   )
// ),

///row 3
// Row(
//   crossAxisAlignment: CrossAxisAlignment.end,
//   children: [
//     ///career progression metrix
//     Expanded(
//       child: Container(
//         height: 280,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             width: 0.75,
//             color: ColorManager
//                 .ContainerBorder //.withOpacity(0.2)
//             ,
//           ),
//           boxShadow: [
//             const BoxShadow(
//               color: Color(0xFFDADEE8),
//               blurRadius: 13.53,
//               spreadRadius: 1,
//               offset: Offset(-6.01, 9.02),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//               vertical: 10, horizontal: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 30.0),
//                 child: Text(
//                   "Career progression matrics",
//                   textAlign: TextAlign.center,
//                   style: GraphHeadingHRDashboard.customTextStyle(context),
//                 ),
//               ),
//               Container(
//                 height: 210,
//                 child: SfCartesianChart(
//                     primaryYAxis: NumericAxis(
//                       axisLabelFormatter: (AxisLabelRenderDetails details) {
//                         // Format the y-axis label to append '%'
//                         return ChartAxisLabel('${details.value.toInt()}%', TextStyle(fontSize: 12));
//                       },
//                     ),
//                     series: <CartesianSeries>[
//                       // Renders spline chart
//                       SplineSeries<ChartData, int>(
//                           dataSource: chartData,
//                           xValueMapper:
//                               (ChartData data, _) =>
//                                   data.x,
//                           yValueMapper:
//                               (ChartData data, _) =>
//                                   data.y)
//                     ]),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//     const SizedBox(
//       width: 15,
//     ),
//     ///incidence and violation
//     Expanded(
//       child: Container(
//           height: 280,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color:
//                     ColorManager.black.withOpacity(0.2),
//                 blurRadius: 4,
//                 spreadRadius: 0,
//                 offset:
//                     const Offset(0, 0), // Downward shadow
//               ),
//             ],
//           ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(
//                 "Incident and violation tracking",
//                 textAlign: TextAlign.start,
//                 style: GraphHeadingHRDashboard.customTextStyle(context),
//               ),
//               Container(
//                 height: 200,
//                 child: SfCartesianChart(
//                     // primaryYAxis: NumericAxis(
//                     //   axisLabelFormatter: (AxisLabelRenderDetails details) {
//                     //     // Format the y-axis label to append '%'
//                     //     return ChartAxisLabel('${details.value.toInt()}%', TextStyle(fontSize: 12));
//                     //   },
//                     // ),
//                     series: <CartesianSeries>[
//                       SplineAreaSeries<ChartAreaData, int>(
//                         color: ColorManager.incidentBlue.withOpacity(0.2),
//                         borderColor: ColorManager.incidentBlue,
//                           borderWidth: 2,
//                           dataSource: AreachartData,
//                           xValueMapper: (ChartAreaData data, _) => data.x,
//                           yValueMapper: (ChartAreaData data, _) => data.y
//                       ),
//                       SplineAreaSeries<ChartAreaData, int>(
//                         color: ColorManager.incidentskin.withOpacity(0.3),
//                         borderColor: ColorManager.incidentskin,
//                         borderWidth: 2,
//                           dataSource: AreachartData,
//                           yValueMapper: (ChartAreaData data, _) => data.y1,
//                         xValueMapper: (ChartAreaData data, _) => data.x,
//                       ),
//                     ]
//                 ),
//               ),
//               SizedBox(height: 5,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   TextCircleConst(text: "Safety Incidents", circleColor: ColorManager.incidentBlue, textColor: ColorManager.black,),
//                   TextCircleConst(text:  "Policy Breaches", circleColor: ColorManager.incidentskin, textColor: ColorManager.black)
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     ),
//     const SizedBox(
//       width: 15,
//     ),
//
//     ///metrix diversity
//     Expanded(
//       child: HrDashboadGraphContainer(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Metrics on Ethnic Diversity',
//                   textAlign: TextAlign.start,
//                   style: GraphHeadingHRDashboard.customTextStyle(context),
//                 ),
//                 Container(
//                   height: 200,
//                    width: 200,
//                  // color: Colors.red,
//                   child: PieChart(
//                     PieChartData(
//                       sections: [
//                         PieChartSectionData(
//                           color: ColorManager.pieChartFYellow,
//                           value: 40,
//                           title: '',
//                           //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
//                           radius: 40,
//                         ),
//                         PieChartSectionData(
//                           color: ColorManager.pieChartpurple,
//                           value: 20,
//                           title: '',
//                           //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
//                           radius: 40,
//                         ),
//                         PieChartSectionData(
//                           color: ColorManager.pieChartFpurple,
//                           value: 10,
//                           title: '',
//                           //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
//                           radius: 40,
//                         ),
//                         PieChartSectionData(
//                           color: ColorManager.pieChartYellow,
//                           value: 25,
//                           title: '',
//                           //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
//                           radius: 40,
//                         ),
//                         //   PieChartSectionData(
//                         //   color: ColorManager.mediumgrey,
//                         //   value: 88,
//                         //   //title: '34%',
//                         //   //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
//                         //   radius: 45,
//                         // ),
//                       ],
//                       centerSpaceRadius: 60,
//                       centerSpaceColor: Colors.white,
//                       sectionsSpace: 3,
//                       borderData:
//                           FlBorderData(show: false),
//                       startDegreeOffset: -90,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Center(
//               child: Container(
//                 height: 150,
//                 width: 200,
//                 //color: Colors.greenAccent,
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         TextCircleConst(text: 'American', circleColor: ColorManager.pieChartpurple),
//                         TextCircleConst(text: 'African', circleColor: ColorManager.pieChartYellow),
//                         TextCircleConst(text: 'Asian', circleColor: ColorManager.pieChartFpurple),
//                         TextCircleConst(text: 'American African', circleColor: ColorManager.pieChartFYellow),
//
//                       ],
//                     ),
//                   ),
//               ),
//             )
//
//           ],
//         ),
//       ),
//     )
//   ],
// )

///attration rate
// Container(
// height: 70,
// width: 100,
// child: PieChart(
// PieChartData(
// sections: [
// PieChartSectionData(
// color: ColorManager
//     .pieChartNBlue,
// value: 12,
// title: '',
// //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
// radius: 35,
// ),
// PieChartSectionData(
// color: ColorManager
//     .faintGrey,
// value: 88,
// title: '',
// //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
// radius: 35,
// ),
// ],
// centerSpaceRadius: 10,
// centerSpaceColor:
// Colors.white,
// sectionsSpace: 2,
// borderData:
// FlBorderData(show: false),
// startDegreeOffset: -90,
// ),
// ),
// ),