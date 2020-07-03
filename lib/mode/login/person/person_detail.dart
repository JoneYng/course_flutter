import 'package:courseflutter/res/colors.dart';
import 'package:courseflutter/res/resources.dart';
import 'package:courseflutter/routers/fluro_navigator.dart';
import 'package:courseflutter/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import '../login_router.dart';
import 'item_detail.dart';

///个人信息详情页
class PersonDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: "账号设置",
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              "个人信息",
              style: TextStyle(color: Colours.app_main),
            ),
          ),
          ItemDetail(
              leftIcon: Images.headSet,
              leftText: "头像",
              rightImageUri:  "https://upload.jianshu.io/users/upload_avatars/2268884/df618e28-c6d0-43b6-a7e9-80a7da48d3db.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/300/h/300/format/webp",
              isRightText: false,
              isRightImage: true),
          ItemDetail(
            leftIcon: Images.accountSet,
            leftText: "用户名",
            rightText: "大队辅导员",
          ),
          ItemDetail(
            leftIcon: Images.accountPhone,
            leftText: "手机",
            rightText: "176****7896",
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              "第三方账号绑定",
              style: TextStyle(color: Colours.app_main),
            ),
          ),
          ItemDetail(
            leftIcon: Images.accountWeibo,
            leftText: "新浪微博",
            rightText: "点击绑定",
          ),
          ItemDetail(
            leftIcon: Images.accountWeixin,
            leftText: "微信",
            rightText: "点击绑定",
          ),
          ItemDetail(
            leftIcon: Images.accountQQ,
            leftText: "QQ",
            rightText: "点击绑定",
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              "账号安全",
              style: TextStyle(color: Colours.app_main),
            ),
          ),
          ItemDetail(
            leftIcon: Images.password,
            leftText: "修改密码",
            isRight: false,
            onTap: () {
              NavigatorUtils.push(context, LoginRouter.updatePasswordPage);
            },
          ),
          InkWell(
            //在最外层包裹InkWell组件
            onTap: () {
              NavigatorUtils.push(context, LoginRouter.loginPage,clearStack:true);
            },
            child: Container(
              height: 45,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Colours.open_class_button, width: 1),
                  color: Colours.app_main,
                  borderRadius: BorderRadius.circular((25.0))),
              child: Center(
                child: Text('退出登录',
                    style: TextStyle(
                        color: Colours.dark_button_text, fontSize: 14)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
