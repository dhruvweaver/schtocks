import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:schtocks/widgets/graph_big.dart';
import 'package:sprintf/sprintf.dart';

import '../screens/big_stock_screen.dart';
import '../widgets/graph_small.dart';

class StockCard extends StatefulWidget {
  final String name;
  final String username;
  final int shares;
  final String ticker;
  final String desc;
  final List<FlSpot> spot;

  StockCard({
    this.name,
    this.username,
    this.shares,
    this.ticker,
    this.desc,
    this.spot,
  });

  @override
  _StockCardState createState() => _StockCardState();
}

class _StockCardState extends State<StockCard> {
  PageController pageController;

  @override
  void initState() {
    super.initState();

    /// Instantiate the PageController in initState.
    pageController = PageController();
  }

  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }

  @override
  Widget build(BuildContext context) {
    double percentChange = (((widget.spot[widget.spot.length - 1].y -
                widget.spot[widget.spot.length - 41].y) /
            widget.spot[widget.spot.length - 41].y) *
        100);
    print(widget.shares);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BigStockScreen(
                name: widget.name,
                userName: widget.username,
                shares: widget.shares,
                ticker: widget.ticker,
                desc: widget.desc,
                spot: widget.spot),
          ),
        );
        setState(() {});
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      child: Text(
                        truncateWithEllipsis(30, widget.name),
                        style: TextStyle(fontSize: 22),
                      ),
                      width: 100),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.ticker,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              Spacer(),
              SizedBox(
                  child: new GraphSmall(spots: widget.spot),
                  height: 50,
                  width: 125),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        sprintf("%.2f", [percentChange]) + '%',
                        style: TextStyle(
                            fontSize: 22,
                            color:
                                percentChange > 0 ? Colors.green : Colors.red),
                      ),
                      Icon(
                          percentChange > 0
                              ? Icons.arrow_upward_rounded
                              : Icons.arrow_downward_rounded,
                          color: percentChange > 0 ? Colors.green : Colors.red),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
