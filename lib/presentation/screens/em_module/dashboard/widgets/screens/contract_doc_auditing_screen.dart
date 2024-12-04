import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/dashboard/widgets/em_dashboard_const.dart';
import 'package:prohealth/presentation/screens/em_module/dashboard/widgets/screens/widgets/const_linear_widget.dart';
import 'package:prohealth/presentation/screens/em_module/dashboard/widgets/screens/widgets/contract_doc_const.dart';
import 'package:prohealth/presentation/screens/em_module/dashboard/widgets/screens/widgets/contract_doc_popup.dart';
import 'package:prohealth/presentation/screens/em_module/dashboard/widgets/screens/widgets/data_file.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../hr_module/dashboard/widgets/hr_dashboard_const.dart';

class ContractDocAuditingScreen extends StatefulWidget {
  const ContractDocAuditingScreen({super.key});

  @override
  State<ContractDocAuditingScreen> createState() => _ContractDocAuditingScreenState();
}

class _ContractDocAuditingScreenState extends State<ContractDocAuditingScreen> {
  int? _hoverIndex;
  final List<Map<String, dynamic>> _data = [
    {'label': '3-5 hrs\n', 'value': 25, 'color': ColorManager.blueprime.withOpacity(0.5)},
    {'label': 'Less than\n1 hrs\n', 'value': 20, 'color': ColorManager.EMFYellow},
    {'label': '1-3 hrs\n', 'value': 35, 'color': ColorManager.pieChartGreen},
    {'label': 'More\nthan\n5 hrs\n', 'value': 15, 'color': ColorManager.pieChartBlue},
  ];

  ///line graph
  final List<ChartDataLine> chartDataline = [
    ChartDataLine(2012, 30),
    ChartDataLine(2014, 25),
    ChartDataLine(2016, 50),
    ChartDataLine(2018, 30),
    ChartDataLine(2020, 20),
    ChartDataLine(2022, 34),
    ChartDataLine(2024, 40)
  ];
  final List<ChartDataLine> chartDatalineDotted = [
    ChartDataLine(2012, 40),
    ChartDataLine(2014, 55),
    ChartDataLine(2016, 30),
    ChartDataLine(2018, 40),
  ];

  List<ChartedDataLine> chartedDataline = [
    ChartedDataLine(10000, 100000),
    ChartedDataLine(11000, 200000),
    ChartedDataLine(12000, 700000),
    ChartedDataLine(13000, 150000),
    ChartedDataLine(14000, 500000),
    ChartedDataLine(15000, 200000),
  ];
  List<ChartedDataLine> chartedDatalineNew = [
    ChartedDataLine(10000, 100000),
    ChartedDataLine(11000, 150000),
    ChartedDataLine(12000, 200000),
    ChartedDataLine(13000, 150000),
    ChartedDataLine(14000, 100000),
    ChartedDataLine(15000, 50000),
  ];

