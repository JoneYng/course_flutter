import 'package:courseflutter/mode/shop/discovery/bean/course_detail_bean.dart';
import 'package:courseflutter/mode/shop/discovery/view/course_button.dart';
import 'package:courseflutter/mode/shop/discovery/view/shop_car.dart';
import 'package:courseflutter/routers/fluro_navigator.dart';
import 'package:courseflutter/widgets/app_bar.dart';
import 'package:courseflutter/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import '../shop_car_provider.dart';
import '../shop_router.dart';

// 定义一个常量
const kAppBar_Scroll_Offset = 100;

class CourseDetailPage extends StatefulWidget {
  CourseDetail mCourseDetail;

  CourseDetailPage(CourseDetail mCourseDetail) {
    this.mCourseDetail = mCourseDetail;
  }

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState(mCourseDetail);
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  CourseDetail mCourseDetail = new CourseDetail();
  bool _loading = true;

  // 顶部导航默认值
  double appBarAlpha = 0;

  _CourseDetailPageState(CourseDetail mCourseDetail) {
    this.mCourseDetail = mCourseDetail;
  }

  @override
  void initState() {
    _loading = false;
  }

  Future<Null> _handleRefresh() async {
    // 一种方式
    setState(() {
      _loading = false;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //移出顶部状态安全区域
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(
          child: Stack(
            //层叠布局 将自定义得appBar放在 列表上面
            children: <Widget>[
              // 移除ListView距离屏幕顶部得边距
              MediaQuery.removePadding(
                removeTop: true, //移出哪边得安全区域
                context: context,
                child: RefreshIndicator(
                    child: NotificationListener(
                      // ignore: missing_return
                      onNotification: (scrollNotification) {
                        //监听滚动
                        // 滚动变化 才监听 && 第0个元素发生滚动得时候才监听
                        if (scrollNotification is ScrollUpdateNotification &&
                            scrollNotification.depth == 0) {
                          _onScroll(scrollNotification.metrics.pixels);
                        }
                      },
                      child: Stack(
                        children: <Widget>[_listView, getBottomWidget()],
                      ),
                    ),
                    onRefresh: _handleRefresh),
              ),
              // appBar
              getAppBar(appBarAlpha),
            ],
          ),
          isLoading: _loading),
    );

    Scaffold(
      appBar: const MyAppBar(centerTitle: '课程详情', isBack: true),
      body: Text(mCourseDetail.courseTitle),
    );
  }

  // 列表
  Widget get _listView {
    return ListView(
      padding: EdgeInsets.only(
        bottom: ScreenUtil.getInstance().setHeight(100),
      ),
      children: <Widget>[
        Image.network(
            "https://oimagec4.ydstatic.com/image?id=2206197019602032596&product=xue"),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(7, 10, 7, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "￥${mCourseDetail.courseSalePrice}",
                    style: TextStyle(color: Colors.red, fontSize: 22),
                  ),
                  Text(
                    "已有${mCourseDetail.courseSaleNum}人购买",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(mCourseDetail.courseTitle,
                    style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
        Container(
          height: 50,
          color: Colors.white,
          margin: EdgeInsets.only(top: 10),
          padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "时间",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "  ${mCourseDetail.courseTime} | ${mCourseDetail.lessonNum} 课时",
                style: TextStyle(fontSize: 13),
              )
            ],
          ),
        ),
        Container(
          height: 50,
          color: Colors.white,
          margin: EdgeInsets.only(top: 10),
          padding: const EdgeInsets.fromLTRB(7, 10, 7, 4),
          child: Text("课程详情", style: TextStyle(fontSize: 20)),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: Image.network(
              "https://oimagea3.ydstatic.com/image?id=5508920566786368895&product=xue"),
        ),
        Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
            child: Image.network(
                "https://oimagea7.ydstatic.com/image?id=7064566812071219013&product=xue")),
        Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
            child: Image.network(
                "https://oimagec3.ydstatic.com/image?id=2417224011878686787&product=xue")),
      ],
    );
  }

  ///滚动监听
  _onScroll(offset) {
    print(offset);
    double alpha = offset / kAppBar_Scroll_Offset;
    // 判断滚动范围
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print("首页appbar 滚动透明度:$appBarAlpha");
  }

  ///详情页底部布局
  Widget getBottomWidget() {
    return Positioned(
      width: ScreenUtil.getInstance().setWidth(750),
      height: ScreenUtil.getInstance().setHeight(120),
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black12, width: 1)),
            color: Colors.white),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(
                      top: ScreenUtil.getInstance().setHeight(10)),
                  width: ScreenUtil.getInstance().setWidth(750),
                  height: ScreenUtil.getInstance().setHeight(88),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.headset,
                                  size: 25,
                                ),
                                Text('客服')
                              ],
                            )),
                        Consumer<ShopCarProvider>(
                          builder:(context, model, childe) {
                            return Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    ShopCarView(count: model.listShopItem.length, onTap:(){
                                      NavigatorUtils.push(context, ShopRouter.courseShopCar);
                                    }),
                                    Text('选课单')
                                  ],
                                ));
                          }
                          ,
                        ),
                      ]),
                )),
            Expanded(
              flex: 1,
              child: CourseButton(
                color: Colors.orange,
                text: "加入选课单",
                onTap: () {
                  bool isSuccess= Provider.of<ShopCarProvider>(context,listen: false).addShop(mCourseDetail);
                  if(!isSuccess){
                    showToast("课程已经在选课单中了~");
                  }
                  print('加入选课单');
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: CourseButton(
                color: Colors.red,
                text: "立即购买",
                onTap: () {
                  print('立即购买');
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // appbar
  Widget getAppBar(appBarAlpha) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: Container(
                height: 50,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                          onTap: () => {NavigatorUtils.goBack(context)},
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                          )),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                          height: 30,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text("")),
                      flex: 8,
                    ),
                    Expanded(
                      child: InkWell(
                          child: Container(
                              height: 30,
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.share,
                                size: 20,
                              ))),
                      flex: 1,
                    ),
                  ],
                )),
          ),
        ),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)],
          ),
        ),
      ],
    );
  }
}
