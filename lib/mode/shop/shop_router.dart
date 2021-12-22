
import 'dart:convert';

import 'package:courseflutter/mode/qhdemo/qh_index_page.dart';
import 'package:courseflutter/mode/shop/shop_index_page.dart';
import 'package:courseflutter/mode/shop/shopcar/my_course_page.dart';
import 'package:courseflutter/routers/router_init.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import 'coursedetail/course_detail_page.dart';
import 'discovery/bean/course_detail_bean.dart';


class ShopRouter implements IRouterProvider{

  static String qhDemoPage = '/qhDemo';


  static String shopPage = '/shop';
  static String courseDetail = '/shop/courseDetail';
  static String courseShopCar = '/shop/car';

  @override
  void initRouter(Router router) {
    Handler courseDetailHander =  Handler(
        handlerFunc: (BuildContext context,Map<String,List<String>> params){
          print('--------Handerl接受参数---------->${params}');
          CourseDetail mCourseDetail=new CourseDetail();
          Map<String, dynamic> user = json.decode(params['json'][0].toString());
          mCourseDetail=CourseDetail.fromJson(user);
          return CourseDetailPage(mCourseDetail);
        }
    );
    router.define(qhDemoPage, handler: Handler(handlerFunc: (_, params) => QHShopIndexPage()));
    router.define(shopPage, handler: Handler(handlerFunc: (_, params) => ShopIndexPage()));
    router.define(courseShopCar, handler: Handler(handlerFunc: (_, params) => ShopCarPage()));
    router.define(courseDetail, handler: courseDetailHander);
  }
}
  
