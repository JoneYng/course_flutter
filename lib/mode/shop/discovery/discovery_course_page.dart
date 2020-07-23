import 'package:courseflutter/mode/shop/discovery/presenter/discovery_course_presenter.dart';
import 'package:courseflutter/mode/shop/discovery/provider/discovery_course_provider.dart';
import 'package:courseflutter/mvp/base_page_state.dart';
import 'package:courseflutter/routers/fluro_navigator.dart';
import 'package:courseflutter/widgets/app_bar.dart';
import 'package:courseflutter/widgets/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'banner_bean.dart';

///商城页面
class DiscoveryCoursePage extends StatefulWidget {
  @override
  ShopPageState createState() => ShopPageState();
}

class ShopPageState extends BasePageState<DiscoveryCoursePage, ShopPresenter>
    with AutomaticKeepAliveClientMixin<DiscoveryCoursePage> {
  DiscoveryCourseProvider _provider = DiscoveryCourseProvider();
  ShopPresenter _shopPresenter = new ShopPresenter();

  void setBannerList(List<CourseBanner> list) {
    _provider.setBanner(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(centerTitle: '商城', isBack: true),
      body: Column(children: <Widget>[
        ProviderWidget<DiscoveryCourseProvider>(
          model: _provider,
          builder: (context, model, childe) {
            if (model.list.length > 0) {
              return getBanner(model.list);
            } else {
              return Container();
            }
          },
        ),
      ]),
    );
  }

  @override
  ShopPresenter createPresenter() {
    return _shopPresenter;
  }

  @override
  bool get wantKeepAlive => true;

  /// banner组件
  Widget getBanner(List<CourseBanner> courseBannerList) {
    return Container(
      height: ScreenUtil().setHeight(250),
      // 高度 插件 flutter_screenutil
      child: Swiper(
        scrollDirection: Axis.horizontal,
        // 横向
        itemCount: courseBannerList.length,
        // 数量
        autoplay: true,
        // 自动翻页
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(courseBannerList[index].img),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          );
        },
        // 构建
        onTap: (index) {
          NavigatorUtils.goWebViewPage(context, courseBannerList[index].title,
              courseBannerList[index].url);
          print('点击了第${index}');
        },
        // 点击事件 onTap
        pagination: SwiperPagination(
            // 分页指示器
            alignment: Alignment.bottomCenter,
            // 位置 Alignment.bottomCenter 底部中间
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            // 距离调整
            builder: DotSwiperPaginationBuilder(
                // 指示器构建
                space: ScreenUtil().setWidth(5),
                // 点之间的间隔
                size: ScreenUtil().setWidth(10),
                // 没选中时的大小
                activeSize: ScreenUtil().setWidth(12),
                // 选中时的大小
                color: Colors.black54,
                // 没选中时的颜色
                activeColor: Colors.white)),
        // 选中时的颜色
//            control: new SwiperControl(color: Colors.pink), // 页面控制器 左右翻页按钮
        viewportFraction: 0.85,
        // 当前视窗展示比例 小于1可见上一个和下一个视窗
        scale: 0.9, // 两张图片之间的间隔
      ),
    );
  }
}
