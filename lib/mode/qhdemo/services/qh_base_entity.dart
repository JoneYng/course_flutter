import 'dart:convert';

import 'package:courseflutter/common/common.dart';
import 'package:courseflutter/common/entity_factory.dart';

class QHBaseEntity<T> {
  int code;
  String msg;
  T data;
  List<T> listData = [];

  QHBaseEntity(this.code, this.msg, this.data);

  Map<String, dynamic> parseData(String data) {
    return json.decode(data);
  }

  QHBaseEntity.fromJson(Map<String, dynamic> jsons) {
    var json = jsons[Constant.data];
    code = json[Constant.code];
    msg = json[Constant.msg];
    if (json.containsKey(Constant.data)) {
      if (json[Constant.data] is List) {
        (json[Constant.data] as List).forEach((item) {
          listData.add(_generateOBJ<T>(item));
        });
      } else {
        data = _generateOBJ(json[Constant.data]);
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
