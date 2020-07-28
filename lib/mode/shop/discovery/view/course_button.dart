import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseButton extends StatelessWidget {

  final Color color;
  final String text;
  final Function onTap;
  CourseButton({Key key,this.color=Colors.black,this.text='按钮',this.onTap=null}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:this.onTap,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        height: ScreenUtil.getInstance().setHeight(68),
        width: double.infinity,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}