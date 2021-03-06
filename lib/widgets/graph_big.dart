import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class GraphBig extends StatefulWidget {
  final List<int> times;
  final List<double> prices;
  GraphBig({
    List<int> times,
    List<double> prices
  }): this.times = times, this.prices = prices;

  @override
  _GraphBigState createState() => new _GraphBigState(times, prices);
}

class _GraphBigState extends State<GraphBig> { 
  _GraphBigState(this.times, this.prices);
  final List<int> times;
  final List<double> prices;

  Color col = Colors.red;
  var _spots = <FlSpot>[];

  void initializeSpots() {
    for (int i = 0; i < times.length; i++) {
      _spots.add(FlSpot(times[i].toDouble(), prices[i]));
    }

    if (prices.length > 1 && prices[prices.length] > prices[prices.length-1]){
      col = Colors.green;
    }
  }

  String readTimestamp(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm a');
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
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
    initializeSpots();
    
    return new LineChart(LineChartData(
        titlesData: FlTitlesData(
            bottomTitles: SideTitles(
              showTitles: true,
              getTitles: (value) {
                return readTimestamp(value.toInt());
              },
            ),
            leftTitles: SideTitles()),
        minY: 0,
        extraLinesData: ExtraLinesData(horizontalLines: [
          HorizontalLine(y: 0, strokeWidth: 1, label: HorizontalLineLabel())
        ]),
        clipData:
            FlClipData(left: true, right: true, top: false, bottom: true),
        axisTitleData: FlAxisTitleData(
          show: true,
          leftTitle: AxisTitle(
            showTitle: true,
            titleText: 'Value',
            textStyle: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontFamily: 'Oswald',
            ),
          ),
          bottomTitle: AxisTitle(
            showTitle: true,
            titleText: 'Time',
            textStyle: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontFamily: 'Oswald',
            ),
          ),
        ),
        gridData: FlGridData(
            show: true, drawHorizontalLine: true, horizontalInterval: 1000),
        lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Color.fromRGBO(0, 0, 0, 0))),
        borderData: FlBorderData(show: true, border: Border()),
        lineBarsData: [
          LineChartBarData(
              colors: [col],
              isCurved: true,
              curveSmoothness: 0.1,
              barWidth: 3,
              spots: _spots,
              dotData: FlDotData(show: false))
        ]));
  }
}
