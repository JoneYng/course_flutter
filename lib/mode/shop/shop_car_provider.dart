import 'package:courseflutter/mode/shop/discovery/bean/course_detail_bean.dart';
import 'package:flutter/material.dart';

class ShopCarProvider extends ChangeNotifier {
  List<CourseDetail> _listShopItem = [];//购物车列表
  List<CourseDetail> get listShopItem => _listShopItem;
  double selectMoney = 0; //选中金额
  int selectNum = 0;//选中数量
  bool selectAll = false;//是否全部选中

  ///添加到购物车
  bool addShop(CourseDetail shopItem) {
    shopItem.isSelect=false;
    for (var i = 0; i < _listShopItem.length; i++) {
      //购物车里是否存在
      if (_listShopItem[i].id == shopItem.id) {
        return false;
      }
    }
    _listShopItem.add(shopItem);
    notifyListeners();
  }

  /// 修改选择
  void changeSelect(int index) {
    _listShopItem[index].isSelect = !_listShopItem[index].isSelect;
    calculationAmount();
    setSelectAll();
    notifyListeners();
  }

  ///计算金额
  void calculationAmount() {
    selectMoney = 0;
    selectNum = 0;
    for (var i = 0; i < _listShopItem.length; i++) {
      if (_listShopItem[i].isSelect) {
        selectMoney += _listShopItem[i].courseSalePrice;
        selectNum++;
      }
    }
  }

  /// 修改选择
  void changeSelectAll() {
    for (var i = 0; i < _listShopItem.length; i++) {
      _listShopItem[i].isSelect = !selectAll;
    }
    setSelectAll();
    notifyListeners();
  }

  ///设置是否全部选中
  void setSelectAll() {
    selectAll = false;
    for (var i = 0; i < _listShopItem.length; i++) {
      selectAll = _listShopItem[i].isSelect;
      if (!_listShopItem[i].isSelect) {
        break;
      }
    }
    calculationAmount();
    notifyListeners();
  }

  /// 删除选中
  void deleteSelect() {
    for (var i = 0; i < _listShopItem.length; i++) {
      if (_listShopItem[i].isSelect) {
        _listShopItem.remove(_listShopItem[i]);
        i--;
      }
    }
    calculationAmount();
    setSelectAll();
    notifyListeners();
  }
}
