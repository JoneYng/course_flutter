import 'dart:convert';

import 'package:courseflutter/common/common.dart';
import 'package:courseflutter/common/entity_factory.dart';

class BaseEntity<T> {
  int status;
  String message;
  T result;
  List<T> listData = [];

  BaseEntity(this.status, this.message, this.result);

  Map<String, dynamic> parseData(String data) {
    return json.decode(data);
  }

  BaseEntity.fromJson(Map<String, dynamic> jsons) {
//    json = parseData(json[Constant.data]);
    var json = jsons[Constant.data];
    status = json[Constant.status];
    message = json[Constant.message];
    if (json.containsKey(Constant.result)) {
      if (json[Constant.result] is List) {
        (json[Constant.result] as List).forEach((item) {
          listData.add(_generateOBJ<T>(item));
        });
      } else {
        result = _generateOBJ(json[Constant.result]);
      }
    }
  }

  S _generateOBJ<S>(json) {
    if (S.toString() == 'String') {
      return json.toString() as S;
    } else if (T.toString() == 'Map<dynamic, dynamic>') {
      return json as S;
    } else {
      return EntityFactory.generateOBJ(json);
    }
  }
}
