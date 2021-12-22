
import 'QHTeacherBean.dart';

class QHAdvertisingContent{
  String title;
  String startTime;
  String endTime;
  String images;//显示图片
  String skipUrl;//跳转链接
  String productId;//产品Id
  int skipType;//跳转类型
  int realSales;//报名人数
  double sellPrice;//价格
  List<QHTeacherBean> teacherRespVOS = [];

  QHAdvertisingContent.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    startTime = json['startTime'];
    images = json['images'];
    skipUrl = json['skipUrl'];
    skipType = json['skipType'];
    productId = json['productId'];
    realSales = json['realSales'];
    sellPrice = json['sellPrice'];
    if (json['teacherRespVOS'] is List) {
      (json['teacherRespVOS'] as List).forEach((item) {
        var content = QHTeacherBean.fromJson(item);
        teacherRespVOS.add(content);
      });
    }
  }
}
