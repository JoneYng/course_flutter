import 'package:courseflutter/mode/splash_page.dart';
import 'package:courseflutter/provider/theme_provider.dart';
import 'package:courseflutter/routers/application.dart';
import 'package:courseflutter/routers/routers.dart';
import 'package:courseflutter/util/log_utils.dart';
import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Apps());
}

class Apps extends StatelessWidget {
  final Widget home;
  Apps({this.home}) {
    Log.init();
    SpUtil.getInstance();
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }
  @override
  Widget build(BuildContext context) {
     return OKToast(
        child: ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
          child: Consumer<ThemeProvider>(
            builder: (_, provider, __) {
              return MaterialApp(
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
          ),
        ),
        /// Toast 配置
        backgroundColor: Colors.black54,
        textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        radius: 20.0,
        position: ToastPosition.bottom
    );
  }
}

