import 'dart:convert';

import 'package:courseflutter/common/common.dart';
import 'package:courseflutter/mode/login/login_router.dart';
import 'package:courseflutter/mode/qhdemo/services/http_config.dart';
import 'package:courseflutter/res/gaps.dart';
import 'package:courseflutter/routers/fluro_navigator.dart';
import 'package:courseflutter/routers/routers.dart';
import 'package:courseflutter/util/utils.dart';
import 'package:courseflutter/widgets/my_button.dart';
import 'package:courseflutter/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart' as FlutterStars;
import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:oktoast/oktoast.dart';

import 'QHTokenBean.dart';
import '../services/qh_dio_utils.dart';

///账号密码登录
class QHLoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<QHLoginPage> {
  //定义一个controller
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _isClick = false;

  @override
  void initState() {
    super.initState();
    //监听输入改变
    _nameController.addListener(_verify);
    _passwordController.addListener(_verify);
    _nameController.text = SpUtil.getString(Constant.phone);
    _passwordController.text = SpUtil.getString(Constant.password);
  }

  void _verify() {
    String name = _nameController.text;
    String password = _passwordController.text;
    bool isClick = true;
    if (name.isEmpty || name.length < 11) {
      isClick = false;
    }
    if (password.isEmpty || password.length < 6) {
      isClick = false;
    }

    /// 状态不一样在刷新，避免重复不必要的setState
    if (isClick != _isClick) {
      setState(() {
        _isClick = isClick;
      });
    }
  }

  void _login() {
    postLogin(_nameController.text, _passwordController.text);
    // FlutterStars.SpUtil.putString(Constant.phone, _nameController.text);
  }

  void netLogin(String phone, String password) {}

  void postLogin(String phone, String password) async {
    Dio dio = new Dio();
    var requestBody = {};
    var LOGIN_TYPE_ACCOUNT_PSW = 2;
    requestBody["account"] = phone;
    requestBody["password"] = password;
    requestBody["clientType"] = 1;
    requestBody["address"] = "";
    requestBody["loginAddress"] = "";
    requestBody["loginProduct"] = "启航教育";
    requestBody["loginTerminal"] = 2;
    requestBody["loginType"] = LOGIN_TYPE_ACCOUNT_PSW;
    requestBody["loginVersion"] = 1;
    requestBody["network"] = "中国移动";
    requestBody["networkType"] = "WIFI网络";
    requestBody["os"] = "andriod";
    requestBody["osVersion"] = "1";
    requestBody["plant"] = "测试";
    requestBody["plantType"] = "1";
    requestBody["source"] = "启航教育";
    requestBody["sourceType"] = 1;
    requestBody["terminal"] = 2;
    requestBody["version"] = "1.0";

    String url = "https://mobile.iqihang.com/api/ark/sso/login";

    ///发起 post 请求 如这里的注册用户信息
    Response response = await dio.post(url, data: requestBody);
    Map<String, dynamic> _resultMap = response.data;
    var code = _resultMap[Constant.code];
    // showToast(_resultMap[Constant.msg].toString());
    // if(code.toString()=="0"){
    //   Map<String, dynamic>  _resultData = _resultMap[Constant.data];
    //   dynamic  accessToken=_resultData['token'];
    //   SpUtil.putString(Constant.accessToken, accessToken);
    //   print("zxzx:" + accessToken.toString());
    // }

    QhDioUtils.instance
        .asyncRequestNetwork<QHTokenBean>(QHMethod.post, loginUrl,
            params: requestBody,
            onSuccess: (data) {
              print('发送请求2：${data.token.toString()}');
              SpUtil.putString(Constant.accessToken, data.token.toString());
              SpUtil.putString(Constant.phone, phone);
              SpUtil.putString(Constant.password, password);
              NavigatorUtils.push(context, Routes.home, clearStack: true);
            },
            onError: (code, msg) {
              showToast(msg);
              SpUtil.putString(Constant.accessToken,"");
              SpUtil.putString(Constant.phone, "");
              SpUtil.putString(Constant.password, "");
            });
  }

  Map<String, dynamic> parseData(String data) {
    return json.decode(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: defaultTargetPlatform == TargetPlatform.iOS
            ? FormKeyboardActions(
                child: _buildBody(),
              )
            : SingleChildScrollView(
                child: _buildBody(),
              ));
  }

  _buildBody() {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Gaps.vGap8,
          MyTextField(
            key: const Key('phone'),
            focusNode: _nodeText1,
            controller: _nameController,
            maxLength: 11,
            keyboardType: TextInputType.phone,
            hintText: '请输入账号',
          ),
          Gaps.vGap8,
          MyTextField(
            key: const Key('password'),
            keyName: 'password',
            focusNode: _nodeText2,
            config: Utils.getKeyboardActionsConfig(
                context, [_nodeText1, _nodeText2]),
            isInputPwd: true,
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            maxLength: 16,
            hintText: '请输入密码',
          ),
          Gaps.vGap10,
          Gaps.vGap15,
          MyButton(
            key: const Key('login'),
            onPressed: _isClick ? _login : null,
            text: '登录',
          ),
          Visibility(
              visible: false,
              child: Container(
                height: 40.0,
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  child: Text(
                    '忘记密码',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  onTap: () => NavigatorUtils.push(
                      context, LoginRouter.resetPasswordPage),
                ),
              )),
          Gaps.vGap16,
          Visibility(
              visible: false,
              child: Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Text(
                      '还没账号？快去注册',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onTap: () =>
                        NavigatorUtils.push(context, LoginRouter.registerPage),
                  )))
        ],
      ),
    );
  }
}
