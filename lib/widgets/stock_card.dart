import 'package:flutter/material.dart';

class StockCard extends StatefulWidget {
  @override
  _StockCardState createState() => _StockCardState();
}

class _StockCardState extends State<StockCard> {
  @override
  Widget build(BuildContext context) {
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
            Text('Graph placeholder'),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                    splashRadius: 15,
                    onPressed: () {}),
                Row(
                  children: [
                    Text(
                      '38%',
                      style: TextStyle(fontSize: 22),
                    ),
                    Icon(
                      Icons.arrow_upward_rounded,
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