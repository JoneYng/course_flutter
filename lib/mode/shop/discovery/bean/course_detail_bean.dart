import 'package:courseflutter/res/gaps.dart';
import 'package:courseflutter/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class CourseDetail {
  dynamic lessonNum;
  bool hideNum;
  int itemType;
  List<TeacherList> teacherList;
  int courseStartTime;
  String categoryName;
  int promotionId;
  List<SubCategories> subCategories;
  String courseTitle;
  int rank;
  String expireDate;
  String outVendor;
  int id;
  bool liveStatus;
  int registrationDeadline;
  int limitNum;
  int promotionType;
  int iosSalePrice;
  int courseSaleNum;
  String url;
  dynamic courseOriginalPrice;
  int courseSaleTime;
  bool purchased;
  int courseSalePrice;
  Renew renew;
  bool needAddress;
  String courseTime;
  int status;
  bool isSelect=false;//是否选中

  CourseDetail(
      {this.lessonNum,
        this.hideNum,
        this.itemType,
        this.teacherList,
        this.courseStartTime,
        this.categoryName,
        this.promotionId,
        this.subCategories,
        this.courseTitle,
        this.rank,
        this.expireDate,
        this.outVendor,
        this.id,
        this.liveStatus,
        this.registrationDeadline,
        this.limitNum,
        this.promotionType,
        this.iosSalePrice,
        this.courseSaleNum,
        this.url,
        this.courseOriginalPrice,
        this.courseSaleTime,
        this.purchased,
        this.courseSalePrice,
        this.renew,
        this.needAddress,
        this.courseTime,
        this.isSelect,
        this.status});

  CourseDetail.fromJson(Map<String, dynamic> json) {
    lessonNum = json['lessonNum'];
    hideNum = json['hideNum'];
    itemType = json['itemType'];
    if (json['teacherList'] != null) {
      teacherList = new List<TeacherList>();
      json['teacherList'].forEach((v) {
        teacherList.add(new TeacherList.fromJson(v));
      });
    }
    courseStartTime = json['courseStartTime'];
    categoryName = json['categoryName'];
    promotionId = json['promotionId'];
    if (json['subCategories'] != null) {
      subCategories = new List<SubCategories>();
      json['subCategories'].forEach((v) {
        subCategories.add(new SubCategories.fromJson(v));
      });
    }
    courseTitle = json['courseTitle'];
    rank = json['rank'];
    expireDate = json['expireDate'];
    outVendor = json['outVendor'];
    id = json['id'];
    liveStatus = json['liveStatus'];
    registrationDeadline = json['registrationDeadline'];
    limitNum = json['limitNum'];
    promotionType = json['promotionType'];
    iosSalePrice = json['iosSalePrice'];
    courseSaleNum = json['courseSaleNum'];
    url = json['url'];
    courseOriginalPrice = json['courseOriginalPrice'];
    courseSaleTime = json['courseSaleTime'];
    purchased = json['purchased'];
    courseSalePrice = json['courseSalePrice'];
    renew = json['renew'] != null ? new Renew.fromJson(json['renew']) : null;
    needAddress = json['needAddress'];
    courseTime = json['courseTime'];
    status = json['status'];
    isSelect = json['isSelect']==null? false:json['isSelect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lessonNum'] = this.lessonNum;
    data['hideNum'] = this.hideNum;
    data['itemType'] = this.itemType;
    if (this.teacherList != null) {
      data['teacherList'] = this.teacherList.map((v) => v.toJson()).toList();
    }
    data['courseStartTime'] = this.courseStartTime;
    data['categoryName'] = this.categoryName;
    data['promotionId'] = this.promotionId;
    if (this.subCategories != null) {
      data['subCategories'] =
          this.subCategories.map((v) => v.toJson()).toList();
    }
    data['courseTitle'] = this.courseTitle;
    data['rank'] = this.rank;
    data['expireDate'] = this.expireDate;
    data['outVendor'] = this.outVendor;
    data['id'] = this.id;
    data['liveStatus'] = this.liveStatus;
    data['registrationDeadline'] = this.registrationDeadline;
    data['limitNum'] = this.limitNum;
    data['promotionType'] = this.promotionType;
    data['iosSalePrice'] = this.iosSalePrice;
    data['courseSaleNum'] = this.courseSaleNum;
    data['url'] = this.url;
    data['courseOriginalPrice'] = this.courseOriginalPrice;
    data['courseSaleTime'] = this.courseSaleTime;
    data['purchased'] = this.purchased;
    data['courseSalePrice'] = this.courseSalePrice;
    if (this.renew != null) {
      data['renew'] = this.renew.toJson();
    }
    data['needAddress'] = this.needAddress;
    data['courseTime'] = this.courseTime;
    data['status'] = this.status;
    data['isSelect'] = this.isSelect;
    return data;
  }
}

class TeacherList {
  String imgUrl;
  String name;
  int id;

  TeacherList({this.imgUrl, this.name, this.id});

  TeacherList.fromJson(Map<String, dynamic> json) {
    imgUrl = json['imgUrl'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgUrl'] = this.imgUrl;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class SubCategories {
  String name;
  int id;
  int type;
  int categoryId;

  SubCategories({this.name, this.id, this.type, this.categoryId});

  SubCategories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    type = json['type'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['type'] = this.type;
    data['categoryId'] = this.categoryId;
    return data;
  }
}

class Renew {
  int renewStart;
  int renewEnd;

  Renew({this.renewStart, this.renewEnd});

  Renew.fromJson(Map<String, dynamic> json) {
    renewStart = json['renewStart'];
    renewEnd = json['renewEnd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['renewStart'] = this.renewStart;
    data['renewEnd'] = this.renewEnd;
    return data;
  }
}

