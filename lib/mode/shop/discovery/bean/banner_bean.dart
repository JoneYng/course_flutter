import 'package:courseflutter/res/gaps.dart';
import 'package:courseflutter/widgets/app_bar.dart';
import 'package:flutter/material.dart';


///Banner
class CourseBanner {
  CourseBanner(this.img);
  String img = "";
  String title = "";
  String url = "";
  CourseBanner.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    title = json['title'];
    url = json['url'];
  }
}