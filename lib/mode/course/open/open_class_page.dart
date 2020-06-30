import 'package:common_utils/common_utils.dart';
import 'package:courseflutter/mode/course/open/presenter/open_class_presenter.dart';
import 'package:courseflutter/mode/course/open/provider/open_class_provider.dart';
import 'package:courseflutter/mvp/base_page_state.dart';
import 'package:courseflutter/res/colors.dart';
import 'package:courseflutter/res/resources.dart';
import 'package:courseflutter/util/load_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/open_class_button_view.dart';
import 'open_class_entity.dart';
import 'view/open_class_tag_view.dart';

/// 公开课页面
class OpenClassPage extends StatefulWidget {
  @override
  OpenClassPageState createState() => OpenClassPageState();
}

class OpenClassPageState
    extends BasePageState<OpenClassPage, OpenClassPresenter>
    with
        AutomaticKeepAliveClientMixin<OpenClassPage>,
        SingleTickerProviderStateMixin {
  OpenClassProvider provider = OpenClassProvider();
  OpenClassPresenter mOpenClassPresenter = OpenClassPresenter();

  void setOpenClassDateList(List<OpenClassDateEntity> openClassDateEntity) {
    provider.setOpenClassList(openClassDateEntity);
  }

  void setOpenClassList(List<OpenClassEntity> openClassEntity) {
    provider.setOpenClass(openClassEntity);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OpenClassProvider>(
        create: (_) => provider,
        child: DefaultTabController(
            length: provider.openClassDateEntity.length,
            child: Scaffold(
              appBar: AppBar(
                leading: GestureDetector(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onTap: () => Navigator.pop(context),
                ),
                title:
                    Text("公开课", style: TextStyle(color: Colours.dark_bg_gray)),
                backgroundColor: Colors.white,
                bottom: TabBar(
                  onTap: (int index) {
                    setState(() {});
                    mOpenClassPresenter.getOpenClass(
                        provider.openClassDateEntity[index].query_date);
                  },
                  isScrollable: true,
                  labelStyle: TextStyle(fontSize: 20),
                  unselectedLabelStyle: TextStyle(fontSize: 15),
                  indicatorColor: Colours.app_main,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colours.app_main,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: getTabWidgets(provider.openClassDateEntity),
                ),
              ),
              body: _widget(provider),
//              TabBarView(
//                physics: new NeverScrollableScrollPhysics(),
//                children: getTabViewPagerWidgets(
//                    provider.openClassDateEntity, provider),
//              )),
            )));
  }

  @override
  OpenClassPresenter createPresenter() {
    return mOpenClassPresenter;
  }

  @override
  bool get wantKeepAlive => true;

  /// 获取横向滚动的item
  Widget getItem(OpenClassDateEntity mOpenClassDateEntity) {
    return new Container(
      width: 100,
      child: new Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: new Text(
              mOpenClassDateEntity.date,
              style: TextStyle(
                  fontSize: 28.0,
                  color: mOpenClassDateEntity.isSelect
                      ? Colors.blueGrey
                      : Colors.black12,
                  fontWeight: FontWeight.w500),
            ),
            color: Colors.white,
          ),
          new Positioned(
              left: 50.0,
              top: 45.0,
              child: new Text(
                mOpenClassDateEntity.week,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15.0,
                    color: mOpenClassDateEntity.isSelect
                        ? Colors.blueAccent
                        : Colors.black38),
              )),
        ],
      ),
    );
  }

  ///公开课列表
  List<Widget> getOpenClass(List<OpenClassEntity> mOpenClassEntity) {
    List<Widget> tabs = List();
    for (var index = 0; index < mOpenClassEntity.length; index++) {
      tabs.add(Column(
        children: <Widget>[
          itemTitle(mOpenClassEntity[index]),
          itemCard(mOpenClassEntity[index])
        ],
      ));
    }
    return tabs;
  }
  ///公开课列表
  Widget _widget(OpenClassProvider provider) {
    if (provider.openClassEntity != null&&provider.openClassEntity.length > 0) {
      return ListView(
        children: getOpenClass(provider.openClassEntity),
      );
    } else {
      return Center(
        child: Images.courseDefault,
      );
    }
  }

  ///公开课标题
  Widget itemTitle(OpenClassEntity mOpenClassEntity) {
    return Container(
        margin: EdgeInsets.only(left: 30.0, right: 10.0, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ConstrainedBox(
              // 可以设置宽度和高度的最大最小值
              constraints: BoxConstraints(
                minHeight: 50.0,
                maxWidth: 200.0,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      DateUtil.formatDateMs(mOpenClassEntity.stime * 1000,
                          format: "HH:mm"),
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                    OpenClassTagView(
                      text: mOpenClassEntity.site_cn +
                          mOpenClassEntity.subject_cn,
                      tag: mOpenClassEntity.site_cn,
                    )
                  ]),
            ),
            OpenClassButtonView(mOpenClassEntity:mOpenClassEntity)
          ],
        ));
  }

  ///公开课内容、老师信息
  Widget itemCard(OpenClassEntity mOpenClassEntity) {
    return Card(
      margin: EdgeInsets.only(left: 30.0, right: 10.0, top: 10),
      child: Container(
        height: 150,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ConstrainedBox(
              // 可以设置宽度和高度的最大最小值
              constraints: BoxConstraints(
                minHeight: 150.0,
                maxWidth: 200.0,
              ),
              child: Text(
                mOpenClassEntity.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
            LoadImage(mOpenClassEntity.mTeacherInfo.head_pic,
                height: 150.0, width: 100.0)
          ],
        ),
      ),
    );
  }

  List<Widget> getTabWidgets(
      List<OpenClassDateEntity> mOpenClassDateEntityList) {
    List<Widget> tabs = List();
    for (var i = 0; i < mOpenClassDateEntityList.length; i++) {
      tabs.add(Tab(
        text: mOpenClassDateEntityList[i].week +
            "(" +
            mOpenClassDateEntityList[i].date +
            ")",
//        child: getItem(mOpenClassDateEntityList[i]),
      ));
    }
    return tabs;
  }

  List<Widget> getTabViewPagerWidgets(
      List<OpenClassDateEntity> mOpenClassDateEntityList,
      OpenClassProvider provider) {
    List<Widget> tabs = List();
    for (var i = 0; i < mOpenClassDateEntityList.length; i++) {
      tabs.add(_widget(provider));
    }
    return tabs;
  }
}
