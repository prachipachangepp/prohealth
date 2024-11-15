import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/dashboard/widgets/dataModel_barchart.dart';
import 'package:prohealth/presentation/screens/hr_module/dashboard/widgets/hr_dashboard_const.dart';

import '../../../../app/resources/color.dart';

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
      list.add(BarChartGroupData(x: i, barRods: [BarChartRodData(toY: double.parse(_list[i].value!), color:ColorManager.blueprime)]));
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
        color: Colors.lightBlueAccent,
        value: 34,
        title: '34%',
        titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.redAccent,
        value: 2,
        title: '2%',
        titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
        radius: 40,
      ),
      PieChartSectionData(
        color: Colors.greenAccent,
        value: 64,
        title: '64%',
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

              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p15,right: AppPadding.p15,bottom: AppPadding.p10),
                child: Container(
                  height: AppSize.s700,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p10,horizontal: 5),
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(flex:3, child: Container(height: 250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            // border: Border.symmetric(vertical: BorderSide.none,horizontal: BorderSide(width: 1,color: Color(0xFFBCBCBC)),),//all(width: 1, color: Color(0xFFBCBCBC)),
                            boxShadow: [
                              BoxShadow(
                                color: ColorManager.fmediumgrey.withOpacity(0.2),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: const Offset(0, 3), // Downward shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical:5,horizontal:5),
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
                          )
                        )),
                        SizedBox(width: 15,),
                        Expanded(flex:1, child: Container(height: 250,
                          decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          // border: Border.symmetric(vertical: BorderSide.none,horizontal: BorderSide(width: 1,color: Color(0xFFBCBCBC)),),//all(width: 1, color: Color(0xFFBCBCBC)),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.fmediumgrey.withOpacity(0.2),
                              blurRadius: 2,
                              spreadRadius: 1,
                              offset: const Offset(0, 3), // Downward shadow
                            ),
                          ],
                        ),
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
                        Expanded(flex:2, child: Container(height: 250,
                            decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          // border: Border.symmetric(vertical: BorderSide.none,horizontal: BorderSide(width: 1,color: Color(0xFFBCBCBC)),),//all(width: 1, color: Color(0xFFBCBCBC)),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.fmediumgrey.withOpacity(0.2),
                              blurRadius: 2,
                              spreadRadius: 1,
                              offset: const Offset(0, 3), // Downward shadow
                            ),
                          ],
                        ),
                        child:SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(height:25,
                                  color: Colors.lightBlueAccent.withOpacity(0.3),
                                  child:Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Row(
                                      children: [
                                    Expanded(child: Text('Sr',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500))),
                                    Expanded(child: Text('Rates',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500))),
                                    Expanded(child: Text('Percentage',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500))),
                                      ],
                                    ),
                                  )),
                              Container(
                                height: 150,
                                child: ListView.builder(
                                  itemCount: 5,
                                    itemBuilder: (context, index){
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(child: Text('01',style: TextStyle(fontSize: 10))),
                                            Expanded(child: Text('Offer Acceptance Rate',style: TextStyle(fontSize: 10))),
                                            Expanded(child: Text('15%',style: TextStyle(fontSize: 10),))
                                          ],
                                        ),
                                       Padding(
                                         padding: const EdgeInsets.all(2.0),
                                         child: Divider(color: ColorManager.faintGrey,height: 1,),
                                       )
                                      ],
                                    );
                                }),
                              )
                            ],
                          ),
                        ))),
                      ],),
                      Center(
                        child: Text("widget.headText",
                          style: CustomTextStylesCommon.commonStyle(fontSize: 16,
                              color: ColorManager.black,fontWeight: FontWeight.w600),),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p25,right: AppPadding.p25,bottom: AppPadding.p10),
                child: Container(
                  height: AppSize.s800,
                  color: Colors.grey,
                  child: Column(
                    children: [
                      Center(
                        child: Text("widget.headText",
                          style: CustomTextStylesCommon.commonStyle(fontSize: 16,
                              color: ColorManager.black,fontWeight: FontWeight.w600),),
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
