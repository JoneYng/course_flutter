export 'colors.dart';
export 'dimens.dart';
export 'styles.dart';
export 'gaps.dart';

import 'package:courseflutter/util/load_image.dart';
import 'package:flutter/widgets.dart';

class Images {
  static const Widget arrowRight = const LoadAssetImage('ic_arrow_right', height: 16.0, width: 16.0);
  static const Widget play = const LoadAssetImage('ic_play', height: 40.0, width: 40.0);
  static const Widget main = const LoadAssetImage('btn_main_my_class',width: double.infinity,height: 100);
  static const Widget courseDefault = const LoadAssetImage('ic_old_course_default',width: 200,height: 200);
}