import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/dashboard/widgets/dataModel_barchart.dart';
import 'package:prohealth/presentation/screens/hr_module/dashboard/widgets/hr_dashboard_const.dart';

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
  List<DataModel> _list = List<DataModel>.empty(growable:true);
  List<BarChartGroupData> _chartGroups(){
    List<BarChartGroupData> list = List<BarChartGroupData>.empty(growable: true);
    for(int i = 0; i< _list.length; i++){
      list.add(BarChartGroupData(x: i, barRods: [BarChartRodData(toY: double.parse(_list[i].value!), color:ColorManager.barChartBlue)]));
    }
    return list;
  }
  SideTitles get _bottomTitles => SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta){
        String text ='';
        switch (value.toInt()){
          case 0:
            text = 'Sat';
            break;

          case 1:
            text = 'Sun';
            break;

          case 2:
            text = 'Mon';
            break;

          case 3:
            text = 'Tus';
            break;

          case 4:
            text = 'Wed';
            break;

          case 5:
            text = 'Thu';
            break;

          case 6:
            text = 'Fri';
            break;

        }
        return Text(text,style: TextStyle(fontSize: 10),);
      }
  );

  /// pie chart data
  List<PieChartSectionData> _getSections() {
    return [
      PieChartSectionData(
        color: ColorManager.pieChartGreen,
        value: 34,
        title: '34%',
        titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
        radius: 45,
      ),
      PieChartSectionData(
        color: ColorManager.pieChartBBlue,
        value: 7,
        title: '7%',
        titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
        radius: 40,
      ),
      PieChartSectionData(
        color: ColorManager.pieChartBlue,
        value: 60,
        title: '60%',
        titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
        radius: 40,
      ),
    ];
  }
  @override
  void initState() {
    super.initState();
    _list.add(DataModel(key:"0",value: "10"));
    _list.add(DataModel(key:"10%",value: "6"));
    _list.add(DataModel(key:"20%",value: "8"));
    _list.add(DataModel(key:"30%",value: "4"));
    _list.add(DataModel(key:"40%",value: "6"));
    _list.add(DataModel(key:"50%",value: "7"));
    _list.add(DataModel(key:"60%",value: "2"));
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
                    decoration: BoxDecoration(color:Color(0xFFE9F2F5),// Color(0xFFF2F9FC),
                      borderRadius: const BorderRadius.only(
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
                      padding: EdgeInsets.symmetric(vertical: 40,horizontal: 80),
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
                          SizedBox(width: 25,),
                          Expanded(
                            child: HrDashboardContainerConst(
                              headText: "New Joining's",
                              headSubTextColor: ColorManager.blueDash,
                              subText: "03",
                              imageTile: 'images/hr_dashboard/joinies.png',
                              imageTileColor: ColorManager.blueDash.withOpacity(0.8),
                            ),
                          ),

                          SizedBox(width: 25,),
                          Expanded(
                            child: HrDashboardContainerConst(
                              headText: "Today’s Attendance",
                              headSubTextColor: ColorManager.pink,
                              subText: "90%",
                              imageTile: 'images/hr_dashboard/attendies.png',
                              imageTileColor: ColorManager.pink.withOpacity(0.8),
                            ),
                          ),
                          SizedBox(width: 25,),
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
                                  child: BarChart(
                                    BarChartData(
                                      backgroundColor: ColorManager.white,
                                      barGroups: _chartGroups(),
                                      borderData: FlBorderData(
                                        border: Border(bottom: BorderSide(),left: BorderSide())
                                      ),
                                      gridData: FlGridData(show: false),
                                      titlesData: FlTitlesData(
                                        bottomTitles: AxisTitles(sideTitles: _bottomTitles),
                                        leftTitles:AxisTitles(sideTitles: SideTitles(
                                          showTitles:true,
                                          interval:1,
                                          getTitlesWidget: (value, meta){
                                            return Text(value.toString(),style:TextStyle(fontSize: 10));
                                          }
                                        )),
                                        topTitles: AxisTitles(sideTitles:SideTitles(showTitles:false)),
                                        rightTitles:AxisTitles(sideTitles:SideTitles(showTitles:false)),
                                      ),
                                    )
                                  ),
                                ),
                              ],
                            ),
                          )
                        )),
                        SizedBox(width: 15,),
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
                        SizedBox(width: 15,),
                        Expanded(flex:2,
                            child: HrDashboadGraphContainer(child: Container(),)),
                      ],),
                      SizedBox(height: 15,),
                      ///row 2
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: HrDashboadGraphContainer(
                              child: Row(),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(children: [
                                    HrDashboardSmallcontainer(child: Row(),),
                                    SizedBox(height: 10,),
                                    HrDashboardSmallcontainer(child: Row(),),
                                  ],),
                                ),
                                SizedBox(width: 15,),
                                Expanded(
                                  child: Column(children: [
                                    HrDashboardSmallcontainer(child: Row(),),
                                    SizedBox(height: 10,),
                                    HrDashboardSmallcontainer(child: Row(),),
                                  ],),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(width: 15,),
                          Expanded(
                            child: Container(
                                height: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 0.75,color: ColorManager.ContainerBorder//.withOpacity(0.2)
                                    ,),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFDADEE8),
                                      blurRadius: 13.53,
                                      spreadRadius: 1,
                                      offset: const Offset(-6.01, 9.02),
                                    ),
                                  ],
                                )),
                          ),
                        ],),
                      SizedBox(height: 15,),
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
                                  BoxShadow(
                                    color: Color(0xFFDADEE8),
                                    blurRadius: 13.53,
                                    spreadRadius: 1,
                                    offset: const Offset(-6.01, 9.02),
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(width: 15,),
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
                        SizedBox(width: 15,),
                        Expanded(
                          child: HrDashboadGraphContainer(
                            child: Row(),
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
                      HrDashboardListviewHeading(),
                      SizedBox(height: AppSize.s10),
                      ///
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 15,
                          itemBuilder: (context, index) {
                            //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                           // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                           // EmployeeDocumentModal employeedoc = paginatedData[index];
                            return Column(
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
