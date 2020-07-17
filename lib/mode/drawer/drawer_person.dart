import 'package:courseflutter/mode/login/login_router.dart';
import 'package:courseflutter/res/colors.dart';
import 'package:courseflutter/routers/fluro_navigator.dart';
import 'package:courseflutter/util/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

///个人信息侧滑页面
class DrawerPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: <Widget>[
                    Container(
                        margin: EdgeInsets.all(10),
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://upload.jianshu.io/users/upload_avatars/2268884/df618e28-c6d0-43b6-a7e9-80a7da48d3db.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/300/h/300/format/webp"),
                        )),
                    Text(
                      "大队辅导猿",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ]),
                  Center(
                    child: InkWell(
                      //在最外层包裹InkWell组件
                      onTap: () {
                        NavigatorUtils.push(context, LoginRouter.personDetailPage);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colours.open_class_button, width: 1),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular((15.0))),
                        child: Text('编辑资料',
                            style: TextStyle(
                                color: Colours.open_class_button,
                                fontSize: 14)),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
//              color: Colours.app_main
                image: DecorationImage(
                  image: AssetImage("assets/images/bg_drawerlayout_head.png"),
                  fit: BoxFit.cover,
                ),
              )),
          ListTile(
            title: Text(
              "安全中心",
              textAlign: TextAlign.left,
            ),
            leading: Icon(
              Icons.description,
              color: isDark ? Colours.dark_button_text : Colours.text_gray_c,
              size: 22.0,
            ),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: Text(
              "课程帮助",
              textAlign: TextAlign.left,
            ),
            leading: Icon(
              Icons.access_alarms,
              color: isDark ? Colours.dark_button_text : Colours.text_gray_c,
              size: 22.0,
            ),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: Text(
              "隐私政策",
              textAlign: TextAlign.left,
            ),
            leading: Icon(
              Icons.people,
              color: isDark ? Colours.dark_button_text : Colours.text_gray_c,
              size: 22.0,
            ),
            onTap: () => NavigatorUtils.goWebViewPage(
                context, "隐私条款", "https://www.baidu.com/"),
          ),
          ListTile(
            title: Text(
              "意见反馈",
              textAlign: TextAlign.left,
            ),
            leading: Icon(
              Icons.message,
              color: isDark ? Colours.dark_button_text : Colours.text_gray_c,
              size: 22.0,
            ),
            onTap: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

}
