import 'package:flutter/foundation.dart';

class User {
  final String name;
  Map<String, int> stocks;
  double balance;

  User({
    @required this.name,
    this.stocks,
    this.balance,
  });

  factory User.fromJsonUser(String name, Map<String, dynamic> json) {
    Map<String, int> m = Map<String, int>();
    for (MapEntry<String, dynamic> m2 in json.entries) {
      for (MapEntry<String, dynamic> m3 in json[m2.key].entries) {
        if (m2.key == name) {
          m[m3.key] = m3.value.toInt();
        }
      }
    }
    return User(name: name, stocks: m);
  }
}
