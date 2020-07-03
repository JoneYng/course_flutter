
import 'dart:async';

import 'package:courseflutter/common/common.dart';
import 'package:courseflutter/provider/theme_provider.dart';
import 'package:courseflutter/routers/fluro_navigator.dart';
import 'package:courseflutter/routers/routers.dart';
import 'package:courseflutter/util/image_utils.dart';
import 'package:courseflutter/util/load_image.dart';
import 'package:courseflutter/util/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flustars/flustars.dart';

import 'login/login_router.dart';

///闪屏页面
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _initSplash();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }


  void _initSplash() {
    _subscription = Observable.just(1).delay(Duration(milliseconds: 1500)).listen((_) {
        _goLogin();
    });
  }
//Routes.home
  _goLogin() {
    NavigatorUtils.push(context, LoginRouter.loginPage, clearStack: true);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Image.asset(
        ImageUtils.getImgPath('bg_app_start'),
        width: double.infinity,
        fit: BoxFit.fill,
        height: double.infinity,
      )
    );
  }
}
