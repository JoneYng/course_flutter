
import 'package:flutter/material.dart';

import '../video_entity.dart';


class VideoProvider extends ChangeNotifier {

  List<VideoEntity> _videoEntity;
  List<VideoEntity> get videoEntity => _videoEntity;
  
  void setVideoList(List<VideoEntity> videoEntity) {
    _videoEntity = videoEntity;
    notifyListeners();
  }
}