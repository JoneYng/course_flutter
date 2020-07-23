import 'dart:collection';
import 'package:courseflutter/mode/shop/discovery/bean/course_detail_bean.dart';
import 'package:courseflutter/mode/shop/discovery/bean/course_teacher_bean.dart';
import 'package:courseflutter/mode/shop/discovery/shop_bean.dart';
import 'package:flutter/material.dart';

import '../bean/banner_bean.dart';

class DiscoveryCourseProvider extends ChangeNotifier {

  List<CourseBanner> _list=[];
  List<CourseTeacher> _list2=[];
  List<CourseDetail> _list3=[];

  List<CourseBanner> get list => _list;
  List<CourseTeacher> get list2 => _list2;
  List<CourseDetail> get list3 => _list3;

  void setBanner(List<CourseBanner> list,List<CourseTeacher> list2,List<CourseDetail> list3) {
    _list= list;
    _list2= list2;
    _list3= list3;
    notifyListeners();
  }
}
