
class QHTokenBean{
  String token;
  dynamic isNewUser;

  QHTokenBean.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    isNewUser = json['isNewUser'];
  }
}