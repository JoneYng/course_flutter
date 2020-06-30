import 'package:courseflutter/common/common.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:courseflutter/mode/video/video_class_page.dart';
import 'package:courseflutter/mvp/base_page_presenter.dart';
import 'package:courseflutter/net/dio_utils.dart';
import 'package:courseflutter/net/http_api.dart';
import 'package:courseflutter/mode/video/video_entity.dart';

class VideoClassPresenter extends BasePagePresenter<VideoClassPageState> {
  @override
  void initState() {
  }

  void getVideoList(int page,int page_size){
    SpUtil.putString(Constant.KVersion, "V1");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Map<String, dynamic> queryParameters = Map();
      queryParameters["sie"] = "gre";
      queryParameters["page_size"] = page_size;
      queryParameters["page"] = page;

      /// get请求参数queryParameters  post请求参数params
      requestNetwork<VideoRoot>(
        Method.get,
        url: HttpApi.videos,
        queryParameters: queryParameters,
        onSuccess: (data) {
          view.setVideoList(data.mVideoEntityList);
        },
      );
    });
  }
}
