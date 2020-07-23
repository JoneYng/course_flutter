import 'package:courseflutter/res/gaps.dart';
import 'package:courseflutter/widgets/app_bar.dart';
import 'package:flutter/material.dart';

///商品
class ShopItem {
  ShopItem(this.name,this.price, this.count);
  String name = "";
  double price = 0; //商品单价
  int count = 0; // 商品份数
}
