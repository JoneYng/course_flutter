import 'package:flutter/material.dart';

/// 公开课标签
class OpenClassTagView extends StatelessWidget {
  final String text;
  final String tag;

  const OpenClassTagView({
    Key key,
    this.text,
    this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 5),
      width: 100,
      height: 25,
      decoration: getTag(tag),
      child: Center(
        //加上Center让文字居中
        child: Text(
          text,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }

  BoxDecoration getTag(String tag) {
    var messagePath = "";
    var gre = "assets/images/openclass/bg_tag_replay_language.png";
    var gamt = "assets/images/openclass/bg_tag_replay_listening.png";
    var ielts = "assets/images/openclass/bg_tag_replay_reading.png";
    var toefl = "assets/images/openclass/bg_tag_replay_writing.png";

    if (tag == "GRE") {
      messagePath = gre;
    } else if (tag == "GMAT") {
      messagePath = gamt;
    } else if (tag == "托福") {
      messagePath = toefl;
    } else if (tag == "雅思") {
      messagePath = ielts;
    }else{
      messagePath = toefl;
    }
    return BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fitWidth, image: AssetImage(messagePath)));
  }
}
