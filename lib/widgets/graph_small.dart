import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class GraphSmall extends StatefulWidget {
   final List<FlSpot> spots;
  GraphSmall({
    List<FlSpot> spots
  }): this.spots = spots;
  
  @override
  _GraphSmallState createState() => new _GraphSmallState(spots);
}

class _GraphSmallState extends State<GraphSmall> { 
  _GraphSmallState(this.spots);
  final List<FlSpot> spots;
  
  Color col = Colors.red;

  void initializeColor() {
    if (spots.length > 1 && spots[spots.length].y > spots[spots.length-1].y){
      col = Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return new LineChart(LineChartData(
        titlesData: FlTitlesData(
            bottomTitles: SideTitles(
              showTitles: false,
            ),
            leftTitles: SideTitles()),
        minY: 0,
        clipData:
            FlClipData(left: true, right: true, top: false, bottom: true),
        axisTitleData: FlAxisTitleData(
          show: false,        
        ),
        gridData: FlGridData(
            show: false),
        lineTouchData: LineTouchData(
            enabled: false,
        ),
        borderData: FlBorderData(show: true, border: Border()),
        lineBarsData: [
          LineChartBarData(
              colors: [col],
              isCurved: true,
              curveSmoothness: 0.1,
              barWidth: 3,
              spots: spots,
              dotData: FlDotData(show: false))
        ]));
  }
}
