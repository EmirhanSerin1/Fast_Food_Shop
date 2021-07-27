import 'package:flutter/material.dart';

import 'elements/appbar_custom.dart';
import 'elements/search_box.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          buildCustomAppbar(),
          buildText("SEARCH FOR"),
          buildText("RECIPES"),
          SizedBox(height: 20),
          buildSearchBox(),
        ],
      ),
    );
  }

  Padding buildText(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 15),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 27,
        ),
      ),
    );
  }
}
