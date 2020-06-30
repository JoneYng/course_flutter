
import 'package:courseflutter/mode/course/video/video_class_page.dart';
import 'package:courseflutter/routers/router_init.dart';
import 'package:fluro/fluro.dart';

import 'open/open_class_page.dart';

//课程路由
class CourseRouter implements IRouterProvider{

  static String OpenClass = '/OpenClass';
  static String VideoClass = '/VideoClassPage';

  @override
  void initRouter(Router router) {
    router.define(OpenClass, handler: Handler(handlerFunc: (_, params) => OpenClassPage()));
    router.define(VideoClass, handler: Handler(handlerFunc: (_, params) => VideoClassPage()));
  }
  
}