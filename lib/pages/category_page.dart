import 'package:flutter/material.dart';
import 'package:flutter_shop/config/index.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KString.cartPageTitle),
      ),
      body: Container(
        child: Row(
          children: [

          ],
        ),
      ),
    );
  }
}
