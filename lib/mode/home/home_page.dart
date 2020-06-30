import 'package:courseflutter/mode/drawer/drawer_person.dart';
import 'package:courseflutter/res/colors.dart';
import 'package:courseflutter/res/resources.dart';
import 'package:courseflutter/routers/fluro_navigator.dart';
import 'package:courseflutter/util/load_image.dart';
import 'package:courseflutter/util/theme_utils.dart';
import 'package:courseflutter/widgets/double_tap_back_exit_app.dart';
import 'package:flutter/material.dart';

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
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => provider,
      child: DoubleTapBackExitApp(
        child:  DefaultTabController(
          length: 3,
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.menu),
                color: Colors.black,
                tooltip: "Navigration",
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
              ),
              elevation: 0.0,
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(left:15.0,top: 10),
                      width: double.infinity,
                      child: Text(
                        "考满分课程",
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w900,
                        ),
                      )),
                  MainButton(text:"公开课",onTap:() {
                    NavigatorUtils.push(context, CourseRouter.OpenClass);
                  },),
                  MainButton(text:"视频课",onTap:() {
                    NavigatorUtils.push(context, CourseRouter.VideoClass);
                  },)
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
