import 'package:flutter/material.dart';

class LeaderboardItem extends StatefulWidget {
  final String name;
  final double balance;
  LeaderboardItem({
    String name,
    double balance
  }): this.name = name, this.balance = balance;
  
  @override
  _LeaderboardItemState createState() => new _LeaderboardItemState(name, balance);
}

class _LeaderboardItemState extends State<LeaderboardItem> {
_LeaderboardItemState(this.name, this.balance);
final String name;
final double balance;

  @override
  Widget build(BuildContext context) {
    final bool isNull = name==null;
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
                  isNull ? '' : name,
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
            Spacer(),
            // Text('Graph placeholder'),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(Icons.show_chart),
                    splashRadius: 15,
                    onPressed:() {}
                ),
                Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      color: Theme.of(context).primaryColor
                    ),
                    Text(
                      this.balance.toString(),
                      style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).primaryColor,
                      ),
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