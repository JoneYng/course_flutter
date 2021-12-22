import 'package:flutter/material.dart';

class Constant {
  /// debug开关，上线需要关闭
  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction  = const bool.fromEnvironment('dart.vm.product');

  static bool isTest  = false;

  static const String code = 'code';
  static const String msg = 'msg';



  static const String result = 'result';
  static const String data = 'data';
  static const String message = 'message';
  static const String status = 'status';

  static const String phone = 'phone';
  static const String password = 'password';
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
  static const String KVersion = 'K-Version';
  static  String KVersion_Value = '';

  static const String theme = 'AppTheme';

  static const List<Color> colorList = [
    Color(0xFFFFD147), Color(0xFFA9DAF2), Color(0xFFFAAF64),
    Color(0xFF7087FA), Color(0xFFA0E65C), Color(0xFF5CE6A1), Color(0xFFA364FA),
    Color(0xFFDA61F2), Color(0xFFFA64AE), Color(0xFFFA6464),
  ];
}
