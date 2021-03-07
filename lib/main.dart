import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schtocks/models/price_info.dart';
import 'package:schtocks/screens/buy_stocks_screen.dart';
import 'dart:io';

import './widgets/stock_card.dart';
import './screens/buy_stocks_screen.dart';
import './screens/leaderboard_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './models/stock.dart';
import './models/price_info.dart';
import 'models/user.dart';

var stocks = [];

class AppData {
  List<Stock> stockList;
  User user;

  AppData({
    this.stockList,
    this.user,
  });
}

Future<AppData> _fetchAllData() async {
  List<dynamic> r = [];
  try {
    r = await Future.wait([fetchAllStockInfo(), fetchAllUserInfo()]);
  } catch (e) {
    print(e);
  }
  return AppData(
    stockList: r[0],
    user: r[1],
  );
}

Future<List<Stock>> fetchAllStockInfo() async {
  final response = await http.get(Uri.http('10.0.2.2:3432', 'getAllStockInfo'));
  final responseP = await http.get(Uri.http('10.0.2.2:3432', 'getAllPrices'));
  // final response = Platform.isIOS
  //     ? await http.get(Uri.http('localhost:3432', 'getAllStockInfo'))
  //     : await http.get(Uri.http('10.0.2.2:3432', 'getAllStockInfo'));
  // final responseP = Platform.isIOS
  //     ? await http.get(Uri.http('localhost:3432', 'getAllPrices'))
  //     : await http.get(Uri.http('10.0.2.2:3432', 'getAllPrices'));

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

Future<User> fetchAllUserInfo() async {
  final response =
      await http.get(Uri.http('10.0.2.2:3432', 'getUserSummaries'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    User userStocks;

    print(response.body);
    Map<String, dynamic> jsonBody = jsonDecode(response.body);
    userStocks = User.fromJsonUser('Zak', jsonBody);

    return userStocks;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user info');
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
  }

  Widget _buildAppBar(List<Stock> stocks) {
    return Platform.isIOS
        ? AppBar(
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: IconButton(
                tooltip: 'Leaderboard',
                splashRadius: 24,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LeaderboardScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.leaderboard_outlined,
                  color: Colors.black,
                ),
              ),
            ),
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
                        builder: (context) => BuyStocksScreen(
                          stocksList: stocks,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        : AppBar(
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: IconButton(
                tooltip: 'Leaderboard',
                splashRadius: 24,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LeaderboardScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.leaderboard_outlined,
                  color: Colors.black,
                ),
              ),
            ),
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

  List<Stock> userStockConverter(User user, List<Stock> allStocks) {
    List<Stock> userStocks = [];
    if (user.stocks == null) {
      return userStocks;
    }

    for (MapEntry<String, int> pair in user.stocks.entries) {
      for (int i = 0; i < allStocks.length; i++) {
        if (pair.key == allStocks[i].ticker) {
          userStocks.add(allStocks[i]);
        }
      }
    }

    return userStocks;
  }

  // onGoBack(dynamic value) {
  //   initState();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    // List<Stock> stocks;
    // List<Stock> userStocks;
    Future<List<Stock>> stocksF = _appData.then((value) => value.stockList);
    Future<User> userF = _appData.then((value) => value.user);
    User user;
    String userName;
    List<Stock> stocks;
    List<Stock> userStocks;

    return Scaffold(
      appBar: _buildAppBar(stocks),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder(
            future: Future.wait([stocksF, userF]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              user = snapshot.data[1];
              stocks = snapshot.data[0];
              userStocks = userStockConverter(snapshot.data[1], stocks);
              userName = user.name;
              print(user.stocks['FDAS']);
              if (userStocks.length > 0) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(top: 30, bottom: 80),
                  itemBuilder: (ctx, index) {
                    print(index);
                    return StockCard(
                        name: userStocks[index].name,
                        username: userName,
                        shares: user.stocks[userStocks[index].ticker],
                        ticker: userStocks[index].ticker,
                        desc: userStocks[index].description,
                        spot: userStocks[index].spot);
                  },
                  itemCount: userStocks.length,
                );
              } else {
                print(userName);
                return Text(
                  'Buy some stocks!',
                  style: TextStyle(fontSize: 20),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: Platform.isIOS
          ? null
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: () async {
                  final value = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BuyStocksScreen(
                        stocksList: stocks,
                        userName: userName,
                        userStocks: user.stocks,
                      ),
                    ),
                  );
                  setState(() {
                    _appData = _fetchAllData();
                  });
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
