import 'package:common_utils/common_utils.dart';
import 'package:courseflutter/common/common.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:courseflutter/mvp/base_page_presenter.dart';
import 'package:courseflutter/net/dio_utils.dart';
import 'package:courseflutter/net/http_api.dart';

import '../open_class_entity.dart';
import '../open_class_page.dart';

class OpenClassPresenter extends BasePagePresenter<OpenClassPageState> {
  @override
  void initState() {
    var dateList = getDate();
    view.setOpenClassDateList(dateList);
    getOpenClass(dateList[0].query_date);
  }

  void getOpenClass(String queryDate) {
//    Constant.KVersion_Value="V2";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Map<String, dynamic> queryParameters = Map();
      queryParameters["day"] = queryDate;
      queryParameters["subject"] = 0;
      queryParameters["both"] = 1;

      /// get请求参数queryParameters  post请求参数params
      requestNetwork<OpenClassRoot>(Method.get,
          url: HttpApi.open_class,
          queryParameters: queryParameters, onSuccess: (data) {
        view.setOpenClassList(data.mOpenClassEntity);
      }, onError: (code, msg) {
        List<OpenClassEntity> mOpenClassEntity = [];
        view.setOpenClassList(mOpenClassEntity);
      });
    });
  }

  /// 获取近一周的时间
  List<OpenClassDateEntity> getDate() {
    List<OpenClassDateEntity> openClassDateEntity = new List();
    var today = DateTime.now();
    for (var i = 0; i < 7; i++) {
      //时间增加
      var fiftyDaysFromNow = today.add(new Duration(days: i));
      var mOpenClassDateEntity = OpenClassDateEntity();
      mOpenClassDateEntity.date =
          DateUtil.formatDate(fiftyDaysFromNow, format: "dd");
      mOpenClassDateEntity.query_date =
          DateUtil.formatDate(fiftyDaysFromNow, format: "yyyy-MM-dd");
      if (DateUtil.isToday(fiftyDaysFromNow.millisecondsSinceEpoch)) {
        mOpenClassDateEntity.week = "今天";
      } else {
        mOpenClassDateEntity.week =
            getWeekday(fiftyDaysFromNow, languageCode: "zh");
      }
      mOpenClassDateEntity.isSelect = i == 0;
//      print(mOpenClassDateEntity.toString());
      openClassDateEntity.add(mOpenClassDateEntity);
    }
    return openClassDateEntity;
  }

  String getWeekday(DateTime dateTime,
      {String languageCode = 'en', bool short = false}) {
    if (dateTime == null) return null;
    String weekday;
    switch (dateTime.weekday) {
      case 1:
        weekday = languageCode == 'zh' ? '周一' : "Monday";
        break;
      case 2:
        weekday = languageCode == 'zh' ? '周二' : "Tuesday";
        break;
      case 3:
        weekday = languageCode == 'zh' ? '周三' : "Wednesday";
        break;
      case 4:
        weekday = languageCode == 'zh' ? '周四' : "Thursday";
        break;
      case 5:
        weekday = languageCode == 'zh' ? '周五' : "Friday";
        break;
      case 6:
        weekday = languageCode == 'zh' ? '周六' : "Saturday";
        break;
      case 7:
        weekday = languageCode == 'zh' ? '周日' : "Sunday";
        break;
      default:
        break;
    }
    return languageCode == 'zh'
        ? (short ? weekday.replaceAll('星期', '周') : weekday)
        : weekday.substring(0, short ? 3 : weekday.length);
  }
}
