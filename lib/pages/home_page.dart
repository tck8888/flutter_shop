import 'package:flutter/material.dart';
import 'package:flutter_shop/config/index.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("首页"),
      ),
    );
  }
}
