
import 'package:courseflutter/res/dimens.dart';
import 'package:courseflutter/res/gaps.dart';
import 'package:courseflutter/res/styles.dart';
import 'package:courseflutter/routers/fluro_navigator.dart';
import 'package:courseflutter/util/toast.dart';
import 'package:courseflutter/widgets/app_bar.dart';
import 'package:courseflutter/widgets/my_button.dart';
import 'package:courseflutter/widgets/text_field.dart';
import 'package:flutter/material.dart';



///修改密码
class UpdatePasswordPage extends StatefulWidget {
  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  //定义一个controller
  TextEditingController _oldPwdController = TextEditingController();
  TextEditingController _newPwdController = TextEditingController();
  bool _isClick = false;
  
  @override
  void initState() {
    super.initState();
    //监听输入改变  
    _oldPwdController.addListener(_verify);
    _newPwdController.addListener(_verify);
  }

  void _verify() {
    String oldPwd = _oldPwdController.text;
    String newPwd = _newPwdController.text;
    bool isClick = true;
    if (oldPwd.isEmpty || oldPwd.length < 6) {
      isClick = false;
    }
    if (newPwd.isEmpty || newPwd.length < 6) {
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
        title: '修改密码',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Gaps.vGap16,
            Gaps.vGap16,
            MyTextField(
              isInputPwd: true,
              controller: _oldPwdController,
              maxLength: 16,
              keyboardType: TextInputType.visiblePassword,
              hintText: '请确认旧密码',
            ),
            Gaps.vGap8,
            MyTextField(
              isInputPwd: true,
              controller: _newPwdController,
              maxLength: 16,
              keyboardType: TextInputType.visiblePassword,
              hintText: '请输入新密码',
            ),
            Gaps.vGap10,
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
