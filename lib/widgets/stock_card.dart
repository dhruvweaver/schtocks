import 'package:flutter/material.dart';

import '../screens/big_stock_screen.dart';
import '../widgets/graph_small.dart';

class StockCard extends StatefulWidget {
  @override
  _StockCardState createState() => _StockCardState();
}

class _StockCardState extends State<StockCard> {
  @override
  Widget build(BuildContext context) {
    GraphSmall g = GraphSmall();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BigStockScreen(),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stock 1',
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'TCKR',
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
              Spacer(),
              SizedBox(child: g, height: 100, width: 200),
              // Text('Graph placeholder'),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '38%',
                        style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_upward_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
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
