import 'package:flutter/foundation.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:schtocks/models/price_info.dart';

class Stock {
  final String name;
  final String ticker;
  final String description;
  List<FlSpot> spot;

  Stock({
    @required this.name,
    @required this.ticker,
    @required this.description,
  });

  void addSpot(List<FlSpot> s) {
    this.spot = s;
  }

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      name: json['name'],
      ticker: json['ticker'],
      description: json['desc'],
    );
  }
}
