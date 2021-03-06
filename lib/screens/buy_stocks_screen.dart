import 'package:flutter/material.dart';
import 'package:schtocks/widgets/app_bar_builder.dart';

import '../widgets/app_bar_builder.dart';

class BuyStocksScreen extends StatefulWidget {
  @override
  _BuyStocksScreenState createState() => _BuyStocksScreenState();
}

class _BuyStocksScreenState extends State<BuyStocksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBarBuilder('Buy Stocks'),
      ),
    );
  }
}