  String selectedValue = "Daily";
  final List<String> items = ["Daily", "Weekly", "Monthly"];
  @override
  Widget build(BuildContext context) {
    double total = _data.fold(0, (sum, item) => sum + item['value'] as double);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
        child: Column(
          children: [
            ///first row
            Row(
              mainAxisAlignment:MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 4,
                    child: ContractDocConst()),
                SizedBox(width: AppSize.s15,),
                Expanded(
                    flex: 2,
                    child: EMDashboardContainerBBorderConst(child: LinearCardWidget(headingText: 'Total Number Of Active\nContracts', totalCount: '12', totalValue: 12,icon: Icons.save_as_outlined,),)),
                SizedBox(width: AppSize.s15,),
                Expanded(
                    flex: 2,
                    child: EMDashboardContainerBBorderConst(child: GestureDetector(
                        onTap: (){
                          showDialog(context: context, builder: (context) => ContractDocAuditPopup());
                        },
                        child: LinearCardWidget(headingText: 'Number Of Random\nAufits Passed', totalCount: '20', totalValue: 20,icon: Icons.arrow_circle_right_outlined,)),)),
                SizedBox(width: AppSize.s15,),
                Expanded(
                    flex: 2,
                    child: EMDashboardContainerBBorderConst(child: LinearCardWidget(headingText: 'Number of Non-Compliant\nOffices', totalCount: '02', totalValue: 2,icon: CupertinoIcons.building_2_fill,),)),
              ],),
            SizedBox(height: AppSize.s15,),
            ///2nd row
            Row(
              children: [
                Expanded(
                    flex: 4,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => FullScreenPopup(),
                        );
                      },
                      child: EMDashboardAllBlueSideContainer(child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:[
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: ColorManager.blueBorder,
                                    child: Icon(Icons.file_copy_outlined,color: ColorManager.white,),
                                  ),
                                  SizedBox(width: 20,),
                                  Text("Contracts Expring Soon",style: CustomTextStylesCommon.commonStyle(
                                      fontSize: 15,
                                      color: ColorManager.mediumgrey,
                                      fontWeight: FontWeight.w500),),
                                ],
                              ),
                              Text("Next 30 Days",style: CustomTextStylesCommon.commonStyle(
                                  fontSize: FontSize.s12,
                                  color: ColorManager.EMbrightred,
                                  fontWeight: FontWeight.w600),),
                            ]
                        ),
                      ),),
                    )),
                SizedBox(width: AppSize.s15,),
                Expanded(
                    flex: 2,
                    child: EMDashboardContainerBBorderConst(child: GestureDetector(
                        onTap: (){
                          showDialog(context: context, builder: (context) => ContractDocPenaltyPopup());
                        },
                        child: LinearCardWidget(headingText: 'Audit Penalty Amounts\n ', totalCount: '\$1000', totalValue: 80,icon: Icons.dangerous_outlined,)),)),
                SizedBox(width: AppSize.s15,),
                Expanded(
                    flex: 2,
                    child: EMDashboardContainerBBorderConst(child: LinearCardWidget(headingText: 'Compliance Incident\nReporting Rate', totalCount: '04', totalValue: 30,icon: Icons.lock_person_outlined,),)),
                SizedBox(width: AppSize.s15,),
                Expanded(
                    flex: 2,
                    child: EMDashboardContainerBBorderConst(child: GestureDetector(
                        onTap: (){
                          showDialog(context: context, builder: (context) => ContractDocAuditPopup());
                        },
                        child: LinearCardWidget(headingText: 'Number Of Government\nAudits Passed', totalCount: '20', totalValue: 20,icon: Icons.arrow_circle_right_outlined,)),)),
              ],),
            SizedBox(height: AppSize.s15,),
            ///3rd row
            Row(children: [
              Expanded(
                  flex: 3,
                  child: EMDashboardContainerConst(child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Average Time to Complete Internal Audit",
                        style: CustomTextStylesCommon.commonStyle(
                            fontSize: 16,
                            color: ColorManager.mediumgrey,
                            fontWeight: FontWeight.w700),),
                        MouseRegion(
                          onHover: (event) {
                            // Hover logic handled by pieTouchData
                          },
                          onExit: (_) {
                            setState(() {
                              _hoverIndex = null; // Reset hover index when the pointer leaves
                            });
                          },
                          child: SizedBox(
                            height: 200,
                            child: PieChart(
                              PieChartData(
                                sections: _data.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  var item = entry.value;

                                  bool isHovered = _hoverIndex == index;

                                  return PieChartSectionData(
                                    color: item['color'],
                                    value: item['value'].toDouble(),
                                    // Always show the label; append percentage when hovered
                                    title: isHovered
                                        ? '${item['label']} (${(item['value'] / total * 100).toStringAsFixed(1)}%)'
                                        : item['label'],
                                    radius: isHovered ? 60 : 50,
                                    titleStyle: TextStyle(
                                      fontSize: isHovered ? 12 : 10, // Slightly larger when hovered
                                      fontWeight: FontWeight.w600,
                                      color: ColorManager.mediumgrey,
                                    ),
                                  );
                                }).toList(),
                                pieTouchData: PieTouchData(
                                  touchCallback: (event, pieTouchResponse) {
                                    setState(() {
                                      _hoverIndex = pieTouchResponse?.touchedSection?.touchedSectionIndex;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        // MouseRegion(
                        //   onHover: (event) {
                        //     // Hover logic will need to be computed based on the position of the mouse.
                        //     // For now, this will simulate hover functionality.
                        //   },
                        //   onExit: (_) {
                        //     setState(() {
                        //       _hoverIndex =
                        //       null; // Reset hover index when the pointer leaves.
                        //     });
                        //   },
                        //   child: SizedBox(
                        //     height: 200,
                        //     child: PieChart(
                        //       PieChartData(
                        //         sections: _data.asMap().entries.map((entry) {
                        //           int index = entry.key;
                        //           var item = entry.value;
                        //
                        //           bool isHovered = _hoverIndex == index;
                        //
                        //           return PieChartSectionData(
                        //             color: item['color'],
                        //             value: item['value'].toDouble(),
                        //             title: isHovered
                        //                 ? '${item['label']} (${(item['value'] / total * 100).toStringAsFixed(1)}%)'
                        //                 : '',
                        //             radius: isHovered ? 60 : 50,
                        //             titleStyle: TextStyle(
                        //               fontSize: isHovered ? 10 : 0,
                        //               fontWeight: FontWeight.w600,
                        //               color: ColorManager.mediumgrey,
                        //             ),
                        //           );
                        //         }).toList(),
                        //         pieTouchData: PieTouchData(
                        //           touchCallback: (event, pieTouchResponse) {
                        //             if (pieTouchResponse?.touchedSection != null) {
                        //               setState(() {
                        //                 _hoverIndex = pieTouchResponse!
                        //                     .touchedSection!.touchedSectionIndex;
                        //               });
                        //             }
                        //           },
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Text("14:30:00 pm",
                          style: CustomTextStylesCommon.commonStyle(
                              fontSize: 18,
                              color: ColorManager.blueprime,
                              fontWeight: FontWeight.w700),),
                      ],
                    ),
                  )),
              SizedBox(width: AppSize.s15,),
              Expanded(
                  flex: 5,
                  child: EMDashboardContainerConst(child: AuditPrepTimeOffice())),
              SizedBox(width: AppSize.s15,),
              Expanded(
                  flex: 4,
                  child: EMDashboardContainerConst(child: AvgComRatingOffice())),
            ],),
            SizedBox(height: AppSize.s15,),
            ///4th row
            Row(children: [
              Expanded(
                  flex: 3,
                  child: EMDashboardContainerConst(child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Compliance Audit Frequency per Location",
                        style: CustomTextStylesCommon.commonStyle(
                          color: ColorManager.mediumgrey,
                          fontSize: FontSize.s16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        height: 240,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: SfCartesianChart(
                          primaryXAxis: NumericAxis(
                            title: AxisTitle(text: ""),
                            majorGridLines: MajorGridLines(width: 0),
                          ),
                          primaryYAxis: NumericAxis(
                            axisLabelFormatter: (AxisLabelRenderDetails details) {
                              return ChartAxisLabel(
                                '${details.value.toInt()}',
                                TextStyle(fontSize: 12),
                              );
                            },
                            majorGridLines: MajorGridLines(width: 0.5),
                          ),
                          series: <SplineSeries<ChartedDataLine, int>>[
                            // Single solid line
                            SplineSeries<ChartedDataLine, int>(
                              dataSource: chartedDataline, // Replace with your data
                              xValueMapper: (ChartedDataLine data, _) => data.x,
                              yValueMapper: (ChartedDataLine data, _) => data.y,
                              color: ColorManager.bluebottom,
                              width: 2,
                            ),
                            SplineSeries<ChartedDataLine, int>(
                              dataSource: chartedDatalineNew, // Replace with your data
                              xValueMapper: (ChartedDataLine data, _) => data.x,
                              yValueMapper: (ChartedDataLine data, _) => data.y,
                              color: ColorManager.red,
                              width: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),)),
              SizedBox(width: AppSize.s15,),
              Expanded(
                  flex: 3,
                  child: EMDashboardContainerConst(
                      child: AuditDates())),
              SizedBox(width: AppSize.s15,),
              Expanded(
                  flex: 2,
                  child: EMDashboardContainerConst(
                      child: Column(
                        children: [
                        Text(
                        "Percentage Of Offices With 100%\nCompliance score",
                        textAlign: TextAlign.center,
                        style: CustomTextStylesCommon.commonStyle(
                          fontSize: FontSize.s16,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.mediumgrey,
                        ),),
                          Container(
                            height: 200,
                            width: 180,
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
                                          radius: 60,
                                        ),
                                        PieChartSectionData(
                                          color: Colors.grey,
                                          value: 90,
                                          title: '',
                                          radius: 60,
                                        ),
                                      ],
                                      centerSpaceRadius: 30,
                                      centerSpaceColor: Colors.white,
                                      sectionsSpace: 0,
                                      borderData: FlBorderData(show: false),
                                      startDegreeOffset: 0,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "92%",
                            textAlign: TextAlign.center,
                            style: CustomTextStylesCommon.commonStyle(
                              fontSize: FontSize.s24,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.bluebottom,
                            ),)
                        ],
                      ))),
            ],),
            SizedBox(height: AppSize.s15,),
            ///5th row
            Row(children: [
              Expanded(
                  flex: 4,
                  child: EMDashboardContainerConst(
                    height: 500,
                    child: OfficeExpiringComDoc(),)),
              SizedBox(width: AppSize.s15,),
              Expanded(
                flex: 3,
                child: Column(children: [
                  EMDashboardContainerConst(
                      height: 240,
                      child: UpcomingCpmDeadlines()),
                  SizedBox(height: AppPadding.p20,),
                  EMDashboardContainerConst(
                    height: 240,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Compliance Document Update Frequency",
                          style: CustomTextStylesCommon.commonStyle(
                            color: ColorManager.mediumgrey,
                            fontSize: FontSize.s16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          height: 190,
                          padding: EdgeInsets.symmetric(horizontal: 100),
                          child: SfCartesianChart(
                            primaryXAxis: NumericAxis(
                              title: AxisTitle(text: ""),
                              majorGridLines: MajorGridLines(width: 0),
                            ),
                            primaryYAxis: NumericAxis(
                              axisLabelFormatter: (AxisLabelRenderDetails details) {
                                return ChartAxisLabel(
                                  '${details.value.toInt()}',
                                  TextStyle(fontSize: 12),
                                );
                              },
                              majorGridLines: MajorGridLines(width: 0.5),
                            ),
                            series: <SplineSeries<ChartedDataLine, int>>[
                              // Single solid line
                              SplineSeries<ChartedDataLine, int>(
                                dataSource: chartedDataline, // Replace with your data
                                xValueMapper: (ChartedDataLine data, _) => data.x,
                                yValueMapper: (ChartedDataLine data, _) => data.y,
                                color: ColorManager.EMCyan,
                                width: 2,
                              ),
                              SplineSeries<ChartedDataLine, int>(
                                dataSource: chartedDatalineNew, // Replace with your data
                                xValueMapper: (ChartedDataLine data, _) => data.x,
                                yValueMapper: (ChartedDataLine data, _) => data.y,
                                color: ColorManager.EMDCyan,
                                width: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ],),
              )
            ],),
            SizedBox(height: AppSize.s15,),
            ///6th row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p50),
              child: Row(children: [
                Expanded(flex: 3,child: EMDashboardContainerConst(child: AverageTimeAuditFindings(),)),
                SizedBox(width: AppPadding.p20,),
                Expanded(flex: 5,child: EMDashboardContainerConst(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
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
                      ],),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Contracts Price Increase Percentage Since Previous",
                            style:  CustomTextStylesCommon.commonStyle(
                                color: ColorManager.mediumgrey,
                                fontSize: FontSize.s16,
                                fontWeight: FontWeight.w700),),
                          Row(children: [
                            TextCircleConst(text: 'Latest', circleColor: ColorManager.EMDCyan,textColor: ColorManager.blackForLoginTexts,),
                            SizedBox(width:5),
                            TextCircleConst(text: 'Previous', circleColor: ColorManager.EMCyan, textColor: ColorManager.blackForLoginTexts,),
                          ],),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
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
                        SplineSeries<ChartDataLine, int>(
                            dataSource: chartDataline,
                            xValueMapper: (ChartDataLine data, _) => data.x,
                            yValueMapper: (ChartDataLine data, _) => data.y,
                          color: ColorManager.EMCyan,
                          width: 2,),
                        SplineSeries<ChartDataLine, int>(
                          dataSource: chartDatalineDotted, // Replace with your dotted line data
                          xValueMapper: (ChartDataLine data, _) => data.x,
                          yValueMapper: (ChartDataLine data, _) => data.y,
                          color: ColorManager.EMDCyan,
                          width: 2,
                          dashArray: [5, 5], // Creates a dashed effect
                        )
                      ]),
                ),],
                ),)),
              ],),
            ),
            SizedBox(height: AppSize.s15,),
          ],
        ),
      ),
    );
  }
}
