import 'package:courseflutter/widgets/app_bar.dart';
import 'package:courseflutter/widgets/state_layout.dart';
import 'package:flutter/material.dart';

class WidgetNotFound extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        centerTitle: '页面不存在',
      ),
      body: StateLayout(
        type: StateType.empty,
        hintText: '页面不存在',
      ),
    );
  }
}
