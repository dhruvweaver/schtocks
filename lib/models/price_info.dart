import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PriceInfo {
  final List<FlSpot> spot;

  PriceInfo({
    @required this.spot,
  });

  factory PriceInfo.fromJson(List<dynamic> json) {
    // String t = '';
    List<FlSpot> l = [];
    for (Map<String, dynamic> p in json) {
      l.add(
        FlSpot(
          p['Time'].toDouble(),
          double.parse(p['Price'].toStringAsFixed(2)),
        ),
      );
    }

    return PriceInfo(
      spot: l,
    );
  }
}
