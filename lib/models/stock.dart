import 'package:flutter/foundation.dart';
import 'package:fl_chart/fl_chart.dart';

class Stock {
  final String name;
  final String ticker;
  final String description;
  final List time;
  final List price;

  Stock({
    @required this.name,
    @required this.ticker,
    @required this.description,
    @required this.time,
    @required this.price,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      name: json['name'],
      ticker: json['ticker'],
      description: json['desc'],
    );
  }
}
