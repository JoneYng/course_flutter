import 'dart:convert';

import 'package:courseflutter/mode/qhdemo/main/qh_home_page.dart';
import 'package:courseflutter/mode/qhdemo/services/http_config.dart';
import 'package:courseflutter/mode/qhdemo/services/qh_dio_utils.dart';
import 'package:courseflutter/mvp/base_page_presenter.dart';
import 'package:oktoast/oktoast.dart';

import 'QHAdvertisingContent.dart';
import 'QHHomeBean.dart';

class QhHomePresenter extends BasePagePresenter<QhHomeState> {
  @override
  void initState() {
    // getAnchors().then(
    //   (value) => {
    //     view.setBannerList()
    //   },
    // );
  }

  void getAdvertInfo() {
    var requestBody = [
      "App00001",
      "App00002",
      "App00003",
      "App00004",
      "App00005",
      "App00010"
    ];
    QhDioUtils.instance.asyncRequestNetwork<QHHomeBean>(
        QHMethod.post, advertInfo,
        params: requestBody, onSuccessList: (data) {
      print('发送请求2：${data.toString()}');
      List<QHAdvertisingContent> _listCourseBanner = [];
      List<QHAdvertisingContent> _listDistrict = [];
      List<QHAdvertisingContent> _listAdvertisement = [];
      List<QHAdvertisingContent> _listLiveOpen = [];
      for (var value in data) {
        if (value.adCode == "App00001") {
          _listCourseBanner.addAll(value.advertisingContentWebInfoRespVOS);
        }else if(value.adCode == "App00002"){
          _listDistrict.addAll(value.advertisingContentWebInfoRespVOS);
        }else if(value.adCode == "App00003"){
          _listAdvertisement.addAll(value.advertisingContentWebInfoRespVOS);
        }else if(value.adCode == "App00005"){
          _listLiveOpen.addAll(value.advertisingContentWebInfoRespVOS);
        }
      }
      view.setBannerList(_listCourseBanner,_listDistrict,_listAdvertisement,_listLiveOpen);
    }, onError: (code, msg) {
      showToast(msg);
    }, isList: true);
  }
}
