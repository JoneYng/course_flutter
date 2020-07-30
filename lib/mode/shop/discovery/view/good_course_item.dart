import 'dart:convert';

import 'package:courseflutter/mode/shop/discovery/bean/course_detail_bean.dart';
import 'package:courseflutter/routers/fluro_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shop_router.dart';

/// 精选好课item
class GoodCourseIteamView extends StatelessWidget {
  final CourseDetail mCourseDetail;
  final bool isOnTap;

  const GoodCourseIteamView({
    Key key,
    this.mCourseDetail,
    this.isOnTap = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(10),
      child: InkWell(
          onTap: () => {
                isOnTap
                    ? NavigatorUtils.navigateTo(
                        context,
                        ShopRouter.courseDetail,
                        params: {
                          'json':
                              json.encode(mCourseDetail.toJson()).toString(),
                        },
                      ).then((result) {
                        // 通过pop回传的值，顶部返回则不会通过此处传值
                      })
                    : null
              },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.all(2),
                      //边框设置
                      decoration: new BoxDecoration(
                        color: Colors.blueGrey,
                        //设置四周圆角 角度
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0.0),
                            topRight: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0)),
                        //设置四周边框
                        border:
                            new Border.all(width: 1, color: Colors.blueGrey),
                      ),
                      child: Text(
                        mCourseDetail.categoryName,
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      )),
                  Expanded(
                      child: Text(
                    mCourseDetail.courseTitle,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                    overflow: TextOverflow.ellipsis,
                  ))
                ],
              ),
              Text(
                  "开课时间:${mCourseDetail.courseTime} ${mCourseDetail.lessonNum}课时",
                  style: TextStyle(fontSize: 12)),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return buildTeachItem(mCourseDetail.teacherList[index]);
                      },
                      itemCount: mCourseDetail.teacherList.length,
                    )),
                    Text(
                      "￥${mCourseDetail.courseSalePrice}",
                      style: TextStyle(color: Colors.orange, fontSize: 18),
                    )
                  ],
                ),
              ),
              Divider(
                height: 0.5,
                color: Colors.black12,
              ),
            ],
          )),
    );
  }

  //ListView的Item
  Widget buildTeachItem(TeacherList mTeacherList) {
    return Container(
        margin: EdgeInsets.only(right: 5),
        child: Column(
          children: <Widget>[
            Container(
                width: 30,
                height: 30,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(mTeacherList.imgUrl),
                )),
            Text(
              mTeacherList.name,
              style: TextStyle(fontSize: 12),
            )
          ],
        ));
  }
}
