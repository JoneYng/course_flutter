import 'dart:convert';

import 'package:courseflutter/mvp/base_page_presenter.dart';
import 'package:flutter/services.dart';

import '../banner_bean.dart';
import '../discovery_course_page.dart';

class ShopPresenter extends BasePagePresenter<ShopPageState> {
  @override
  void initState() {
    getAnchors().then(
      (value) => {
        view.setBannerList(value)
      },
    );
  }

  Future<List<CourseBanner>> getAnchors() async {
    //1. 读取json文件
    String jsonString = await rootBundle.loadString("assets/data/banner.json");
    //2.转成List或Map类型
    final jsonResult = json.decode(jsonString);
    //遍历List，并且转成Anchor对象放到另一个List中
    List<CourseBanner> anchors = new List();
    for (Map<String, dynamic> map in jsonResult) {
      anchors.add(CourseBanner.fromJson(map));
    }
    return anchors;
  }
}
