import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/config/index.dart';
import 'package:flutter_shop/providers/current_index_provider.dart';
import 'package:provider/provider.dart';

import 'pages/index_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CurrentIndexProvider()),
      ],
      child: Container(
        child: MaterialApp(
          title: KString.mainTitle,
          //Flutter女装商城
          debugShowCheckedModeBanner: false,
          //定制主题
          theme: ThemeData(
            primaryColor: KColor.primaryColor,
          ),
          home: IndexPage(),
        ),
      ),
    );
  }
}
