# course_flutter

本项目为学习Flutter的练习项目
## 实现模块
* ListView 列表切换 --公开课模块
* GridView 列表下拉刷新，翻页加载 --视频课模块
* 商城实战  仿网易精选课模块（未完成）
 - 首页列表
 - 购物车逻辑

## 实现内容
* mvp模式
* 使用provider 做状态管理
* 下拉刷新 + 上拉加载更多
* 模块化路由管理
* 使用Sliver 系列组件实现复杂滚动效果
## 注意事项
-  保利威视视频播放目前仅支持Android
- `debug`模式下会有部分卡顿现象，这属于正常现象。良好的体验需要打`release` 包。
    iOS可以执行命令`flutter build ios` 以创建`release`版本。
    Android可以执行命令`flutter build apk` 以创建`release`版本。

## 使用到的三方库
| 库                         | 功能             |
| -------------------------- | --------------- |
| [dio](https://github.com/flutterchina/dio)                            | **网络库**       |
| [provider](https://github.com/rrousselGit/provider)                   | **状态管理**     |
| [cached_network_image](https://github.com/renefloor/flutter_cached_network_image)       | **图片加载**       |
| [fluro](https://github.com/theyakka/fluro)                            | **路由管理**     |
| [flutter_oktoast](https://github.com/OpenFlutter/flutter_oktoast)     | **Toast**        |
| [common_utils](https://github.com/Sky24n/common_utils)                | **Dart 常用工具类库**     |
| [flustars](https://github.com/Sky24n/flustars)                        | **Flutter 常用工具类库**       |
| [rxdart](https://github.com/ReactiveX/rxdart)                         | **Dart的响应式扩展** |
| [webview_flutter](https://github.com/flutter/plugins/tree/master/packages/webview_flutter)    | **WebView插件**       |
| [keyboard_actions](https://github.com/diegoveloper/flutter_keyboard_actions)                  | **处理键盘事件**       |
| [date_utils](https://github.com/apptreesoftware/date_utils)           | **常用的日期工具类** |
| [sprintf](https://github.com/Naddiseo/dart-sprintf)                   | **格式化String**   |
| [flutter_swiper](https://github.com/best-flutter/flutter_swiper)      | **轮播图控件**   |
| [flutter_screenutil](https://github.com/OpenFlutter/flutter_screenutil)                   | **屏幕适配**   |
| [sqflite](https://github.com/tekartik/sqflite)                   | **sqflite**   |


## Thanks For
- [flutter_deer](https://github.com/simplezhli/flutter_deer)



