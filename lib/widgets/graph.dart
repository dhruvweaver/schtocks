import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class Graph extends StatefulWidget {
  final bool isExpanded;
  Graph({
    bool isExpanded
  }): this.isExpanded = isExpanded;

  _GraphState createState() => _GraphState(isExpanded);
}

class _GraphState extends State<Graph> {
  _GraphState(this.isExpanded);
  bool isExpanded;
  
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
    return LineChart(LineChartData(
        titlesData: FlTitlesData(
            bottomTitles: SideTitles(
              showTitles: this.isExpanded,
              getTitles: (value) {
                if (value.toInt() % 12 == 0) {
                  return ((value % 144) ~/ 12).toString() + ':00';
                }
                return '';
              },
            ),
            leftTitles: SideTitles()),
        minX: (_counter - 40).toDouble(),
        minY: 0,
        extraLinesData: ExtraLinesData(horizontalLines: [
          HorizontalLine(y: 0, strokeWidth: this.isExpanded ? 1 : 0, label: HorizontalLineLabel())
        ]),
        clipData:
            FlClipData(left: true, right: true, top: false, bottom: true),
        axisTitleData: FlAxisTitleData(
          show: this.isExpanded,
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
            show: this.isExpanded, drawHorizontalLine: true, horizontalInterval: 1000),
        lineTouchData: LineTouchData(
            enabled: this.isExpanded,
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
