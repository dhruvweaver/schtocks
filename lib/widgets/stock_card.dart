import 'package:flutter/material.dart';
import 'package:schtocks/widgets/graph_small.dart';
import 'package:schtocks/widgets/graph_big.dart';


class StockCard extends StatefulWidget {
  @override
  _StockCardState createState() => _StockCardState();
}

class _StockCardState extends State<StockCard> {
  
  @override
  Widget build(BuildContext context) {
    GraphSmall g = GraphSmall();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  'Stock 1',
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
            Spacer(),
            SizedBox(
              child: g,
              height: 100,
              width: 200
            ),
            // Text('Graph placeholder'),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                    splashRadius: 15,
                    onPressed:() {}
                ),
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
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
