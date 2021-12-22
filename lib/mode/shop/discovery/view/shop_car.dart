import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopCarView extends StatelessWidget {
  final int count;
  final Function onTap;

  const ShopCarView({
    Key key,
    this.count = 0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
            child: Stack(
              children: <Widget>[
                Icon(
                  Icons.shopping_cart,
                ),
                Visibility(
                    visible: count > 0 ? true : false,
                    child: Container(
                      height: 15,
                      width: 15,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 15, bottom: 0),
                      decoration: new BoxDecoration(
                        color: Colors.red, // 底色
                        borderRadius: new BorderRadius.circular((10.0)), // 圆角度
                      ),
                      child: Text(
                        "$count",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    )),
              ],
            )));
  }
}
