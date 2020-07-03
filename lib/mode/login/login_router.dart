
import 'package:courseflutter/mode/login/page/login_page_main.dart';
import 'package:courseflutter/mode/login/person/person_detail.dart';
import 'package:courseflutter/routers/router_init.dart';
import 'package:fluro/fluro.dart';

import 'page/register_page.dart';
import 'page/reset_password_page.dart';
import 'page/sms_login_page.dart';
import 'page/update_password_page.dart';


class LoginRouter implements IRouterProvider{

  static String loginPage = '/login';
  static String registerPage = '/login/register';
  static String smsLoginPage = '/login/smsLogin';
  static String resetPasswordPage = '/login/resetPassword';
  static String updatePasswordPage = '/login/updatePassword';
  static String personDetailPage = '/login/PersonDetailPage';

  @override
  void initRouter(Router router) {
    router.define(loginPage, handler: Handler(handlerFunc: (_, params) => MainLoginPage()));
    router.define(registerPage, handler: Handler(handlerFunc: (_, params) => RegisterPage()));
    router.define(smsLoginPage, handler: Handler(handlerFunc: (_, params) => SMSLoginPage()));
    router.define(resetPasswordPage, handler: Handler(handlerFunc: (_, params) => ResetPasswordPage()));
    router.define(updatePasswordPage, handler: Handler(handlerFunc: (_, params) => UpdatePasswordPage()));
    router.define(personDetailPage, handler: Handler(handlerFunc: (_, params) => PersonDetailPage()));
  }
}