import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double? y;
}

class ComboChartData {
  ComboChartData(this.x, this.y, this.y1,);
  final String x;
  final double? y;
  final double? y1;

}