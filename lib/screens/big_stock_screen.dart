import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../widgets/graph_big.dart';

class BigStockScreen extends StatefulWidget {
  //TODO: create boolean parameter that determines whether or not to enable
  // buying functionality.

  final String name;
  final String ticker;
  final String desc;
  final List<FlSpot> spot;

  BigStockScreen({
    this.name,
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
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green),
                    minimumSize: MaterialStateProperty.all<Size>(
                      Size(60, 30)
                    )
                  ),
                  onPressed: () {},
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
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.red),
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size(60, 30)
                  )
                ),
                onPressed: () {},
              ),
              Spacer()
                ],
              ),           
              SizedBox(
                height: 30,
              ),
              Text(
                widget.desc,
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
