import 'QHAdvertisingContent.dart';

class QHTeacherBean {
  String name;
  String teacherHead;
  String topicWebHead;
  String teacherBriefShort;

  QHTeacherBean.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    teacherHead = json['teacherHead'];
    topicWebHead = json['topicWebHead'];
    teacherBriefShort = json['teacherBriefShort'];
  }
}
