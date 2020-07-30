import 'package:courseflutter/mode/shop/discovery/view/shop_car.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shop_car_provider.dart';

///发现课程标题
class FindCourseTitleView extends StatelessWidget {
  final Function leftOnTap;
  final Function centerOnTap;
  final Function rightOnTap;

  const FindCourseTitleView({
    Key key,
    this.leftOnTap,
    this.centerOnTap,
    this.rightOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: InkWell(
                  onTap: rightOnTap,
                  child: Text(
                    "上班族",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
              flex: 2,
            ),
            Expanded(
              child: InkWell(
                  onTap: rightOnTap,
                  child: Container(
                      height: 30,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: new BoxDecoration(
                        color: Colors.black12, // 底色
                        borderRadius: new BorderRadius.circular((5.0)), // 圆角度
                      ),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Icon(Icons.search,
                                  size: 15, color: Colors.grey),
                            ),
                            Text(
                              "9元名师课",
                              style:
                              TextStyle(fontSize: 12, color: Colors.grey),
                            )
                          ]))),
              flex: 8,
            ),
            Expanded(
              child: Consumer<ShopCarProvider>(
                  builder: (context, model, childe) {
                    return ShopCarView(count: model.listShopItem.length, onTap: rightOnTap);
                  }),
              flex: 1,
            ),
          ],
        ));
  }
}
