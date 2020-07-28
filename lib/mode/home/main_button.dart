import 'package:flutter/material.dart';

/// 主页按钮
class MainButton extends StatelessWidget {
  //点击事件
  final Function onTap;
  //按钮文字
  final String text;

  const MainButton({
    Key key,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new  Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(top:15.0),
      child: InkWell(
        //在最外层包裹InkWell组件,用于点击事件
        onTap: onTap,
        child:
        Container(
          decoration: BoxDecoration(
              //父组件圆角
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                  //BoxFit.fill:充满父容器
                  //BoxFit.contain:尽可能大，保持图片分辨率
                  //BoxFit.cover:充满容器，可能会被截断
                  //BoxFit.none:图片居中显示，不改变分大小，可能会被截断
                  //BoxFit.fitWidth:图片填满宽度，高度可能会被截断
                  //BoxFit.fitHeight:图片填满高度，宽度可能会被截断
                  //BoxFit.scaleDown:图片可以完整显示，但是可能不能填充满
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/btn_main_my_class.png")
              )),
          child: Center(
            //加上Center让文字居中
            child: Text(
              text,
              style: new TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
