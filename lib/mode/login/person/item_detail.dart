import 'package:courseflutter/res/resources.dart';
import 'package:courseflutter/util/theme_utils.dart';
import 'package:flutter/material.dart';

/// 主页按钮
class ItemDetail extends StatelessWidget {
  final Function onTap; //点击事件
  final String leftText; //左侧显示文字
  final String rightText; //右侧显示文字
  final Widget leftIcon; //左侧图片
  final bool isRight; //是否显示右侧
  final bool isRightImage; //是否显示右侧图片
  final String rightImageUri; //右侧图片地址
  final bool isRightText; //是否显示右侧文字

  const ItemDetail({
    Key key,
    this.leftText = "",
    this.leftIcon,
    this.rightText = "",
    this.isRight = true,
    this.isRightImage = false,
    this.rightImageUri = "",
    this.isRightText = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);

    return new Container(
      width: double.infinity,
      height: 50,
      child:  Material(
        color: isDark ? Colours.dark_bg_color : Colours.bg_color,
          child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                  children: <Widget>[
                    leftIcon,
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        leftText,
                        style: TextStyle(fontSize: 15.0, color: Colors.grey),
                      ),
                    )
                  ]),
              Visibility(
                visible: isRight,
                child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Row(children: <Widget>[
                          Visibility(
                              visible: isRightText,
                              child: Text(
                                rightText,
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.grey),
                              )),
                          Visibility(
                              visible: isRightImage,
                              child: CircleAvatar(
                                backgroundImage: getBackgroundImage(rightImageUri),
                              ))
                        ]),
                      ),
                      Images.arrowRight
                    ]),
              )
            ],
          ),
        ),
      )),
    );
  }

  ImageProvider getBackgroundImage(String rightImageUri){
    if(rightImageUri.contains("http")){
      return NetworkImage(rightImageUri);
    }else{
      return AssetImage(rightImageUri);
    }
  }
}
