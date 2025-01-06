import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import '../../../../../app/resources/color.dart';

class VisitsForCliniciansGraph extends StatefulWidget {
  @override
  State<VisitsForCliniciansGraph> createState() => _VisitsForCliniciansGraphState();
}

class _VisitsForCliniciansGraphState extends State<VisitsForCliniciansGraph> {

  String selecteBillingValue = 'Billing Cycle';
  List<String> dropdownBillingValue = ['Billing Cycle', '2', '3'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(47.0),
        shadowColor: Color(0xffD8D2FCA3).withOpacity(0.64),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(47.0),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                offset: Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Number of Visits for Clinicians',
                      style: TextStyle(
                        color: Color(0xff271E4A),
                        fontSize: FontSize.s16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DropdownButton<String>(
                          value: selecteBillingValue,
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: Color(0xff686464), size: 18),
                          underline: Container(
                            height: 0,
                            color: Colors.transparent,
                          ),
                          items: dropdownBillingValue
                              .map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: MediaQuery.of(context).size.width * 0.008, //12
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff686464),
                                    ),
                                  ),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selecteBillingValue = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height/40),
                Expanded(
                  child: LineChart(
                    LineChartData(
                      minY: 0,
                      maxY: 40,
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(1, 10),
                            FlSpot(2, 35),
                            FlSpot(3, 10),
                            FlSpot(4, 25),
                            FlSpot(5, 25),
                            FlSpot(6, 15),
                            FlSpot(7, 5),
                            FlSpot(8, 0),
                          ],
                          isCurved: true,
                          color: Color(0xffD8D2FC),
                          barWidth: 4,
                          belowBarData: BarAreaData(show: false),
                          dotData: FlDotData(show: false),
                        ),
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 0),
                            FlSpot(1, 20),
                            FlSpot(2, 25),
                            FlSpot(3, 21),
                            FlSpot(4, 17),
                            FlSpot(5, 15),
                            FlSpot(6, 18),
                            FlSpot(7, 25),
                            FlSpot(8, 40),
                          ],
                          isCurved: true,
                          color: Color(0xffE3A3E0),
                          barWidth: 4,
                          belowBarData: BarAreaData(show: false),
                          dotData: FlDotData(show: false),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            interval: 10, // Set the interval to avoid overlapping
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: TextStyle(
                                  color: Color(0xffB6B6B6),
                                  fontSize: FontSize.s16,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1, // Set the interval to avoid overlapping
                            getTitlesWidget: (value, meta) {
                              final style = TextStyle(
                                  color: ColorManager.darkblue,
                                  fontWeight: FontWeight.w400,
                                  fontSize: FontSize.s16
                              );
                              switch (value.toInt()) {
                                case 0:
                                  return Text('RN', style: style);
                                case 1:
                                  return Text('COTA', style: style);
                                case 2:
                                  return Text('HHA', style: style);
                                case 3:
                                  return Text('MSW', style: style);
                                case 4:
                                  return Text('PTA', style: style);
                                case 5:
                                  return Text('OT', style: style);
                                case 6:
                                  return Text('LVN', style: style);
                                case 7:
                                  return Text('PT', style: style);
                                case 8:
                                  return Text('ST', style: style);
                                default:
                                  return Text('');
                              }
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,                      // Disable vertical lines
                        drawHorizontalLine: true,                    // Enable horizontal lines
                        horizontalInterval: 10,                     // Interval for horizontal lines
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Color(0xffe7e8ec),               // Color of the horizontal lines
                            strokeWidth: 1,                        // Width of the horizontal lines
                          );
                        },
                      ),
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
