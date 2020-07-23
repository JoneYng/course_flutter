import 'package:courseflutter/res/gaps.dart';
import 'package:courseflutter/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class CourseTeacher {
  String img;
  String teacherName;
  int tagId;
  String teacherTag;
  int classStartTime;
  String title;
  String type;
  String url;
  bool purchased;
  int courseSaleStartTime;
  String guid;
  int validTime;
  int startTime;
  String outVendor;
  int endTime;
  String id;
  String courseId;
  String introduction;

  CourseTeacher(
      {this.img,
        this.teacherName,
        this.tagId,
        this.teacherTag,
        this.classStartTime,
        this.title,
        this.type,
        this.url,
        this.purchased,
        this.courseSaleStartTime,
        this.guid,
        this.validTime,
        this.startTime,
        this.outVendor,
        this.endTime,
        this.id,
        this.courseId,
        this.introduction});

  CourseTeacher.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    teacherName = json['teacherName'];
    tagId = json['tagId'];
    teacherTag = json['teacherTag'];
    classStartTime = json['classStartTime'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
    purchased = json['purchased'];
    courseSaleStartTime = json['courseSaleStartTime'];
    guid = json['guid'];
    validTime = json['validTime'];
    startTime = json['startTime'];
    outVendor = json['outVendor'];
    endTime = json['endTime'];
    id = json['id'];
//    courseId = json['courseId'];
    introduction = json['introduction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['teacherName'] = this.teacherName;
    data['tagId'] = this.tagId;
    data['teacherTag'] = this.teacherTag;
    data['classStartTime'] = this.classStartTime;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    data['purchased'] = this.purchased;
    data['courseSaleStartTime'] = this.courseSaleStartTime;
    data['guid'] = this.guid;
    data['validTime'] = this.validTime;
    data['startTime'] = this.startTime;
    data['outVendor'] = this.outVendor;
    data['endTime'] = this.endTime;
    data['id'] = this.id;
    data['courseId'] = this.courseId;
    data['introduction'] = this.introduction;
    return data;
  }
}
