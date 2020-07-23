
import 'package:courseflutter/mode/shop/shop_index_page.dart';
import 'package:courseflutter/routers/router_init.dart';
import 'package:fluro/fluro.dart';


class ShopRouter implements IRouterProvider{

  static String shopPage = '/shop';

  @override
  void initRouter(Router router) {
    router.define(shopPage, handler: Handler(handlerFunc: (_, params) => ShopIndexPage()));
  }
  
}