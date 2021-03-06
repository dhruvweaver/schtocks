import 'package:flutter/material.dart';
// import 'dart:io';

class AppBarBuilder extends StatelessWidget {
  final String title;

  AppBarBuilder(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
      ),
      elevation: 0,
      // actions: Platform.isIOS
      //     ? <Widget>[
      //         Padding(
      //           padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
      //           child: IconButton(
      //             icon: Icon(
      //               Icons.add,
      //               color: Colors.black,
      //             ),
      //             splashRadius: 24,
      //             onPressed: () {},
      //           ),
      //         ),
      //       ]
      //     : null,
    );
  }
}
