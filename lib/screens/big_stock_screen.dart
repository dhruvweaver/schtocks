import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

import '../widgets/graph_big.dart';

class BigStockScreen extends StatefulWidget {
  final String name;
  final String userName;
  final int shares;
  final String ticker;
  final String desc;
  final List<FlSpot> spot;

  BigStockScreen({
    this.name,
    this.userName,
    this.shares,
    this.ticker,
    this.desc,
    this.spot,
  });

  @override
  _BigStockScreenState createState() => _BigStockScreenState();
}

class _BigStockScreenState extends State<BigStockScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.shares);

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          widget.name,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                child: new GraphBig(spots: widget.spot),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Spacer(),
                  ElevatedButton(
                    child: Text(
                      'Buy',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(60, 30))),
                    onPressed: () {
                      http.post(
                        Uri.http('10.0.2.2:3432', '/buy'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, dynamic>{
                          'username': widget.userName,
                          'amount': 1,
                          'ticker': widget.ticker,
                        }),
                      );
                      Navigator.pop(context);
                    },
                  ),
                  Spacer(),
                  ElevatedButton(
                    child: Text(
                      'Sell',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(60, 30))),
                    onPressed: () {
                      http.post(
                        Uri.http('10.0.2.2:3432', '/sell'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, dynamic>{
                          'username': widget.userName,
                          'amount': 1,
                          'ticker': widget.ticker,
                        }),
                      );
                      Navigator.pop(context);
                    },
                  ),
                  Spacer()
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                widget.desc,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '\$' + widget.spot.last.y.toString(),
                style: TextStyle(fontSize: 20),
              ),
              widget.shares == null
                  ? Text(
                      'Shares: 0',
                      style: TextStyle(fontSize: 20),
                    )
                  : Text('Shares:' + widget.shares.toString(),
                      style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
