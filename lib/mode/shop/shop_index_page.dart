import 'package:courseflutter/mode/shop/discovery/discovery_course_page.dart';
import 'package:courseflutter/provider/current_index_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'myaccount/my_account_page.dart';
import 'mycourse/my_course_page.dart';

class ShopIndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text("发现课程"), //首页
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      title: Text("我的课程"), //分类
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text("我的账户"), //会员中心
    ),
  ];

  final List<Widget> tabBodies = [
    DiscoveryCoursePage(),
    MyCoursePage(),
    MyAccountPage(),
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
