import 'package:flutter/material.dart';
import 'package:schtocks/models/stock.dart';

import '../widgets/stock_card.dart';

class BuyStocksScreen extends StatefulWidget {
  List<Stock> stocksList;

  BuyStocksScreen({@required this.stocksList});

  @override
  _BuyStocksScreenState createState() => _BuyStocksScreenState();
}

class _BuyStocksScreenState extends State<BuyStocksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          'Buy Stocks',
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
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 30, bottom: 80),
            itemBuilder: (ctx, index) {
              return StockCard(
                  name: widget.stocksList[index].name,
                  ticker: widget.stocksList[index].ticker,
                  desc: widget.stocksList[index].description,
                  spot: widget.stocksList[index].spot);
            },
            itemCount: widget.stocksList.length,
          ),
        ),
      ),
    );
  }
}
