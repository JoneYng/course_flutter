import 'package:courseflutter/mode/shop/discovery/bean/course_detail_bean.dart';
import 'package:courseflutter/widgets/app_bar.dart';
import 'package:courseflutter/widgets/loading_container.dart';
import 'package:flutter/material.dart';

// 定义一个常量
const kAppBar_Scroll_Offset = 100;

class CourseDetailPage extends StatefulWidget {
  CourseDetail mCourseDetail;

  CourseDetailPage(CourseDetail mCourseDetail) {
    this.mCourseDetail = mCourseDetail;
  }

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState(mCourseDetail);
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  CourseDetail mCourseDetail = new CourseDetail();
  bool _loading = true;

  // 顶部导航默认值
  double appBarAlpha = 0;

  _CourseDetailPageState(CourseDetail mCourseDetail) {
    this.mCourseDetail = mCourseDetail;
  }

  @override
  void initState() {
    _loading = false;
  }

  Future<Null> _handleRefresh() async {
    // 一种方式
    setState(() {
      _loading = false;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //移出顶部状态安全区域
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(
          child: Stack(
            //层叠布局 将自定义得appBar放在 列表上面
            children: <Widget>[
              // 移除ListView距离屏幕顶部得边距
              MediaQuery.removePadding(
                removeTop: true, //移出哪边得安全区域
                context: context,
                child: RefreshIndicator(
                    child: NotificationListener(
                      onNotification: (scrollNotification) {
                        //监听滚动
                        // 滚动变化 才监听 && 第0个元素发生滚动得时候才监听
                        if (scrollNotification is ScrollUpdateNotification &&
                            scrollNotification.depth == 0) {
                          _onScroll(scrollNotification.metrics.pixels);
                        }
                      },
                      child: _listView,
                    ),
                    onRefresh: _handleRefresh),
              ),
              // appBar
              _appBar,
            ],
          ),
          isLoading: _loading),
    );

    Scaffold(
      appBar: const MyAppBar(centerTitle: '课程详情', isBack: true),
      body: Text(mCourseDetail.courseTitle),
    );
  }

  // 列表
  Widget get _listView {
    return ListView(
      children: <Widget>[
        Image.network(
            "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2534506313,1688529724&fm=26&gp=0.jpg"),
        Image.network(
            "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2534506313,1688529724&fm=26&gp=0.jpg"),
        Image.network(
            "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2534506313,1688529724&fm=26&gp=0.jpg"),
        Image.network(
            "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2534506313,1688529724&fm=26&gp=0.jpg"),
        Image.network(
            "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2534506313,1688529724&fm=26&gp=0.jpg"),
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: Text("localNavList: localNavList"),
        ),
      ],
    );
  }

  _onScroll(offset) {
    print(offset);
    double alpha = offset / kAppBar_Scroll_Offset;
    // 判断滚动范围
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });

    print("首页appbar 滚动透明度:$appBarAlpha");
  }

  // appbar
  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: Container(
              alignment:Alignment.center ,
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              child: Text(mCourseDetail.courseTitle),
            ),
          ),
        ),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)],
          ),
        ),
      ],
    );
  }
}
