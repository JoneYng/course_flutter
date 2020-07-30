import 'dart:io';

import 'package:courseflutter/mode/splash_page.dart';
import 'package:courseflutter/provider/current_index_provider.dart';
import 'package:courseflutter/provider/theme_provider.dart';
import 'package:courseflutter/routers/application.dart';
import 'package:courseflutter/routers/routers.dart';
import 'package:courseflutter/util/log_utils.dart';
import 'package:courseflutter/widgets/provider_widget.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'mode/shop/shop_car_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Apps());
  // 透明状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class Apps extends StatelessWidget {
  final Widget home;

  Apps({this.home}) {
    Log.init();
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
        /// Toast 配置
        backgroundColor: Colors.black54,
        textPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        radius: 20.0,
        position: ToastPosition.bottom,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CurrentIndexProvider()),
            ChangeNotifierProvider(create: (_) => ShopCarProvider()),
          ],
          child: ProviderWidget<ThemeProvider>(
            model: ThemeProvider(),
            builder: (context, provider, childe) {
              return  MaterialApp(
//              showPerformanceOverlay: true, //显示性能标签
//              debugShowCheckedModeBanner: false,
//              checkerboardRasterCacheImages: true,
//              showSemanticsDebugger: true, // 显示语义视图
                theme: provider.getTheme(),
                darkTheme: provider.getTheme(isDarkMode: true),
                home: home ?? SplashPage(),
                onGenerateRoute: Application.router.generator,
              );
            },
          )
        ));
  }
}
