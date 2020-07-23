import 'package:courseflutter/mode/course/video/presenter/video_class_presenter.dart';
import 'package:courseflutter/mode/course/video/provider/video_provider.dart';
import 'package:courseflutter/mode/course/video/video_entity.dart';
import 'package:courseflutter/mvp/base_page_state.dart';
import 'package:courseflutter/res/resources.dart';
import 'package:courseflutter/util/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class VideoClassPage extends StatefulWidget {
  @override
  VideoClassPageState createState() => VideoClassPageState();
}

class VideoClassPageState
    extends BasePageState<VideoClassPage, VideoClassPresenter>
    with
        AutomaticKeepAliveClientMixin<VideoClassPage>,
        SingleTickerProviderStateMixin {
  VideoProvider _provider = VideoProvider();
  VideoClassPresenter _videoClassPresenter = VideoClassPresenter();
  List<VideoEntity> _sideoEntityList = [];

  int _page = 1;
  ScrollController _controller;
  int _count = 10;
  bool _isRefreshing = false;
  bool isLoding = true;
  String loadingText = "加载中.....";
  bool isDark=false;
  void setVideoList(List<VideoEntity> user, bool isLoadMore) {
    _provider.setVideoList(user, isLoadMore);
    isLoding = isLoadMore;
  }

  @override
  void initState() {
    _controller = ScrollController();
    _videoClassPresenter.getVideoList(_page, _count, true);
    _controller.addListener(() {
      int offset = _controller.position.pixels.toInt();
      // 如果滑动到底部
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print("滑动到底部");
        if (isLoding) {
          _videoClassPresenter.getVideoList(_page++, _count, false);
        }
      }
    });
  }

  @override
  void dispose() {
    // 记得销毁对象
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isDark = ThemeUtils.isDark(context);
    return ChangeNotifierProvider<VideoProvider>(
        create: (_) => _provider, child: _widget(_provider));
  }

  @override
  createPresenter() {
    return _videoClassPresenter;
  }

  @override
  bool get wantKeepAlive => true;

  Widget _widget(VideoProvider _provider) {
    if (_provider.videoEntity != null) {
      _sideoEntityList.clear();
      _sideoEntityList.addAll(_provider.videoEntity);
    }
    if (_sideoEntityList != null && _sideoEntityList.length > 0) {
      return Scaffold(
        body: RefreshIndicator(
          child:  CustomScrollView(
            primary: false,
            controller: _controller,
            physics: ScrollPhysics(),
            //滑动效果，如阻尼效果等等
//            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              getTitle(),
              SliverToBoxAdapter(
                child: Gaps.vGap10,
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.2, //子控件宽高比
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return getVideoItem(_sideoEntityList[index], index);
                  },
                  childCount: _sideoEntityList.length,
                ),
              ),
              new SliverToBoxAdapter(
                child:  Visibility(
                  child:  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child:  Center(
                      child:  Text(loadingText),
                    ),
                  ),
                  visible: _provider.isLoadMore,

                ),
              ),
            ],
          ),
          onRefresh: () {
            return _RrefreshPull().then((value) {
              print('success');
            }).catchError((error) {
              print('failed');
            });
          },
        ),
      );
    } else {
      return Scaffold(
        body:  CustomScrollView(
          //滑动效果，如阻尼效果等等
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            getTitle(),
          ],
        ),
      );
    }
  }

  Future<String> _RrefreshPull() async {
    _page = 1;
    _count = 10;
    _sideoEntityList.clear();
    _videoClassPresenter.getVideoList(_page, _count, true);
    await Future.delayed(new Duration(seconds: 1));
    return "_RrefreshPull";
  }

//获取到插件与原生的交互通道
  var jumpPlugin = const MethodChannel('com.kmf.jump/plugin');

  Future<Null> _jumpToNative(VideoEntity videoEntity) async {
    print("polyId::"+ videoEntity.poly_id);
    Map<String, String> map = {"polyId": videoEntity.poly_id,"title": videoEntity.title};
    String result = await jumpPlugin.invokeMethod('oneAct', map);
    print(result);
  }

  ///获取视频课item组件
  Widget getVideoItem(VideoEntity videoEntity, int positon) {
    return GestureDetector(
      onTap: () {
        _jumpToNative(videoEntity);
      },
      child: Card(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),  //设置圆角
        child: Column(children: <Widget>[
          Expanded(
              child: Stack(
            children: <Widget>[
              Container(
                //设置背景图片
                decoration:  BoxDecoration(
                  borderRadius:  BorderRadius.only(
                      topLeft:  Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                  image:  DecorationImage(
                    fit: BoxFit.fill,
                    image:  NetworkImage(videoEntity.img_url),
                  ),
                ),
              ),
              Container(
                child: Images.play,
                padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
              )
            ],
            alignment: const FractionalOffset(0.5, 0.5),
          )),
          Container(
            alignment: Alignment.center,
            height: 40,
            child: Text(
              videoEntity.description,
              maxLines: 2,
              style: TextStyle(fontSize: 12),
            ),
          )
        ]),
      ),
    );
  }

  /// 获取标题布局
  Widget getTitle() {
    return new SliverAppBar(
      leading: GestureDetector(
        child: Icon(
          Icons.arrow_back,
          color: isDark ? Colours.bg_color : Colours.dark_bg_color,
        ),
        onTap: () => Navigator.pop(context),
      ),
      //左侧按钮
      elevation: 4,
      //阴影的高度
      forceElevated: true,
      //是否显示阴影
      backgroundColor: isDark ? Colours.dark_bg_color : Colours.bg_color,
      iconTheme: IconThemeData(color: Colors.white, size: 25, opacity: 1),
      primary: true,
      // appbar是否显示在屏幕的最上面，为false是显示在最上面，为true就显示在状态栏的下面
      titleSpacing: 16,
      expandedHeight: 120.0,
      pinned: true,
      //是否固定导航栏，为true是固定，为false是不固定，往上滑，导航栏可以隐藏
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding:
            const EdgeInsetsDirectional.only(start: 50.0, bottom: 12.0),
        title: Text(
          '专项视频课',
          style: new TextStyle(fontSize: 20.0, color: isDark ? Colours.dark_text : Colours.text),
        ),
      ),
    );
  }
}
