import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schtocks/screens/buy_stocks_screen.dart';
import 'dart:io';

import './widgets/stock_card.dart';
import './widgets/app_bar_builder.dart';
import './screens/buy_stocks_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      title: 'My Portfolio',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(104, 169, 116, 1),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
        ),
        canvasColor: Colors.white,
        fontFamily: 'Oswald',
        iconTheme: IconThemeData(color: Colors.black),
      ),
      home: MyHomePage(title: 'My Portfolio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _buildAppBar() {
    return Platform.isIOS
        ? AppBar(
            centerTitle: true,
            title: Text(
              widget.title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            elevation: 0,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  splashRadius: 24,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BuyStocksScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        : AppBar(
            centerTitle: true,
            title: Text(
              widget.title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            elevation: 0,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        // ListView will contain stock widgets
        child: Padding(
          padding: const EdgeInsets.all(20),
          // replace with ListView builder and child ItemBuilder to dynamically
          // change list size
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              StockCard(),
            ],
          ),
        ),
      ),
      floatingActionButton: Platform.isIOS
          ? null
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BuyStocksScreen(),
                    ),
                  );
                },
                backgroundColor: Theme.of(context).primaryColor,
                tooltip: 'Get stocks',
                child: Icon(Icons.add),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
