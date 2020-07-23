import 'package:courseflutter/mode/course/open/view/open_class_button_view.dart';
import 'package:courseflutter/mode/shop/discovery/presenter/discovery_course_presenter.dart';
import 'package:courseflutter/mode/shop/discovery/provider/discovery_course_provider.dart';
import 'package:courseflutter/mode/shop/discovery/view/find_course_title.dart';
import 'package:courseflutter/mvp/base_page_state.dart';
import 'package:courseflutter/res/gaps.dart';
import 'package:courseflutter/res/resources.dart';
import 'package:courseflutter/routers/fluro_navigator.dart';
import 'package:courseflutter/util/load_image.dart';
import 'package:courseflutter/widgets/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'bean/banner_bean.dart';
import 'bean/course_detail_bean.dart';
import 'bean/course_teacher_bean.dart';

///商城页面
class DiscoveryCoursePage extends StatefulWidget {
  @override
  ShopPageState createState() => ShopPageState();
}

class ShopPageState extends BasePageState<DiscoveryCoursePage, ShopPresenter>
    with AutomaticKeepAliveClientMixin<DiscoveryCoursePage> {
  DiscoveryCourseProvider _provider = DiscoveryCourseProvider();
  ShopPresenter _shopPresenter = new ShopPresenter();

  void setBannerList(List<CourseBanner> list, List<CourseTeacher> list2,
      List<CourseDetail> list3) {
    _provider.setBanner(list, list2, list3);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Gaps.vGap50,
      FindCourseTitleView(
        leftOnTap: () => {},
        centerOnTap: () => {},
        rightOnTap: () => {},
      ),
      ProviderWidget<DiscoveryCourseProvider>(
        model: _provider,
        builder: (context, model, childe) {
          if (model.list.length > 0) {
            return Expanded(
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: <Widget>[
                    getBanner(model.list),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "名师推荐",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildItem(model.list2[index]);
                      },
                      itemCount: model.list2.length,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "精选好课",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildGoodCourseItem(model.list3[index]);
                      },
                      itemCount: model.list3.length,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    ]);
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

  //ListView的Item
  Widget buildItem(CourseTeacher mCourseTeacher) {
    return Container(
      height: 120,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(10),
      child: InkWell(
          onTap: () => {
                NavigatorUtils.goWebViewPage(
                    context, mCourseTeacher.title, mCourseTeacher.url)
              },
          child: Row(
            children: <Widget>[
              LoadImage(mCourseTeacher.img, height: 120.0, width: 80.0),
              ConstrainedBox(
                  // 可以设置宽度和高度的最大最小值
                  constraints: BoxConstraints(
                    minHeight: 120.0,
                    maxWidth: 250.0,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          mCourseTeacher.title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              mCourseTeacher.teacherName,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Container(
                                padding: EdgeInsets.all(2),
                                //边框设置
                                decoration: new BoxDecoration(
                                  //设置四周圆角 角度
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0.0),
                                      topRight: Radius.circular(5.0),
                                      bottomLeft: Radius.circular(5.0),
                                      bottomRight: Radius.circular(5.0)),
                                  //设置四周边框
                                  border: new Border.all(
                                      width: 1, color: Colors.orange),
                                ),
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  mCourseTeacher.teacherTag,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.orange),
                                ))
                          ],
                        ),
                        Text(
                          mCourseTeacher.introduction,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  )),
            ],
          )),
    );
  }

  //ListView的Item
  Widget buildGoodCourseItem(CourseDetail mCourseDetail) {
    return Container(
      height: 140,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(10),
      child: InkWell(
          onTap: () => {},
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

  @override
  ShopPresenter createPresenter() {
    return _shopPresenter;
  }

  @override
  bool get wantKeepAlive => true;

  /// banner组件
  Widget getBanner(List<CourseBanner> courseBannerList) {
    return Container(
      height: ScreenUtil().setHeight(250),
      // 高度 插件 flutter_screenutil
      child: Swiper(
        scrollDirection: Axis.horizontal,
        // 横向
        itemCount: courseBannerList.length,
        // 数量
        autoplay: true,
        // 自动翻页
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(courseBannerList[index].img),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          );
        },
        // 构建
        onTap: (index) {
          NavigatorUtils.goWebViewPage(context, courseBannerList[index].title,
              courseBannerList[index].url);
          print('点击了第${index}');
        },
        // 点击事件 onTap
        pagination: SwiperPagination(
            // 分页指示器
            alignment: Alignment.bottomCenter,
            // 位置 Alignment.bottomCenter 底部中间
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            // 距离调整
            builder: DotSwiperPaginationBuilder(
                // 指示器构建
                space: ScreenUtil().setWidth(5),
                // 点之间的间隔
                size: ScreenUtil().setWidth(10),
                // 没选中时的大小
                activeSize: ScreenUtil().setWidth(12),
                // 选中时的大小
                color: Colors.black54,
                // 没选中时的颜色
                activeColor: Colors.white)),
        // 选中时的颜色
//            control: new SwiperControl(color: Colors.pink), // 页面控制器 左右翻页按钮
        viewportFraction: 0.85,
        // 当前视窗展示比例 小于1可见上一个和下一个视窗
        scale: 0.9, // 两张图片之间的间隔
      ),
    );
  }
}
