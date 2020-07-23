import 'dart:convert';

import 'package:courseflutter/mode/shop/discovery/bean/course_detail_bean.dart';
import 'package:courseflutter/mode/shop/discovery/bean/course_teacher_bean.dart';
import 'package:courseflutter/mode/shop/discovery/bean/root_bean.dart';
import 'package:courseflutter/mvp/base_page_presenter.dart';
import 'package:flutter/services.dart';

import '../bean/banner_bean.dart';
import '../discovery_course_page.dart';

class ShopPresenter extends BasePagePresenter<ShopPageState> {
  @override
  void initState() {
    getAnchors().then(
      (value) => {
        view.setBannerList(value.courseBannerList,value.courseTeacherList,value.courseList)
      },
    );
  }

  Future<RootBanner> getAnchors() async {
    //1. 读取json文件
    String jsonString = await rootBundle.loadString("assets/data/banner.json");
    //2.转成List或Map类型
    final jsonResult = json.decode(jsonString);
    //遍历List
    List<CourseBanner> courseBannerList = new List();
    for (Map<String, dynamic> map in jsonResult["head"]) {
      courseBannerList.add(CourseBanner.fromJson(map));
    }
    List<CourseTeacher> courseTeacherList = new List();
    for (Map<String, dynamic> map in jsonResult["zhuanlan"]) {
      courseTeacherList.add(CourseTeacher.fromJson(map));
    }
    List<CourseDetail> courseDetailList = new List();
    for (Map<String, dynamic> map in jsonResult["course"]) {
      courseDetailList.add(CourseDetail.fromJson(map));
    }
    RootBanner rootBanner=new RootBanner();
    rootBanner.courseBannerList=courseBannerList;
    rootBanner.courseTeacherList=courseTeacherList;
    rootBanner.courseList=courseDetailList;
    return rootBanner;
  }
}
