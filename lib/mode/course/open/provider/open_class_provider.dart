import 'package:flutter/material.dart';

import '../../video/video_entity.dart';
import '../open_class_entity.dart';

class OpenClassProvider extends ChangeNotifier {
  List<OpenClassDateEntity> _openClassDateEntity;
  List<OpenClassEntity> _openClassEntity;

  List<OpenClassDateEntity> get openClassDateEntity => _openClassDateEntity;
  List<OpenClassEntity> get openClassEntity => _openClassEntity;

  void setOpenClassList(List<OpenClassDateEntity> openClassDateEntity) {
    _openClassDateEntity = openClassDateEntity;
    notifyListeners();
  }

  void setOpenClass(List<OpenClassEntity> openClassEntity) {
    _openClassEntity = openClassEntity;
    notifyListeners();
  }
}
