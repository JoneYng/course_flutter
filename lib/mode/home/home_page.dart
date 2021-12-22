import 'package:courseflutter/mode/drawer/drawer_person.dart';
import 'package:courseflutter/mode/setting/setting_router.dart';
import 'package:courseflutter/mode/shop/shop_router.dart';
import 'package:courseflutter/res/colors.dart';
import 'package:courseflutter/routers/fluro_navigator.dart';
import 'package:courseflutter/util/theme_utils.dart';
import 'package:courseflutter/widgets/double_tap_back_exit_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../course/course_router.dart';
import 'home_provider.dart';
import 'main_button.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeProvider provider = HomeProvider();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => provider,
      child: DoubleTapBackExitApp(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: isDark ? Colours.dark_bg_color : Colours.bg_color,
            appBar: AppBar(
              //背景颜色
              backgroundColor:
                  isDark ? Colours.dark_bg_color : Colours.bg_color,
              //左侧按钮
              leading: IconButton(
                icon: Icon(Icons.menu),
                color: isDark ? Colours.bg_color: Colours.dark_bg_color,
                tooltip: "Navigration",
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
              ),
              //右侧按钮
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  color: isDark ? Colours.bg_color: Colours.dark_bg_color,
                  onPressed: () {
                    NavigatorUtils.push(context, SettingRouter.settingPage);
                  },
                )
              ],
              elevation: 0.0,
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: isDark ? Colours.dark_bg_color : Colours.bg_color,
              child: Column(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(left: 15.0, top: 10),
                      width: double.infinity,
                      child: Text(
                        "课程",
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w900,
                        ),
                      )),
                  MainButton(
                    text: "公开课",
                    onTap: () {
                      NavigatorUtils.push(context, CourseRouter.OpenClass);
                    },
                  ),
                  MainButton(
                    text: "视频课",
                    onTap: () {
                      NavigatorUtils.push(context, CourseRouter.VideoClass);
                    },
                  ),
                  MainButton(
                    text: "商城",
                    onTap: () {
                      NavigatorUtils.push(context, ShopRouter.shopPage);
                    },
                  ),

                ],
              ),
            ),
            drawer: DrawerPerson(),
//        bottomNavigationBar: BottomNavigationBarDemo(),
          ),
        ),
      ),
    );
  }
}
