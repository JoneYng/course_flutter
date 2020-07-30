import 'package:courseflutter/mode/login/person/person_detail_item.dart';
import 'package:courseflutter/res/resources.dart';
import 'package:courseflutter/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(centerTitle: '', isBack: false),
      body: ListView(children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            height: 70,
            child: Row(
              children: <Widget>[
                Container(
                    width: 70,
                    height: 70,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://upload.jianshu.io/users/upload_avatars/2268884/df618e28-c6d0-43b6-a7e9-80a7da48d3db.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/300/h/300/format/webp"),
                    )),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "学员4545",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text("时光不回头，当下最重要")
                      ],
                    ))
              ],
            )),
        Container(
          margin: EdgeInsets.all(10),
          height: 100,
          child: Card(
            elevation: 5.0, //设置阴影
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))), //设置圆角
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              //交叉轴的布局方式，对于column来说就是水平方向的布局方式
              crossAxisAlignment: CrossAxisAlignment.center,
              //就是字child的垂直布局方向，向上还是向下
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[Images.ic_mine_address, Text("收货地址")],
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[Images.ic_mine_download, Text("缓存中心")],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[Images.ic_mine_key_course, Text("我的重点")],
                ),
                Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[Images.ic_mine_order, Text("我的订单")],
                    ))
              ],
            ),
          ),
        ),
        Container(
            child: Column(
          children: <Widget>[
            PersonDetailItem(
                leftIcon: Images.accountSet,
                leftText: "离线缓存",
                rightText: "",
                onTap: () {}),
            PersonDetailItem(
                leftIcon: Images.accountSet,
                leftText: "我的重点",
                rightText: "",
                onTap: () {}),
            PersonDetailItem(
                leftIcon: Images.accountSet,
                leftText: "在线咨询",
                rightText: "",
                onTap: () {})
          ],
        )),
      ]),
    );
  }
}
