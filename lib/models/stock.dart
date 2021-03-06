import 'package:flutter/foundation.dart';

class Stock {
  final String title;
  final String abrev;
  final String description;
  final List time;
  final List price;

  Stock({
    @required this.title,
    @required this.abrev,
    @required this.description,
    @required this.time,
    @required this.price,
  });
}
