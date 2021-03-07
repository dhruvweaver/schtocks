import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schtocks/models/price_info.dart';
import 'package:schtocks/screens/buy_stocks_screen.dart';
import 'dart:io';

import './widgets/stock_card.dart';
import './screens/buy_stocks_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './models/stock.dart';
import './models/price_info.dart';

var stocks = [];

class AppData {
  List<Stock> stockList;

  AppData({
    this.stockList,
  });
}

Future<AppData> _fetchAllData() async {
  return AppData(stockList: await fetchAllStockInfo());
}

Future<List<Stock>> fetchAllStockInfo() async {
  final response = await http.get(Uri.http('10.0.2.2:3432', 'getAllStockInfo'));
  final responseP = await http.get(Uri.http('10.0.2.2:3432', 'getAllPrices'));

  if (response.statusCode == 200 && responseP.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Stock> stocks = [];
    Map m = Map<String, Stock>();
    List<dynamic> jsonBody = jsonDecode(response.body);
    Map<String, dynamic> jsonBody2 = jsonDecode(responseP.body);

    for (int i = 0; i < jsonBody.length; i++) {
      Stock s = Stock.fromJson(jsonBody[i]);
      stocks.add(s);
      m[s.ticker] = s;
      //pInfo.add(PriceInfo.fromJson(jsonBody2));
    }

    for (MapEntry<String, dynamic> pEntry in jsonBody2.entries) {
      PriceInfo pi = PriceInfo.fromJson(pEntry.value);
      m[pEntry.key].addSpot(pi.spot);
    }

    return stocks;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load stock info');
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      title: 'My Portfolio',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(104, 169, 116, 1),
        accentColor: Color.fromRGBO(221, 111, 114, 1),
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
  Future<AppData> _appData;

  @override
  void initState() {
    super.initState();
    _appData = _fetchAllData();
    print(_appData.then((value) => print(value.stockList[0].name)));
  }

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
                  tooltip: 'Get stocks',
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

  // _getItemCount() async {
  //   await _MyAppState() {}
  //   return _MyAppState()._appData.then((value) => value.stockList.length);
  // }

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
          child: FutureBuilder<List<Stock>>(
              future: _appData.then((value) => value.stockList),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 30, bottom: 80),
                    itemBuilder: (ctx, index) {
                      return StockCard(
                          name: snapshot.data[index].name,
                          ticker: snapshot.data[index].ticker,
                          desc: snapshot.data[index].description,
                          spot: snapshot.data[index].spot);
                    },
                    itemCount: snapshot.data.length,
                  );
                } else {
                  return Text('No data');
                }
              }),
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
