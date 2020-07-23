import 'package:courseflutter/widgets/app_bar.dart';
import 'package:flutter/material.dart';


class MyCoursePage extends StatefulWidget {
  @override
  _MyCourseState createState() => _MyCourseState();
}

class _MyCourseState extends State<MyCoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(centerTitle: '我的课程', isBack:false),
      body: Text(""),
    );
  }
}
