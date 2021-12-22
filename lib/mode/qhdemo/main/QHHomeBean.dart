import 'QHAdvertisingContent.dart';

class QHHomeBean {
  String adCode;
  String adSize;
  List<QHAdvertisingContent> advertisingContentWebInfoRespVOS = [];

  QHHomeBean.fromJson(Map<String, dynamic> json) {
    adCode = json['adCode'];
    adSize = json['adSize'];
    if (json['advertisingContentWebInfoRespVOS'] is List) {
      (json['advertisingContentWebInfoRespVOS'] as List).forEach((item) {
        var content = QHAdvertisingContent.fromJson(item);
        advertisingContentWebInfoRespVOS.add(content);
      });
    }
  }
}
