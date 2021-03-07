import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PriceInfo {
  // final String ticker;
  final List<FlSpot> spot;

  PriceInfo({
    // @required this.ticker,
    @required this.spot,
  });

  factory PriceInfo.fromJson(List<dynamic> json) {
    // String t = '';
    List<FlSpot> l = [];
    for (Map<String, dynamic> p in json) {
      // print(p['Time'] + 100000);
      l.add(
        FlSpot(
          p['Time'].toDouble(),
          double.parse(p['Price'].toStringAsFixed(2)),
        ),
      );
    }

    return PriceInfo(
      spot: l,
      // ticker: t,
    );
  }
}
