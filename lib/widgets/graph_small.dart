import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class GraphSmall extends StatefulWidget {
  List<FlSpot> spots;
  GraphSmall({
    this.spots,
  }); 
  
  @override
  _GraphSmallState createState() => new _GraphSmallState(spots);
}

class _GraphSmallState extends State<GraphSmall> { 
  _GraphSmallState(this.spots);
  List<FlSpot> spots;
  
  Color col = Colors.red;

  void initializeColor() {
    if (spots.length > 1 && spots[spots.length-1].y > spots[spots.length-41].y){
      col = Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeColor();
    double xMin = spots.first.x;
    double xMax = spots.first.x;
    double yMin = spots.first.y;
    double yMax = spots.first.y;
    for (int i = 1; i < spots.length; i++) {
      if (spots[i].x < xMin) {
        xMin = spots[i].x;
      } else if (spots[i].x > xMax) {
        xMax = spots[i].x;
      }
      if (spots[i].y < yMin) {
        yMin = spots[i].y;
      } else if (spots[i].y > yMax) {
        yMax = spots[i].y;
      }
    }

    return new LineChart(LineChartData(
        titlesData: FlTitlesData(
            bottomTitles: SideTitles(
              showTitles: false,
            ),
            leftTitles: SideTitles()),
        minX: xMax - 60000000000,
        maxX: xMax,
        minY: 0.999 * yMin,
        maxY: 1.001 *yMax,
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
