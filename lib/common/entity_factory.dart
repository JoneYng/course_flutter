

import 'package:courseflutter/mode/open/open_class_entity.dart';

import '../mode/video/video_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    }else if (T.toString() == 'VideoRoot') {
      return VideoRoot.fromJson(json) as T;
    } else if (T.toString() == 'OpenClassRoot') {
      return OpenClassRoot.fromJson(json) as T;
    }else {
      return null;
    }
  }
}