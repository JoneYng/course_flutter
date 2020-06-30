

import 'package:courseflutter/mode/course/open/open_class_entity.dart';
import 'package:courseflutter/mode/course/video/video_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (T.toString() == 'VideoRoot') {
      return VideoRoot.fromJson(json) as T;
    } else if (T.toString() == 'OpenClassRoot') {
      return OpenClassRoot.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
