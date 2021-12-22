import 'package:courseflutter/mode/shop/discovery/discovery_course_page.dart';
import 'package:courseflutter/provider/current_index_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'main/qh_home_page.dart';


class QHShopIndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text("首页"), //首页
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      title: Text("学习"), //学习
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.ac_unit),
      title: Text("发现"), //发现
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text("个人"), //个人
    ),
  ];

  final List<Widget> tabBodies = [
    QhHomePage(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    //取到当前索引状态值
    int currentIndex = Provider.of<CurrentIndexProvider>(context).currentIndex;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index){
          Provider.of<CurrentIndexProvider>(context,listen: false).changeIndex(index);
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children:tabBodies,
      ),
    );
  }
}
