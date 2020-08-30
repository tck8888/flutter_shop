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
            // List<Map> category = (data['data']['category'] as List).cast();
            // List<Map> recommend = (data['data']['recommend'] as List).cast();
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
                  SwiperDiy( swiperDataList: swiperDataList,)
                ],
              ),
            );
          } else {
            return Container(
              child: Text('加载中...'),
            );
          }
        },
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

