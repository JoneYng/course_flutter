import 'dart:io';

import 'package:courseflutter/mode/login/view/view_update_phone.dart';
import 'package:courseflutter/mode/setting/widgets/exit_dialog.dart';
import 'package:courseflutter/res/colors.dart';
import 'package:courseflutter/res/resources.dart';
import 'package:courseflutter/routers/fluro_navigator.dart';
import 'package:courseflutter/util/load_image.dart';
import 'package:courseflutter/util/log_utils.dart';
import 'package:courseflutter/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../login_router.dart';
import 'person_detail_item.dart';

///个人信息详情页
class PersonDetailPage extends StatefulWidget {
  @override
  _PersonDetailPageState createState() {
    return _PersonDetailPageState();
  }
}

class _PersonDetailPageState extends State<PersonDetailPage> {
  File _image;

  //个人头像
  String headImage =
      "https://upload.jianshu.io/users/upload_avatars/2268884/df618e28-c6d0-43b6-a7e9-80a7da48d3db.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/300/h/300/format/webp";

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      _image = image;
      Log.d("zxzx===" + _image.path);
      headImage = _image.path;
    });
  }

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
          PersonDetailItem(
            leftIcon: Images.accountHeadSet,
            leftText: "头像",
            rightImageUri: headImage,
            isRightText: false,
            isRightImage: true,
            onTap: () {
              _showSelectionDialog(context);
            },
          ),
          PersonDetailItem(
              leftIcon: Images.accountSet,
              leftText: "用户名",
              rightText: "大队辅导员",
              onTap: () {
                NavigatorUtils.push(context, LoginRouter.updateUserNamePage);
              }),
          PersonDetailItem(
              leftIcon: Images.accountPhone,
              leftText: "手机",
              rightText: "176****7896",
              onTap: () {
                showDialog<Null>(
                    context: context, //BuildContext对象
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return UpdatePhoneDialog(
                        //调用对话框
                        phone: '+86 17611167896',
                      );
                    });
              }),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              "第三方账号绑定",
              style: TextStyle(color: Colours.app_main),
            ),
          ),
          PersonDetailItem(
              leftIcon: Images.accountWeibo,
              leftText: "新浪微博",
              rightText: "点击绑定",
              onTap: () {}),
          PersonDetailItem(
              leftIcon: Images.accountWeixin,
              leftText: "微信",
              rightText: "点击绑定",
              onTap: () {}),
          PersonDetailItem(
              leftIcon: Images.accountQQ,
              leftText: "QQ",
              rightText: "点击绑定",
              onTap: () {}),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              "账号安全",
              style: TextStyle(color: Colours.app_main),
            ),
          ),
          PersonDetailItem(
            leftIcon: Images.accountPassword,
            leftText: "修改密码",
            isRight: false,
            onTap: () {
              NavigatorUtils.push(context, LoginRouter.updatePasswordPage);
            },
          ),
          InkWell(
            borderRadius: new BorderRadius.circular(25.0),
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => ExitDialog());
            },
            child: Container(
              height: 45,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
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

  /// 底部弹窗
  void _showSelectionDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          color: Colors.white,
          height: 170,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: _itemCreat(context, '相机'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.camera);
                },
              ),
              GestureDetector(
                child: _itemCreat(context, '相册'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery);
                },
              ),
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: _itemCreat(context, '取消'),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }

  Widget _itemCreat(BuildContext context, String title) {
    return Container(
      color: Colors.white,
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
