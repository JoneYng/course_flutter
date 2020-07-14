
import 'package:courseflutter/res/dimens.dart';
import 'package:courseflutter/res/gaps.dart';
import 'package:courseflutter/res/styles.dart';
import 'package:courseflutter/routers/fluro_navigator.dart';
import 'package:courseflutter/util/toast.dart';
import 'package:courseflutter/widgets/app_bar.dart';
import 'package:courseflutter/widgets/my_button.dart';
import 'package:courseflutter/widgets/text_field.dart';
import 'package:flutter/material.dart';



///修改用户名
class UpdateUserNamePage extends StatefulWidget {
  @override
  _UpdateUserNamePageState createState() => _UpdateUserNamePageState();
}

class _UpdateUserNamePageState extends State<UpdateUserNamePage> {
  //定义一个controller
  TextEditingController _userNameController = TextEditingController();
  bool _isClick = false;
  
  @override
  void initState() {
    super.initState();
    //监听输入改变  
    _userNameController.addListener(_verify);
  }

  void _verify() {
    String userName = _userNameController.text;
    bool isClick = true;
    if (userName.isEmpty) {
      isClick = false;
    }
    if (isClick != _isClick) {
      setState(() {
        _isClick = isClick;
      });
    }
  }
  
  void _confirm() {
    Toast.show('修改成功！');
    NavigatorUtils.goBack(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: '修改用户名',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Gaps.vGap16,
            Gaps.vGap16,
            MyTextField(
              controller: _userNameController,
              maxLength: 16,
              keyboardType: TextInputType.text,
              hintText: '请输入新用户名',
            ),
            Gaps.vGap8,
            Gaps.vGap15,
            MyButton(
              onPressed: _isClick ? _confirm : null,
              text: '确认',
            )
          ],
        ),
      ),
    );
  }
}
