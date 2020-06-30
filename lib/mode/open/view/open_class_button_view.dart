import 'package:common_utils/common_utils.dart';
import 'package:courseflutter/res/colors.dart';
import 'package:courseflutter/routers/fluro_navigator.dart';
import 'package:courseflutter/util/log_utils.dart';
import 'package:courseflutter/util/toast.dart';
import 'package:flutter/material.dart';
import '../open_class_entity.dart';

/// 公开课按钮
class OpenClassButtonView extends StatelessWidget {
  final OpenClassEntity mOpenClassEntity;

  const OpenClassButtonView({
    Key key,
    this.mOpenClassEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  getWidget(getButtonState(mOpenClassEntity),context);
  }

  Widget getWidget(OpenClassState mOpenClassState,BuildContext context){
    if(mOpenClassState==OpenClassState.NotStarted){
      return OutlineButton(
        borderSide: BorderSide(color: Colours.dark_text_gray, width: 1),
        child: Text(
          "未开始",
          style: TextStyle(color: Colours.dark_text_gray),
        ),
        onPressed: () {
          Toast.show("直播未开始~");
        },
      );
    }else if(mOpenClassState==OpenClassState.Start){
      return OutlineButton(
        borderSide: BorderSide(color: Colours.app_main, width: 1),
        child: Text(
          "观看",
          style: TextStyle(color: Colours.app_main),
        ),
        onPressed: () {
          NavigatorUtils.goWebViewPage(context, mOpenClassEntity.site_cn,
              mOpenClassEntity.live_url);
        },
      );
    }else{
      return OutlineButton(
        borderSide: BorderSide(color: Colours.dark_text_gray, width: 1),
        child: Text(
          "已结束",
          style: TextStyle(color: Colours.dark_text_gray),
        ),
        onPressed: () {
          Toast.show("直播已结束~");
        },
      );
    }
  }

  /// 获取直播状态
  OpenClassState getButtonState(OpenClassEntity mOpenClassEntity) {
    OpenClassState mOpenClassState =OpenClassState.Start;
    var nowMilliseconds = DateTime.now().millisecondsSinceEpoch/1000;
    if(nowMilliseconds<mOpenClassEntity.stime){
      mOpenClassState =OpenClassState.NotStarted;
    }else if(nowMilliseconds>mOpenClassEntity.stime&&nowMilliseconds<mOpenClassEntity.etime){
      mOpenClassState =OpenClassState.Start;
    }else{
      mOpenClassState =OpenClassState.End;
    }
    return mOpenClassState;
  }
}
///直播状态
enum OpenClassState {
  NotStarted,//直播未开始
  Start,//直播中
  End//直播已结束
}
