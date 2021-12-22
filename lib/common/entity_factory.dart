

import 'package:courseflutter/mode/course/open/open_class_entity.dart';
import 'package:courseflutter/mode/course/video/video_entity.dart';
import 'package:courseflutter/mode/qhdemo/login/QHTokenBean.dart';
import 'package:courseflutter/mode/qhdemo/main/QHHomeBean.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (T.toString() == 'VideoRoot') {
      return VideoRoot.fromJson(json) as T;
    } else if (T.toString() == 'OpenClassRoot') {
      return OpenClassRoot.fromJson(json) as T;
    } else if (T.toString() == 'QHTokenBean') {
      return QHTokenBean.fromJson(json) as T;
    } else if (T.toString() == 'QHHomeBean') {
      return QHHomeBean.fromJson(json) as T;
    }else {
      return null;
    }
  }
}
