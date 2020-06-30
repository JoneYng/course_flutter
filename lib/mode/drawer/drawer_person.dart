import 'package:courseflutter/res/colors.dart';
import 'package:courseflutter/routers/fluro_navigator.dart';
import 'package:flutter/material.dart';

class DrawerPerson extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              "大队辅导猿",
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
            ),
            accountEmail: Text("https://github.com/JoneYng",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage("https://upload.jianshu.io/users/upload_avatars/2268884/df618e28-c6d0-43b6-a7e9-80a7da48d3db.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/300/h/300/format/webp"),
            ),
            decoration: BoxDecoration(
//              color: Colours.app_main
              image: DecorationImage(
                  image:  AssetImage("assets/images/bg_drawerlayout_head.png"),
                  fit: BoxFit.cover,
//                  colorFilter: ColorFilter.mode(
//                      Colors.blue[400].withOpacity(0.6),
//                      BlendMode.hardLight)
                      ),
            ),
          ),
          ListTile(
            title: Text(
              "安全中心",
              textAlign: TextAlign.left,
            ),
            leading: Icon(
              Icons.description,
              color: Colors.black12,
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
              color: Colors.black12,
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
              color: Colors.black12,
              size: 22.0,
            ),
            onTap: () => NavigatorUtils.goWebViewPage(context, "隐私条款", "https://hd.kmf.com/term/privacy"),

          ),
          ListTile(
            title: Text(
              "意见反馈",
              textAlign: TextAlign.left,
            ),
            leading: Icon(
              Icons.message,
              color: Colors.black12,
              size: 22.0,
            ),
            onTap: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

}