import 'package:flutter/material.dart';

/// 主页按钮
class MainButton extends StatelessWidget {
  final Function onTap;
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
        //在最外层包裹InkWell组件
        onTap: onTap,
        child:
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
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
