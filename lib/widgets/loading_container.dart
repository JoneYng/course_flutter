import 'package:flutter/material.dart';

/**
  *
  * @ClassName:      加载进度条组件
  * @Description:    类作用描述
 */
class LoadingContainer extends StatelessWidget {

  final Widget child;
  final bool isLoading;
  final bool cover;


  LoadingContainer({
    Key key,
    @required this.child,
    @required this.isLoading,
    this.cover = false}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return !cover? !isLoading? child : _loadingView :
      Stack(
        children: <Widget>[
          child,isLoading? _loadingView : null
        ],
      )
    ;
  }

  Widget get _loadingView{
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}