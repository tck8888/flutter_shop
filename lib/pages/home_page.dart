import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/index.dart';
import 'package:flutter_shop/service/http_service.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  //防止刷新处理，保持当前状态
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('首頁刷新了');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      appBar: AppBar(
        title: Text(KString.homeTitle),
      ),
      body: FutureBuilder(
        future: request('homePageContext', formData: null),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            print(data);

            List<Map> swiperDataList = (data['data']['slides'] as List).cast();
            List<Map> navigatorList = (data['data']['category'] as List).cast();
            List<Map> recommendList = (data['data']['recommend'] as List).cast(); //商品推荐
            //List<Map> floor1 = (data['data']['floor1'] as List).cast();
            //List<Map> floor1Pic = (data['data']['floor1Pic'] as List).cast();

            return EasyRefresh(
              onRefresh: () async {
                print("下拉刷新");
              },
              onLoad: () async {
                print("上拉加载");
              },
              child: ListView(
                children: [
                  SwiperDiy(swiperDataList: swiperDataList),
                  TopNavigator(
                    navigatorList: navigatorList,
                  ),
                  RecommendUI(
                    recommandList: recommendList,
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('加载中...'),
            );
          }
        },
      ),
    );
  }
}

class RecommendUI extends StatelessWidget {

  final List recommandList;

  RecommendUI({Key key, this.recommandList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList(context),
        ],
      ),
    );
  }
  //推荐商品标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom: BorderSide(width: 0.5, color: KColor.defaultBorderColor)),
      ),
      child: Text(
        KString.recommendText, //'商品推荐',
        style: TextStyle(color: KColor.homeSubTitleTextColor),
      ),
    );
  }

  //商品推荐列表
  Widget _recommendList(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(280),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommandList.length,
          itemBuilder: (context, index) {
            return _item(index, context);
          }),
    );
  }

  Widget _item(index, context) {
    return InkWell(
      onTap: () {
        // Application.router.navigateTo(
        //     context, "/detail?id=${recommandList[index]['goodsId']}");
      },
      child: Container(
        width: ScreenUtil().setWidth(280),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5, color: KColor.defaultBorderColor),
          ),
        ),
        child: Column(
          children: <Widget>[
            //仿止溢出
            Expanded(
              child: Image.network(
                recommandList[index]['image'],
                fit: BoxFit.contain,
              ),
            ),
            Text(
              '￥${recommandList[index]['presentPrice']}',
              style: TextStyle(color: KColor.presentPriceTextColor),
            ),
            Text(
              '￥${recommandList[index]['oriPrice']}',
              style: KFont.oriPriceStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item, index) {
    return InkWell(
      onTap: () {
        //跳转到分类页面
        _goCategory(context, index, item['firstCategoryId']);
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['firstCategoryName'])
        ],
      ),
    );
  }

  //跳转到分类页面
  void _goCategory(context, int index, String categoryId) async {
    await request('getCategory', formData: null).then((val) {
      var data = json.decode(val.toString());
      // CategoryModel category = CategoryModel.fromJson(data);
      // List list = category.data;
      // Provider.of<CategoryProvider>(context)
      //     .changeFirstCategory(categoryId, index);
      // Provider.of<CategoryProvider>(context)
      //     .getSecondCategory(list[index].secondCategoryVO, categoryId);
      // Provider.of<CurrentIndexProvider>(context).changeIndex(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (navigatorList.length > 10) {
      navigatorList.removeRange(10, navigatorList.length);
    }
    var tempIndex = -1;
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 5.0),
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        //禁止滚动
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(4.0),
        children: navigatorList.map((item) {
          tempIndex++;
          return _gridViewItemUI(context, item,tempIndex);
        }).toList(),
      ),
    );
  }
}

//首页轮播组件编写
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {
                // Application.router.navigateTo(
                //     context, "/detail?id=${swiperDataList[index]['goodsId']}");
              },
              child: Image.network(
                "${swiperDataList[index]['image']}",
                fit: BoxFit.cover,
              ));
        },
        //图片数量
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
