import 'dart:collection';
import 'package:courseflutter/mode/shop/discovery/bean/course_detail_bean.dart';
import 'package:courseflutter/mode/shop/discovery/bean/course_teacher_bean.dart';
import 'package:courseflutter/mode/shop/discovery/shop_bean.dart';
import 'package:flutter/material.dart';

import '../bean/banner_bean.dart';

class DiscoveryCourseProvider extends ChangeNotifier {
  List<CourseBanner> _listCourseBanner = [];
  List<CourseTeacher> _listCourseTeacher = [];
  List<CourseDetail> _listCourseDetail = [];

  List<CourseBanner> get listCourseBanner => _listCourseBanner;

  List<CourseTeacher> get listCourseTeacher => _listCourseTeacher;

  List<CourseDetail> get listCourseDetail => _listCourseDetail;

  void setBanner(
      List<CourseBanner> listCourseBanner,
      List<CourseTeacher> listCourseTeacher,
      List<CourseDetail> listCourseDetail) {
    _listCourseBanner = listCourseBanner;
    _listCourseTeacher = listCourseTeacher;
    _listCourseDetail = listCourseDetail;
    notifyListeners();
  }
}
