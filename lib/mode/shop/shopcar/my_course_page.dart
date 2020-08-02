import 'package:courseflutter/mode/shop/discovery/bean/course_detail_bean.dart';
import 'package:courseflutter/mode/shop/discovery/view/course_button.dart';
import 'package:courseflutter/mode/shop/discovery/view/good_course_item.dart';
import 'package:courseflutter/res/resources.dart';
import 'package:courseflutter/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../shop_car_provider.dart';

///购物车页面
class ShopCarPage extends StatefulWidget {
  @override
  _ShopCarPageState createState() => _ShopCarPageState();
}

class _ShopCarPageState extends State<ShopCarPage> {
  bool isEdit = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          centerTitle: '选课单',
          actionName: isEdit ? "编辑" : "完成",
          onPressed: () => {
                setState(() {
                  isEdit = !isEdit;
                })
              }),
      body: Stack(children: <Widget>[
        Container(
          height: double.infinity,
          margin:
              EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(50)),
          child: Consumer<ShopCarProvider>(builder: (context, model, childe) {
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return buildGoodCourseItem(
                    model.listShopItem[index], index);
              },
              itemCount:
              model.listShopItem.length,
            );
          }),
        ),
        getBottomWidget()
      ]),
    );
  }

  //ListView的Item
  Widget buildGoodCourseItem(CourseDetail mCourseDetail, int index) {
    return Container(
        child: Row(
      children: <Widget>[
        Expanded(
            flex: 2,
            child: Consumer<ShopCarProvider>(builder: (context, model, childe) {
              return MaterialButton(
                onPressed: () {
                  Provider.of<ShopCarProvider>(context, listen: false)
                      .changeSelect(index);
                },
                child: model.listShopItem[index].isSelect
                    ? Images.ic_shop_select
                    : Images.ic_shop_unselect,
              );
            })),
        Expanded(
            flex: 12,
            child: Container(
                child: GoodCourseIteamView(
              mCourseDetail: mCourseDetail,
              isOnTap: false,
            )))
      ],
    ));
  }

  ///购物车底部布局
  Widget getBottomWidget() {
    return Positioned(
      width: ScreenUtil.getInstance().setWidth(750),
      height: ScreenUtil.getInstance().setHeight(120),
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black12, width: 1)),
            color: Colors.white),
        child: Consumer<ShopCarProvider>(builder: (context, model, childe) {
          return Row(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Container(
                      child: Row(children: <Widget>[
                    Consumer<ShopCarProvider>(
                        builder: (context, model, childe) {
                      return MaterialButton(
                        onPressed: () {
                          Provider.of<ShopCarProvider>(context, listen: false)
                              .changeSelectAll();
                        },
                        child: model.selectAll
                            ? Images.ic_shop_select
                            : Images.ic_shop_unselect,
                      );
                    }),
                    Text('全选',style: TextStyle(
                        fontSize: 16.0, color: Colors.black)),
                    RichText(
                        text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: '  合计:',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.grey)),
                              TextSpan(
                                  text: ' ￥${model.selectMoney}',
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.red)),
                            ]),
                        textAlign: TextAlign.center)
                  ]))),
              Expanded(
                flex: 1,
                child: CourseButton(
                  color: Colors.red,
                  text: isEdit ? "去结算 (${model.selectNum})" : "删除",
                  onTap: () {
                    if (isEdit) {
                    } else {
                      Provider.of<ShopCarProvider>(context, listen: false)
                          .deleteSelect();
                    }
                  },
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
