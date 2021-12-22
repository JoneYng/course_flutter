import 'package:courseflutter/mode/qhdemo/login/qh_pwd_login_page.dart';
import 'package:courseflutter/res/resources.dart';
import 'package:courseflutter/util/toast.dart';
import 'package:flutter/material.dart';

///登录主页面
class QHMainLoginPage extends StatefulWidget {
  @override
  _MainLoginPageState createState() => _MainLoginPageState();
}

class _MainLoginPageState extends State<QHMainLoginPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              height: 40,
              child: Text(
                '密码登录',
                style: TextStyle(fontSize: 20),
              )),
          Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              height: 40,
              child: Text(
                '密码登录仅使用于已注册用户',
                style: TextStyle(fontSize: 16),
              )),
          Expanded(
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                  child: QHLoginPage())),
          Visibility(
              visible: false,
              child: Container(
                margin: EdgeInsets.only(bottom: 20, left: 20),
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
              ))
        ]));
  }
}
