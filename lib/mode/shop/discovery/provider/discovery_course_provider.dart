import 'dart:collection';
import 'package:courseflutter/mode/shop/discovery/shop_bean.dart';
import 'package:flutter/material.dart';

import '../banner_bean.dart';

class DiscoveryCourseProvider extends ChangeNotifier {

  List<CourseBanner> _list=[];

  List<CourseBanner> get list => _list;

  void setBanner(List<CourseBanner> list) {
    _list= list;
    notifyListeners();
  }
}
