import 'dart:convert';

import 'package:courseflutter/mode/qhdemo/main/provider/discovery_course_provider.dart';
import 'package:courseflutter/mode/qhdemo/main/qh_home_presenter.dart';
import 'package:courseflutter/mvp/base_page_state.dart';
import 'package:courseflutter/res/gaps.dart';
import 'package:courseflutter/res/resources.dart';
import 'package:courseflutter/util/load_image.dart';
import 'package:courseflutter/widgets/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'QHAdvertisingContent.dart';

///商城页面
class QhHomePage extends StatefulWidget {
  @override
  QhHomeState createState() => QhHomeState();
}

class QhHomeState extends BasePageState<QhHomePage, QhHomePresenter>
    with AutomaticKeepAliveClientMixin<QhHomePage> {
  QhHomePresenter _qhHomePresenter = new QhHomePresenter();
  QhHomeBannerProvider _qhHomeBannerProvider = new QhHomeBannerProvider();

  /// 广告位数据刷新
  void setBannerList(
      List<QHAdvertisingContent> _listCourseBanner,
      List<QHAdvertisingContent> _listDistrict,
      List<QHAdvertisingContent> _listAdvertisement,
      List<QHAdvertisingContent> _listLiveOpen) {
    _qhHomeBannerProvider.setBanner(
        _listCourseBanner, _listDistrict, _listAdvertisement,_listLiveOpen);
  }

  @override
  void initState() {
    super.initState();
    _qhHomePresenter.getAdvertInfo();
  }

  Widget getItemContainer(String item) {
    return Container(
      width: 5.0,
      height: 5.0,
      alignment: Alignment.center,
      child: Text(
        item,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      color: Colors.blue,
    );
  }

  List<String> getDataList() {
    List<String> list = [];
    for (int i = 0; i < 10; i++) {
      list.add(i.toString());
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Gaps.vGap40,
      ProviderWidget<QhHomeBannerProvider>(
        model: _qhHomeBannerProvider,
        builder: (context, model, childe) {
          if (model.listCourseBanner.length > 0) {
            return Expanded(
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: <Widget>[
                    getBanner(model.listCourseBanner),
                    getGridView(model.listDistrict),
                    getAdvertisementGridView(model.listAdvertisement),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        "直播公开课",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildItem(model.listLiveOpen[index]);
                      },
                      itemCount: model.listLiveOpen.length,
                    ),

                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      // getGridView()
    ]);
  }
  //ListView的Item
  Widget buildItem(QHAdvertisingContent qhAdvertisingContent) {
    var teacherImage="";
    var teacherName="";
    if(qhAdvertisingContent.teacherRespVOS.length>0){
      teacherImage=qhAdvertisingContent.teacherRespVOS[0].teacherHead;
      teacherName=qhAdvertisingContent.teacherRespVOS[0].name;
    }
    return Container(
      height: 120,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(5),
      margin:EdgeInsets.all(10) ,
      decoration: BoxDecoration(
        boxShadow: [//阴影效果
          BoxShadow(
            offset: Offset(0, 0),//阴影在X轴和Y轴上的偏移
            color: Colors.grey,//阴影颜色
            blurRadius: 3.0 ,//阴影程度
            spreadRadius: 2, //阴影扩散的程度 取值可以正数,也可以是负数
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
          onTap: () => {

          },
          child: Row(
            children: <Widget>[
              LoadImage(teacherImage, height: 120.0, width: 80.0),
              ConstrainedBox(
                // 可以设置宽度和高度的最大最小值
                  constraints: BoxConstraints(
                    minHeight: 120.0,
                    maxWidth: 250.0,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          qhAdvertisingContent.title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              teacherName,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Text(
                          qhAdvertisingContent.realSales.toString()+"已报名",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          "￥"+qhAdvertisingContent.sellPrice.toString(),
                          style: TextStyle(fontSize: 14,color: Colors.red),
                        ),
                      ],
                    ),
                  )),
            ],
          )),
    );
  }
  Widget getAdvertisementGridView(
      List<QHAdvertisingContent> listAdvertisement) {
    return GridView.count(
      //嵌套滑动冲突 primary + shrinkWrap
      primary: false,
      shrinkWrap: true,
      //设置滚动方向
      scrollDirection: Axis.vertical,
      //设置列数
      crossAxisCount: 2,
      //设置内边距
      padding: EdgeInsets.all(10),
      //设置横向间距
      crossAxisSpacing: 10,
      //宽高比
      childAspectRatio: 2 / 1,
      children: _getAdvertisementData(listAdvertisement),
    );
  }

  List<Widget> _getAdvertisementData(List<QHAdvertisingContent> listDistrict) {
    List<Widget> list = new List();
    for (var i = 0; i < listDistrict.length; i++) {
      list.add( Container(
          child: Image.network(
            listDistrict[i].images,
          ),
        ),
      );
    }
    return list;
  }

  Widget getGridView(List<QHAdvertisingContent> listDistrict) {
    return GridView.count(
      //嵌套滑动冲突 primary + shrinkWrap
      primary: false,
      shrinkWrap: true,
      //设置滚动方向
      scrollDirection: Axis.vertical,
      //设置列数
      crossAxisCount: 4,
      //设置内边距
      padding: EdgeInsets.all(10),
      //设置横向间距
      crossAxisSpacing: 10,
      //设置主轴间距
      mainAxisSpacing: 10,
      children: _getData(listDistrict),
    );
  }

  List<Widget> _getData(List<QHAdvertisingContent> listDistrict) {
    List<Widget> list = new List();
    for (var i = 0; i < listDistrict.length; i++) {
      list.add(Container(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(5),
                child: Image.network(
                  listDistrict[i].images,
                  // fit: BoxFit.cover,
                )),
            Text(
              listDistrict[i].title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ));
    }
    return list;
  }

  @override
  QhHomePresenter createPresenter() {
    return _qhHomePresenter;
  }

  @override
  bool get wantKeepAlive => true;

  /// banner组件
  Widget getBanner(List<QHAdvertisingContent> courseBannerList) {
    return Container(
      height: ScreenUtil().setHeight(250),
      // 高度 插件 flutter_screenutil
      child: Swiper(
        scrollDirection: Axis.horizontal,
        // 横向
        itemCount: courseBannerList.length,
        // 数量
        autoplay: true,
        // 自动翻页
        itemBuilder: (BuildContext context, int index) {
          //banner item 布局
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(courseBannerList[index].images),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          );
        },
        // 构建
        onTap: (index) {
          // var url="";
          // NavigatorUtils.goWebViewPage(context, courseBannerList[index].title, url);
          showToast("skipType:" + courseBannerList[index].skipType.toString());
        },
        // 点击事件 onTap
        pagination: SwiperPagination(
            // 分页指示器
            alignment: Alignment.bottomCenter,
            // 位置 Alignment.bottomCenter 底部中间
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            // 距离调整
            builder: DotSwiperPaginationBuilder(
                // 指示器构建
                space: ScreenUtil().setWidth(5),
                // 点之间的间隔
                size: ScreenUtil().setWidth(10),
                // 没选中时的大小
                activeSize: ScreenUtil().setWidth(12),
                // 选中时的大小
                color: Colors.black54,
                // 没选中时的颜色
                activeColor: Colors.white)),
        // 选中时的颜色
//            control: new SwiperControl(color: Colors.pink), // 页面控制器 左右翻页按钮
        viewportFraction: 0.85,
        // 当前视窗展示比例 小于1可见上一个和下一个视窗
        scale: 0.9, // 两张图片之间的间隔
      ),
    );
  }
}
