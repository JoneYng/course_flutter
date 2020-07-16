import 'package:courseflutter/mode/login/page/sms_login_page.dart';
import 'package:courseflutter/res/colors.dart';
import 'package:courseflutter/res/resources.dart';
import 'package:courseflutter/util/toast.dart';
import 'package:flutter/material.dart';

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
    //默认选中的第一个
    _tabController.index = 1;
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
                margin: EdgeInsets.only(bottom: 10, left: 10),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Toast.show("微信~");
                      },
                      child: Images.weChat,
                    ),
                    InkWell(
                      onTap: () {
                        Toast.show("QQ~");
                      },
                      child: new Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        child: Images.qq,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Toast.show("新浪~");
                      },
                      child: Images.sina,
                    ),
                  ],
                ),
              )
            ]));
  }
}
