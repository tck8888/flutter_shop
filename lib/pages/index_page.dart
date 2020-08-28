import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/index.dart';
import 'package:flutter_shop/pages/cart_page.dart';
import 'package:flutter_shop/pages/home_page.dart';
import 'package:flutter_shop/pages/member_page.dart';
import 'package:flutter_shop/providers/current_index_provider.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home), title: Text(KString.homeTitle)),
    BottomNavigationBarItem(
        icon: Icon(Icons.category), title: Text(KString.categoryTitle)),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        title: Text(KString.shoppingCartTitle)),
    BottomNavigationBarItem(
        icon: Icon(Icons.person), title: Text(KString.memberTitle)),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CartPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    //取到当前索引状态值
    int currentIndex = context.watch<CurrentIndexProvider>().currentIndex;
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          context.read<CurrentIndexProvider>().changeIndex(index);
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      ),
    );
  }
}
