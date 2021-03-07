import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class GraphBig extends StatefulWidget {
  final List<FlSpot> spots;
  GraphBig({
    List<FlSpot> spots
  }): this.spots = spots;

  @override
  _GraphBigState createState() => new _GraphBigState(spots);
}

class _GraphBigState extends State<GraphBig> { 
  _GraphBigState(this.spots);
  final List<FlSpot> spots;


  Color col = Colors.red;

  void initializeColor() {
      if (spots.length > 1 && spots[spots.length-1].y > spots[spots.length-41].y){
      col = Colors.green;
    }
  }

  String readTimestamp(double timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm:ss a');
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp ~/ 1000);
    var diff = date.difference(now);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + 'DAY AGO';
      } else {
        time = diff.inDays.toString() + 'DAYS AGO';
      }
    }

    return time;
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

    double xMargin = (xMax-xMin)/100;
    
    return LineChart(LineChartData(
        titlesData: FlTitlesData(
            bottomTitles: SideTitles(
              showTitles: true,
              getTitles: (value) {
                if (value%9==0){
                  return readTimestamp(value);
                }
                return'';
              },
            ),
            leftTitles: SideTitles()),
        minX: xMax - 60000000000,
        maxX: xMax,
        minY: 0.99 * yMin,
        maxY: 1.01 *yMax,
        clipData:
            FlClipData(left: true, right: true, top: false, bottom: true),
        axisTitleData: FlAxisTitleData(
          show: true,
          leftTitle: AxisTitle(
            showTitle: true,
            titleText: 'Price',
            textStyle: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontFamily: 'Oswald',
            ),
          ),
          bottomTitle: AxisTitle(
            showTitle: true,
            titleText: 'Time',
            textStyle: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontFamily: 'Oswald',
            ),
          ),
        ),
        gridData: FlGridData(
            show: true, drawHorizontalLine: true, horizontalInterval: 10),
        lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Color.fromRGBO(0, 0, 0, 0))),
        borderData: FlBorderData(show: true, border: Border(
          bottom: BorderSide(width: 3),
          left: BorderSide(width: 3)
        )),
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
