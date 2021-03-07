import 'package:flutter/material.dart';

import '../widgets/leaderboard_item.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          'Leaderboard',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        // ListView will contain stock widgets
        child: Padding(
          padding: const EdgeInsets.all(20),
          // replace with ListView builder and child ItemBuilder to dynamically
          // change list size
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              LeaderboardItem(
                name: 'Drew',
                balance: 10000,
              ),
              LeaderboardItem(name: 'Dhruv', balance: 5000),
              LeaderboardItem(name: 'Lohith', balance: 2500),
              LeaderboardItem(
                name: 'Zak',
                balance: 2000,
              ),
              LeaderboardItem(
                name: 'Player 5',
                balance: 1500,
              ),
              LeaderboardItem(
                name: 'Player 6',
                balance: 1000,
              ),
              LeaderboardItem(
                name: 'Player 7',
                balance: 500,
              ),
              LeaderboardItem(
                name: 'Player 8',
                balance: 100,
              ),
              LeaderboardItem(
                name: 'Player 9',
                balance: 5,
              ),
              LeaderboardItem(
                name: 'Player 10',
                balance: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
