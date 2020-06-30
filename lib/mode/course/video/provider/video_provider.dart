
import 'package:flutter/material.dart';

import '../video_entity.dart';


class VideoProvider extends ChangeNotifier {

  List<VideoEntity> _videoEntity;
  bool _isLoadMore=true;
  bool get isLoadMore => _isLoadMore;
  List<VideoEntity> get videoEntity => _videoEntity;
  
  void setVideoList(List<VideoEntity> videoEntity,bool isLoadMore) {
    _videoEntity = videoEntity;
    _isLoadMore = isLoadMore;
    notifyListeners();
  }
}