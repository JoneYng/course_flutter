import 'package:courseflutter/common/common.dart';
import 'package:courseflutter/mode/login/page/sms_login_page.dart';
import 'package:courseflutter/res/colors.dart';
import 'package:courseflutter/res/gaps.dart';
import 'package:courseflutter/res/resources.dart';
import 'package:courseflutter/res/styles.dart';
import 'package:courseflutter/routers/fluro_navigator.dart';
import 'package:courseflutter/routers/routers.dart';
import 'package:courseflutter/util/utils.dart';
import 'package:courseflutter/widgets/app_bar.dart';
import 'package:courseflutter/widgets/my_button.dart';
import 'package:courseflutter/widgets/text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flustars/flustars.dart' as FlutterStars;
import 'package:keyboard_actions/keyboard_actions.dart';

import '../login_router.dart';
import 'pwd_login_page.dart';

///登录主页面
class MainLoginPage extends StatefulWidget {
  @override
  _MainLoginPageState createState() => _MainLoginPageState();
}

class _MainLoginPageState extends State<MainLoginPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController
        .addListener(() => print("当前点击的是第${_tabController.index}个tab"));
  }

 ///tab集合
  final tabs = <Tab>[
    Tab(
      child: Text("手机验证码登录"),
    ),
    Tab(
      child: Text("密码登录"),
    ),
  ];

  // 对应上述tab切换后具体需要显示的页面内容
  final tabBarViews = <Widget>[
    Center(
      child: SMSLoginPage(),
    ),
    Center(
      child: LoginPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/icon_account_login_background.webp"),
                ),
              )),
          Container(
              alignment: Alignment.centerLeft,
              child: TabBar(
                controller: _tabController,
                tabs: tabs,
                isScrollable: true,
                labelStyle: TextStyle(fontSize: 16),
                unselectedLabelStyle: TextStyle(fontSize: 15),
                indicatorColor: Colours.app_main,
                unselectedLabelColor: Colors.grey,
                labelColor: Colours.app_main,
                indicatorSize: TabBarIndicatorSize.label,
              )),
          Expanded(
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                  child: TabBarView(
                    controller: _tabController,
                    children: tabBarViews,
                  ))),
          Container(
            alignment: Alignment.center,
            height: 40,
            child: Text(
              "登录页面",
              maxLines: 2,
              style: TextStyle(fontSize: 12),
            ),
          )
        ]));
  }
}
