import 'package:flutter/material.dart';

import '../widgets/graph_big.dart';

class BigStockScreen extends StatefulWidget {
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
          'Stock 1',
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
                child: GraphBig(),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                child: Text(
                  'Sell',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).accentColor),
                ),
                onPressed: () {},
              ),
              SizedBox(
                height: 30,
              ),
              Text('About'),
            ],
          ),
        ),
      ),
    );
  }
}
