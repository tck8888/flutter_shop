import 'package:flutter/material.dart';
import 'package:flutter_shop/config/index.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("购物车"),
      ),
    );
  }
}
