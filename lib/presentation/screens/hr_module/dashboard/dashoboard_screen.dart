import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/dashboard/widgets/barChart_const_data.dart';
import 'package:prohealth/presentation/screens/hr_module/dashboard/widgets/dataModel_barchart.dart';
import 'package:prohealth/presentation/screens/hr_module/dashboard/widgets/hr_dashboard_const.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/establishment_resources/establishment_string_manager.dart';
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
        titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
        radius: 45,
      ),
      PieChartSectionData(
        color: ColorManager.pieChartBBlue,
        value: 7,
        title: '7%',
        titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
        radius: 40,
      ),
      PieChartSectionData(
        color: ColorManager.pieChartBlue,
        value: 60,
        title: '60%',
        titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
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
    ChartData(2020, 38),
    ChartData(2022, 34),
    ChartData(2024, 40)
  ];
  @override
  void initState() {
    super.initState();
    // _list.add(DataModel(key:"0",value: "10"));
    // _list.add(DataModel(key:"10%",value: "6"));
    // _list.add(DataModel(key:"20%",value: "8"));
    // _list.add(DataModel(key:"30%",value: "4"));
    // _list.add(DataModel(key:"40%",value: "6"));
    // _list.add(DataModel(key:"50%",value: "7"));
    // _list.add(DataModel(key:"60%",value: "2"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p10,horizontal: AppPadding.p14),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: AppSize.s150,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(color:Color(0xFFE9F2F5),// Color(0xFFF2F9FC),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: ColorManager.mediumgrey.withOpacity(0.5),
                      //     blurRadius: 2,
                      //     spreadRadius: -3,
                      //     offset: const Offset(0, -6),
                      //   ),
                      // ]
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 80),
                      child: Row(
                        children: [
                          Expanded(
                            child: HrDashboardContainerConst(
                                headText: "Total Employees",
                                headSubTextColor: ColorManager.skini,
                                subText: "101",
                                imageTile: 'images/hr_dashboard/total.png',
                                imageTileColor: ColorManager.skini.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(width: 25,),
                          Expanded(
                            child: HrDashboardContainerConst(
                              headText: "New Joining's",
                              headSubTextColor: ColorManager.blueDash,
                              subText: "03",
                              imageTile: 'images/hr_dashboard/joinies.png',
                              imageTileColor: ColorManager.blueDash.withOpacity(0.8),
                            ),
                          ),

                          const SizedBox(width: 25,),
                          Expanded(
                            child: HrDashboardContainerConst(
                              headText: "Today’s Attendance",
                              headSubTextColor: ColorManager.pink,
                              subText: "90%",
                              imageTile: 'images/hr_dashboard/attendies.png',
                              imageTileColor: ColorManager.pink.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(width: 25,),
                          Expanded(
                            child: HrDashboardContainerConst(
                              headText: "Employees on Leave",
                              headSubTextColor: ColorManager.purpleBlack,
                              subText: "08",
                              imageTile: 'images/hr_dashboard/emp_leave.png',
                              imageTileColor: ColorManager.purple.withOpacity(0.8),
                            ),
                          ),
                        ],
                      )),


                ],
              ),
              ///graph section
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p15,right: AppPadding.p15,bottom: AppPadding.p10),
                child: Container(
                  height: 870,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p10,horizontal: 5),
                  child: Column(
                    children: [
                      ///row 1
                      Row(children: [
                        Expanded(flex:3, child: HrDashboadGraphContainer(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical:5,horizontal:5),
                            child: Column(
                              children: [
                                Row(children: [
                                  Expanded(
                                    child: Text(
                                      "Output Relative to Input",
                                      textAlign: TextAlign.center,
                                      style: TableHeadHRDashboard.customTextStyle(context),
                                    ),
                                  ),
                                  Expanded(
                                    // flex: 1,
                                    child: Text(
                                     "Work Hours",
                                      textAlign: TextAlign.center,
                                      style: TableHeadHRDashboard.customTextStyle(context),
                                    ),
                                  ),
                                  Expanded(
                                    // flex: 1,
                                    child: Text(
                                      "Result",
                                      textAlign: TextAlign.center,
                                      style: TableHeadHRDashboard.customTextStyle(context),
                                    ),
                                  ),
                                ],),
                                Container(
                                  height: 200,
                                  child:SfCartesianChart(
                                    backgroundColor: ColorManager.white,
                                      primaryXAxis: CategoryAxis(),
                                      series: <CartesianSeries>[
                                        ColumnSeries<ComboChartData, String>(
                                          color: ColorManager.barChartBlue,
                                            dataSource: CombochartData,
                                            xValueMapper: (ComboChartData data, _) => data.x,
                                            yValueMapper: (ComboChartData data, _) => data.y
                                        ),
                                        ColumnSeries<ComboChartData, String>(
                                          color: ColorManager.blueprime.withOpacity(0.2),
                                            dataSource: CombochartData,
                                            xValueMapper: (ComboChartData data, _) => data.x,
                                            yValueMapper: (ComboChartData data, _) => data.y1
                                        ),

                                      ]
                                  )
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
                          )
                        )),
                        const SizedBox(width: 15,),
                        Expanded(flex:1, child: HrDashboadGraphContainer(
                        child: PieChart(
                          PieChartData(
                            sections: _getSections(),
                            centerSpaceRadius: 40,
                            centerSpaceColor: Colors.white,
                            sectionsSpace: 2,
                            borderData: FlBorderData(show: false),
                            startDegreeOffset: -90,
                          ),
                        ),)),
                        const SizedBox(width: 15,),
                        Expanded(flex:2, child: HrDashboadGraphContainer(
                        child:SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
                            child: Column(
                              children: [
                                Container(
                                    height:25,
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: ColorManager.dashBlueHead,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorManager.black.withOpacity(0.2),
                                          spreadRadius: 0,
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child:const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                    Expanded(child: Center(child: Text('Sr',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500)))),
                                    Expanded(child: Center(child: Text('Rates',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500)))),
                                    Expanded(child: Center(child: Text('Percentage',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500)))),
                                      ],
                                    )),
                              const SizedBox(height: 5,),
                              Container(
                                height: 200,
                                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                child: ListView.builder(
                                  itemCount: 5,
                                    itemBuilder: (context, index){
                                    return Column(
                                      children: [
                                        const Row(
                                          children: [
                                            Expanded(child: Center(child: Text('01',style: TextStyle(fontSize: 10)))),
                                            Expanded(child: Center(child: Text('Offer Acceptance Rate',style: TextStyle(fontSize: 10)))),
                                            Expanded(child: Center(child: Text('15%',style: TextStyle(fontSize: 10),)))
                                          ],
                                        ),
                                       Padding(
                                         padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 5),
                                         child: Divider(color: ColorManager.fmediumgrey,height: 1,),
                                       )
                                      ],
                                    );
                                }),
                              )
                            ],
                          ),
                        ))),)
                      ],),
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
                                  child: Column(children: [
                                    HrDashboardSmallcontainer(child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text('Audit Readiness Score',textAlign: TextAlign.start,style: TextStyle(fontSize: AppSize.s10),),
                                              Text('92%',textAlign: TextAlign.start,style: TextStyle(color: ColorManager.blueprime,fontSize: AppSize.s30),)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height:120,
                                          width:100,
                                          child: PieChart(
                                            PieChartData(
                                              sections: [PieChartSectionData(
                                                color: ColorManager.blueprime,
                                                value: 92,
                                                title: '',
                                                //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                radius: 45,
                                              ),PieChartSectionData(
                                                color: ColorManager.faintGrey,
                                                value: 8,
                                                title: '',
                                                //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                radius: 45,
                                              ),],
                                              centerSpaceRadius: 20,
                                              centerSpaceColor: Colors.white,
                                              sectionsSpace: 2,
                                              borderData: FlBorderData(show: false),
                                              startDegreeOffset: -90,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),),
                                    const SizedBox(height: 10,),
                                     HrDashboardSmallcontainer(child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Hr Staff To Employee Ratio',textAlign: TextAlign.start,style: TextStyle(fontSize: AppSize.s10),),
                                            Text('56%',textAlign: TextAlign.start,style: TextStyle(color: ColorManager.blueprime,fontSize: AppSize.s30),)
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
                                    ),),
                                  ],),
                                ),
                                const SizedBox(width: 15,),
                                 Expanded(
                                  child: Column(children: [
                                    HrDashboardSmallcontainer(child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text('Attrition Rate\n Withine 1 year',textAlign: TextAlign.start,style: TextStyle(fontSize: AppSize.s10),),
                                            Text('12%',textAlign: TextAlign.start,style: TextStyle(color: ColorManager.blueprime,fontSize: AppSize.s30),)
                                          ],
                                        ),
                                        Container(
                                          height:70,
                                          width:100,
                                          child: PieChart(
                                            PieChartData(
                                              sections: [PieChartSectionData(
                                                color: ColorManager.blueprime,
                                                value: 12,
                                                title: '',
                                                //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                radius: 45,
                                              ),PieChartSectionData(
                                                color: ColorManager.faintGrey,
                                                value: 88,
                                                title: '',
                                                //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                radius: 45,
                                              ),],
                                              centerSpaceRadius: 20,
                                              centerSpaceColor: Colors.white,
                                              sectionsSpace: 2,
                                              borderData: FlBorderData(show: false),
                                              startDegreeOffset: -90,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),),
                                    SizedBox(height: 10,),
                                    HrDashboardSmallcontainer(child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text('Hiring Ratio',textAlign: TextAlign.start,style: TextStyle(fontSize: AppSize.s10),),
                                              Text('56%',textAlign: TextAlign.start,style: TextStyle(color: ColorManager.blueprime,fontSize: AppSize.s30),)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height:150,
                                          width:130,
                                          child: PieChart(
                                            PieChartData(
                                              sections: [PieChartSectionData(
                                                color: ColorManager.green,
                                                value: 56,
                                                title: '',
                                                //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                radius: 45,
                                              ),
                                                PieChartSectionData(
                                                color: ColorManager.faintGrey,
                                                value: 88,
                                                title: '',
                                                //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                radius: 45,
                                              ),
                                              ],
                                              centerSpaceRadius: 30,
                                              centerSpaceColor: Colors.white,
                                              sectionsSpace: 2,
                                              borderData: FlBorderData(show: false),
                                              startDegreeOffset: -150,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),),
                                  ],),
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
                                  border: Border.all(width: 0.75,color: ColorManager.ContainerBorder//.withOpacity(0.2)
                                    ,),
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Color(0xFFDADEE8),
                                      blurRadius: 13.53,
                                      spreadRadius: 1,
                                      offset: Offset(-6.01, 9.02),
                                    ),
                                  ],
                                )),
                          ),
                        ],),
                      const SizedBox(height: 15,),
                      ///row 3
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                                height: 280,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 0.75,color: ColorManager.ContainerBorder//.withOpacity(0.2)
                                    ,),
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
                              padding: const EdgeInsets.symmetric(vertical:10,horizontal:10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Career progression matrics",
                                    textAlign: TextAlign.center,
                                    style: TableHeadHRDashboard.customTextStyle(context),
                                  ),
                                  Container(
                                    height: 210,
                                    child: SfCartesianChart(
                                        series: <CartesianSeries>[
                                          // Renders spline chart
                                          SplineSeries<ChartData, int>(
                                              dataSource: chartData,
                                              xValueMapper: (ChartData data, _) => data.x,
                                              yValueMapper: (ChartData data, _) => data.y
                                          )
                                        ]
                                    ),
                                  ),
                                ],
                              ),
                            ),),

                          ),
                          const SizedBox(width: 15,),
                          Expanded(
                            child: Container(
                                height: 280,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  // border: Border.all(width: 1,color: ColorManager.fmediumgrey.withOpacity(0.2),),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorManager.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      spreadRadius: 0,
                                      offset: const Offset(0, 0), // Downward shadow
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(width: 15,),
                           Expanded(
                            child: HrDashboadGraphContainer(
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text('Metrics on Ethnic Dicersity',textAlign: TextAlign.start,style: TableHeadHRDashboard.customTextStyle(context),),
                                      Container(
                                        height:200,
                                        width:180,
                                        child: PieChart(
                                          PieChartData(
                                            sections: [
                                              PieChartSectionData(
                                              color: ColorManager.green,
                                              value: 40,
                                              title: '',
                                              //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                              radius: 45,
                                            ),
                                              PieChartSectionData(
                                                color: ColorManager.faintblueweb,
                                                value: 20,
                                                title: '',
                                                //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                radius: 45,
                                              ),
                                              PieChartSectionData(
                                                color: ColorManager.faintOrange,
                                                value: 15,
                                                title: '',
                                                //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                radius: 45,
                                              ),
                                              PieChartSectionData(
                                                color: ColorManager.red,
                                                value: 25,
                                                title: '',
                                                //titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                radius: 45,
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
                                            borderData: FlBorderData(show: false),
                                            startDegreeOffset: -90,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          )
                        ],)

                    ],
                  ),
                ),
              ),
              ///listview section
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p25,right: AppPadding.p25,bottom: AppPadding.p10),
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
