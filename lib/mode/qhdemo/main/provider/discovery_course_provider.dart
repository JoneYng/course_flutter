
import 'package:flutter/material.dart';

import '../QHAdvertisingContent.dart';

class QhHomeBannerProvider extends ChangeNotifier {
  List<QHAdvertisingContent> _listCourseBanner = [];//首页banner
  List<QHAdvertisingContent> _listDistrict = [];//首页金刚区
  List<QHAdvertisingContent> _listAdvertisement = [];//广告区域
  List<QHAdvertisingContent> _listLiveOpen = [];//直播公开课
  List<QHAdvertisingContent> get listCourseBanner => _listCourseBanner;
  List<QHAdvertisingContent> get listDistrict => _listDistrict;
  List<QHAdvertisingContent> get listAdvertisement => _listAdvertisement;
  List<QHAdvertisingContent> get listLiveOpen => _listLiveOpen;

  void setBanner(List<QHAdvertisingContent> listCourseBanner,List<QHAdvertisingContent> listDistrict
      ,List<QHAdvertisingContent> listAdvertisement,List<QHAdvertisingContent> listLiveOpen) {
    _listCourseBanner = listCourseBanner;
    _listDistrict = listDistrict;
    _listAdvertisement = listAdvertisement;
    _listLiveOpen = listLiveOpen;
    notifyListeners();
  }

}
