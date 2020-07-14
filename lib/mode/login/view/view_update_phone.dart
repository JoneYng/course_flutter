import 'package:flutter/material.dart';

class UpdatePhoneDialog extends Dialog {
  String phone;

  UpdatePhoneDialog({Key key, @required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          GestureDetector(onTap: () {
            Navigator.pop(context); //关闭对话框
          }),
          _buildContentView(context), //构建具体的对话框布局内容
        ],
      ),
    );
  }

  Widget _buildContentView(BuildContext context) {
    return Center(
      //保证控件居中效果
      child: SizedBox(
        width: 240.0,
        height: 140.0,
        child: new Container(
          decoration: ShapeDecoration(
            color: Color(0xffffffff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20),
                height: 40,
                alignment: Alignment.center,
                child: Text(
                  "已绑定手机号：" + phone,
                ),
              ),
              Container(
                  padding: EdgeInsets.only(right: 20),
                  height: 40,
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context); //关闭对话框
                      },
                      child: Text('修改绑定手机号',style: TextStyle(color:  Colors.blue),))),
              Container(
                  padding: EdgeInsets.only(right: 20),
                  height: 40,
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context); //关闭对话框
                      },
                      child: Text('取消',style: TextStyle(color:  Colors.blue),))),
            ],
          ),
        ),
      ),
    );
  }
}
