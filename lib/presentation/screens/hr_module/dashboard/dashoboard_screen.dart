import 'package:fl_chart/fl_chart.dart';
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

import '../../../../app/resources/color.dart';
import '../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/hr_resources/hr_theme_manager.dart';

class DashBoardScreen extends StatefulWidget {
  DashBoardScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  // List<String> _bottomTitle = ['Sat','Sun','Mon','Tue','Wed','Thu','Fri'];

  /// Bar Column chart data
  final List<ComboChartData> CombochartData = <ComboChartData>[
    ComboChartData('Sat', 50, 30),
    ComboChartData('Sun', 40, 25),
    ComboChartData('Mon', 100, 80),
    ComboChartData('Tue', 80, 50),
    ComboChartData('Wed', 90, 75),
    ComboChartData('Thu', 80, 65),
    ComboChartData('Fri', 80, 40),
  ];
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
  final List<ChartData> chartData = [
    ChartData(2012, 40),
    ChartData(2014, 35),
    ChartData(2016, 60),
    ChartData(2018, 20),
    ChartData(2020, 10),
    ChartData(2022, 34),
    ChartData(2024, 40)
  ];

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
  late TrackballBehavior _trackballBehavior;
  final List<TrackBallChartData> data = <TrackBallChartData>[
    TrackBallChartData('John', 15, 60),
    TrackBallChartData('Eva', 20, 55),
    TrackBallChartData('Ana', 25, 48),
    TrackBallChartData('Rio', 21, 57),
    TrackBallChartData('Jenie', 13, 62),
    TrackBallChartData('Roy', 18, 64),
    TrackBallChartData('Jeh', 24, 57),
  ];
  @override
  void initState() {
    super.initState();
    _trackballBehavior = TrackballBehavior(
      enable: true,
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints
    );
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
                                    imageTileColor:
                                        ColorManager.skini.withOpacity(0.8),
                                  );
                                } else if (snapshot.hasError) {
                                  return HrDashboardContainerConst(
                                    headText: "Total Employees",
                                    headSubTextColor: ColorManager.skini,
                                    subText: "Error",
                                    imageTile: 'images/hr_dashboard/total.png',
                                    imageTileColor:
                                        ColorManager.skini.withOpacity(0.8),
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
                                    imageTileColor:
                                        ColorManager.skini.withOpacity(0.8),
                                  );
                                } else {
                                  return HrDashboardContainerConst(
                                    headText: "Total Employees",
                                    headSubTextColor: ColorManager.skini,
                                    subText: "0",
                                    imageTile: 'images/hr_dashboard/total.png',
                                    imageTileColor:
                                        ColorManager.skini.withOpacity(0.8),
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
                                    imageTile:
                                        'images/hr_dashboard/joinies.png',
                                    imageTileColor:
                                        ColorManager.blueDash.withOpacity(0.8),
                                  );
                                } else if (snapshot.hasError) {
                                  return HrDashboardContainerConst(
                                    headText: "New Joining's",
                                    headSubTextColor: ColorManager.blueDash,
                                    subText: "Error",
                                    imageTile:
                                        'images/hr_dashboard/joinies.png',
                                    imageTileColor:
                                        ColorManager.blueDash.withOpacity(0.8),
                                  );
                                } else if (snapshot.hasData &&
                                    snapshot.data != null) {
                                  final newJoineesCount =
                                      snapshot.data!.newJoineesCount ?? 0;
                                  return HrDashboardContainerConst(
                                    headText: "New Joining's",
                                    headSubTextColor: ColorManager.blueDash,
                                    subText: newJoineesCount.toString(),
                                    imageTile:
                                        'images/hr_dashboard/joinies.png',
                                    imageTileColor:
                                        ColorManager.blueDash.withOpacity(0.8),
                                  );
                                } else {
                                  return HrDashboardContainerConst(
                                    headText: "New Joining's",
                                    headSubTextColor: ColorManager.blueDash,
                                    subText: "0",
                                    imageTile:
                                        'images/hr_dashboard/joinies.png',
                                    imageTileColor:
                                        ColorManager.blueDash.withOpacity(0.8),
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
                              imageTileColor:
                                  ColorManager.pink.withOpacity(0.8),
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
                              imageTileColor:
                                  ColorManager.purple.withOpacity(0.8),
                            ),
                          ),
                        ],
                      )),
                ],
              ),

              ///graph section
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p15,
                    right: AppPadding.p15,
                    bottom: AppPadding.p10),
                child: Container(
                  height: 870,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      vertical: AppPadding.p10, horizontal: 5),
                  child: Column(
                    children: [
                      ///row 1
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: HrDashboadGraphContainer(
                                  child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
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
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 200,
                                        child: SfCartesianChart(
                                            // primaryYAxis: NumericAxis(
                                            //   axisLabelFormatter: (AxisLabelRenderDetails details) {
                                            //     // Format the y-axis label to append '%'
                                            //     return ChartAxisLabel('${details.value.toInt()}%', TextStyle(fontSize: 12));
                                            //   },
                                            // ),
                                            backgroundColor: ColorManager.white,
                                            primaryXAxis: CategoryAxis(),
                                            series: <CartesianSeries>[
                                              ColumnSeries<ComboChartData,
                                                      String>(
                                                  color:
                                                      ColorManager.barChartBlue,
                                                  dataSource: CombochartData,
                                                  xValueMapper:
                                                      (ComboChartData data,
                                                              _) =>
                                                          data.x,
                                                  yValueMapper:
                                                      (ComboChartData data,
                                                              _) =>
                                                          data.y),
                                              ColumnSeries<ComboChartData,
                                                      String>(
                                                  color: ColorManager.blueprime
                                                      .withOpacity(0.2),
                                                  dataSource: CombochartData,
                                                  xValueMapper:
                                                      (ComboChartData data,
                                                              _) =>
                                                          data.x,
                                                  yValueMapper:
                                                      (ComboChartData data,
                                                              _) =>
                                                          data.y1),
                                            ])
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
                                        ),
                                  ],
                                ),
                              ))),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              flex: 1,
                              child: HrDashboadGraphContainer(
                                child: FutureBuilder<EmployeeSexRatioData>(
                                  future: getSexRation(context: context),
                                  builder: (context, snapshot) {
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      return SizedBox();
                                    }
                                    if(snapshot.hasData){
                                      return Stack(
                                        children: [
                                          PieChart(
                                          PieChartData(
                                            sections: [
                                              ...List.generate(snapshot.data!.genderStatistics.length, (index){
                                               String percentage =  snapshot.data!.genderStatistics[index].percentage.replaceAll("%", "");
                                                return PieChartSectionData(
                                                  color: ColorManager.pieChartGreen,
                                                  value: double.parse(percentage),
                                                  title: '${snapshot.data!.genderStatistics[index].percentage}',
                                                  titleStyle: const TextStyle(
                                                      fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                  radius: 45,
                                                );
                                              })
                                              ],
                                            centerSpaceRadius: 40,
                                            centerSpaceColor: Colors.white,
                                            sectionsSpace: 2,
                                            borderData: FlBorderData(show: false),
                                            startDegreeOffset: -90,
                                          ),
                                        ),
                                          Positioned(
                                              top:103,
                                              left: 80,
                                              child: Text('Sex Ratio',style:TableHeadHRDashboard.customTextStyle(context),)),

                                        ],
                                      );
                                    }
                                    else{
                                      return SizedBox();
                                    }

                                  }
                                ),
                              )),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 2,
                            child: HrDashboadGraphContainer(
                                child: SingleChildScrollView(
                                    child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15),
                              child: Container(
                                //color: Colors.purple,
                                height: 210,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: ListView.builder(
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return Container(
                                       // color: ColorManager.incidentskin,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Expanded(
                                                 child: Center(
                                                     child: Text(
                                                         'Offer Acceptance Rate',
                                                         style: GraphHeadingHRDashboard.customTextStyle(context)))),
                                             Expanded(
                                                 child: Center(
                                                     child: Text(
                                               '15%',
                                               style: CustomTextStylesCommon.commonStyle(
                                                   color: ColorManager.dashListviewData,
                                                   fontSize: FontSize.s12,
                                                   fontWeight: FontWeight.w500),
                                             )))
                                           ],
                                                                                    ),
                                        ),
                                      );
                                    }),
                              ),
                            ))),
                          )
                        ],
                      ),
                      const SizedBox(height: 15,),

                      ///row 2
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Expanded(
                            child: HrDashboadGraphContainer(
                              child: Row(),
                            ),
                          ),
                          const SizedBox(width: 15,),
                          Expanded(
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
                                              children: [
                                                Text(
                                                  'Audit Readiness Score',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(fontSize: AppSize.s10),
                                                ),
                                                Text(
                                                  '92%',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(color: ColorManager.blueprime,
                                                      fontSize: AppSize.s30),
                                                )
                                              ],
                                            ),
                                            Container(
                                              height: 120,
                                              width: 100,
                                              child: PieChart(
                                                PieChartData(
                                                  sections: [
                                                    PieChartSectionData(
                                                      color: ColorManager.pieChartNBlue,
                                                      value: 92,
                                                      title: '',
                                                      //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                      radius: 35,
                                                    ),
                                                    PieChartSectionData(
                                                      color: ColorManager
                                                          .faintGrey,
                                                      value: 8,
                                                      title: '',
                                                      //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                      radius: 35,
                                                    ),
                                                  ],
                                                  centerSpaceRadius: 10,
                                                  centerSpaceColor:
                                                      Colors.white,
                                                  sectionsSpace: 2,
                                                  borderData:
                                                      FlBorderData(show: false),
                                                  startDegreeOffset: -90,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      HrDashboardSmallcontainer(
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Hr Staff To Employee Ratio',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: AppSize.s10),
                                                ),
                                                Text(
                                                  '56%',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: ColorManager
                                                          .blueprime,
                                                      fontSize: AppSize.s30),
                                                )
                                              ],
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
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      HrDashboardSmallcontainer(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  'Attrition Rate\n Withine 1 year',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: AppSize.s10),
                                                ),
                                                Text(
                                                  '12%',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: ColorManager
                                                          .blueprime,
                                                      fontSize: AppSize.s30),
                                                )
                                              ],
                                            ),
                                            Container(
                                              height: 70,
                                              width: 100,
                                              child: PieChart(
                                                PieChartData(
                                                  sections: [
                                                    PieChartSectionData(
                                                      color: ColorManager
                                                          .pieChartNBlue,
                                                      value: 12,
                                                      title: '',
                                                      //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                      radius: 35,
                                                    ),
                                                    PieChartSectionData(
                                                      color: ColorManager
                                                          .faintGrey,
                                                      value: 88,
                                                      title: '',
                                                      //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                      radius: 35,
                                                    ),
                                                  ],
                                                  centerSpaceRadius: 10,
                                                  centerSpaceColor:
                                                      Colors.white,
                                                  sectionsSpace: 2,
                                                  borderData:
                                                      FlBorderData(show: false),
                                                  startDegreeOffset: -90,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
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
                                                children: [
                                                  Text(
                                                    'Hiring Ratio',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: AppSize.s10),
                                                  ),
                                                  Text(
                                                    '56%',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color: ColorManager
                                                            .blueprime,
                                                        fontSize: AppSize.s30),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 150,
                                              width: 130,
                                              child: PieChart(
                                                PieChartData(
                                                  sections: [
                                                    PieChartSectionData(
                                                      color: ColorManager.green,
                                                      value: 56,
                                                      title: '',
                                                      //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                      radius: 35,
                                                    ),
                                                    PieChartSectionData(
                                                      color: ColorManager
                                                          .faintGrey,
                                                      value: 88,
                                                      title: '',
                                                      //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                      radius: 35,
                                                    ),
                                                  ],
                                                  centerSpaceRadius: 10,
                                                  centerSpaceColor:
                                                      Colors.white,
                                                  sectionsSpace: 2,
                                                  borderData:
                                                      FlBorderData(show: false),
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
                          Expanded(
                            child: Container(
                                height: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 0.75,
                                    color: ColorManager.ContainerBorder //.withOpacity(0.2)
                                    ,
                                  ),
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Color(0xFFDADEE8),
                                      blurRadius: 13.53,
                                      spreadRadius: 1,
                                      offset: Offset(-6.01, 9.02),
                                    ),
                                  ],
                                ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Employee Tenure & Documentation",
                                            textAlign: TextAlign.start,
                                            style: GraphHeadingHRDashboard.customTextStyle(context),
                                          ),
                                        ],
                                      ),
                                      Row(children: [
                                        TextCircleConst(text: 'Tenure', circleColor: ColorManager.emptenure,textColor: ColorManager.blackForLoginTexts,),
                                        SizedBox(width:5),
                                        TextCircleConst(text: 'Documentation', circleColor: ColorManager.empdoc, textColor: ColorManager.blackForLoginTexts,),
                                      ],)
                                    ],
                                  ),
                                  Container(
                                    height:200,
                                    child: SfCartesianChart(
                                        primaryXAxis: CategoryAxis(),
                                        trackballBehavior: _trackballBehavior,
                                        series: <LineSeries<TrackBallChartData, String>>[
                                          LineSeries<TrackBallChartData, String>(
                                            color: ColorManager.emptenure,
                                              dataSource: data,
                                              xValueMapper: (TrackBallChartData data, _) => data.empName,
                                              yValueMapper: (TrackBallChartData data, _) => data.firstSale),
                                          LineSeries<TrackBallChartData, String>(
                                              color: ColorManager.empdoc,
                                              dataSource: data,
                                              xValueMapper: (TrackBallChartData data, _) => data.empName,
                                              yValueMapper: (TrackBallChartData data, _) => data.secondSale),

                                        ]
                                    )
                                  )
                                ],
                              ),
                            ),),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15,),

                      ///row 3
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ///career progression metrix
                          Expanded(
                            child: Container(
                              height: 280,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 0.75,
                                  color: ColorManager
                                      .ContainerBorder //.withOpacity(0.2)
                                  ,
                                ),
                                boxShadow: [
                                  const BoxShadow(
                                    color: Color(0xFFDADEE8),
                                    blurRadius: 13.53,
                                    spreadRadius: 1,
                                    offset: Offset(-6.01, 9.02),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30.0),
                                      child: Text(
                                        "Career progression matrics",
                                        textAlign: TextAlign.center,
                                        style: GraphHeadingHRDashboard.customTextStyle(context),
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
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          ///incidence and violation
                          Expanded(
                            child: Container(
                                height: 280,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          ColorManager.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      spreadRadius: 0,
                                      offset:
                                          const Offset(0, 0), // Downward shadow
                                    ),
                                  ],
                                ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Incident and violation tracking",
                                      textAlign: TextAlign.start,
                                      style: GraphHeadingHRDashboard.customTextStyle(context),
                                    ),
                                    Container(
                                      height: 200,
                                      child: SfCartesianChart(
                                          // primaryYAxis: NumericAxis(
                                          //   axisLabelFormatter: (AxisLabelRenderDetails details) {
                                          //     // Format the y-axis label to append '%'
                                          //     return ChartAxisLabel('${details.value.toInt()}%', TextStyle(fontSize: 12));
                                          //   },
                                          // ),
                                          series: <CartesianSeries>[
                                            SplineAreaSeries<ChartAreaData, int>(
                                              color: ColorManager.incidentBlue.withOpacity(0.2),
                                              borderColor: ColorManager.incidentBlue,
                                                borderWidth: 2,
                                                dataSource: AreachartData,
                                                xValueMapper: (ChartAreaData data, _) => data.x,
                                                yValueMapper: (ChartAreaData data, _) => data.y
                                            ),
                                            SplineAreaSeries<ChartAreaData, int>(
                                              color: ColorManager.incidentskin.withOpacity(0.3),
                                              borderColor: ColorManager.incidentskin,
                                              borderWidth: 2,
                                                dataSource: AreachartData,
                                                yValueMapper: (ChartAreaData data, _) => data.y1,
                                              xValueMapper: (ChartAreaData data, _) => data.x,
                                            ),
                                          ]
                                      ),
                                    ),
                                    SizedBox(height: 5,),
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
                          ),
                          const SizedBox(
                            width: 15,
                          ),

                          ///metrix diversity
                          Expanded(
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
                                              //   PieChartSectionData(
                                              //   color: ColorManager.mediumgrey,
                                              //   value: 88,
                                              //   //title: '34%',
                                              //   //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                              //   radius: 45,
                                              // ),
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
                                  Center(
                                    child: Container(
                                      height: 150,
                                      width: 200,
                                      //color: Colors.greenAccent,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

              ///listview section
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p25,
                    right: AppPadding.p25,
                    bottom: AppPadding.p10),
                child: Container(
                  height: AppSize.s450,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const HrDashboardListviewHeading(),
                      const SizedBox(height: AppSize.s10),

                      ///
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
            ],
          ),
        ),
      ),
    );
  }
}
