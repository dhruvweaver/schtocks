import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class GraphSmall extends StatefulWidget {
  @override
  _GraphSmallState createState() => new _GraphSmallState();
}

class _GraphSmallState extends State<GraphSmall> { 
  int _counter = 0;
  Color col = Colors.red;
  var _values = <int>[0];
  var _spots = <FlSpot>[FlSpot(0, 0)];
  var rng = new Random();

  void incrementCounter() {
    setState(() {
      _counter++;
      _values.add(_values.last + rng.nextInt(1000) - 500);
      if (_values.last < 0) {
        _values.last = 0;
      }
      _spots.add(FlSpot(_counter.toDouble(), _values.last.toDouble()));
      if (_values[_counter] > _values[_counter - 1]) {
        col = Colors.green;
      } else {
        col = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 40; i++) {
      incrementCounter();
    }
    return new LineChart(LineChartData(
        titlesData: FlTitlesData(
            bottomTitles: SideTitles(
              showTitles: false,
            ),
            leftTitles: SideTitles()),
        minX: (_counter - 40).toDouble(),
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
              spots: _spots,
              dotData: FlDotData(show: false))
        ]));
  }
}
