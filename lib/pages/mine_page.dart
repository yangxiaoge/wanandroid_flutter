import 'package:flutter/material.dart';
import '../util/toast_util.dart';
import 'dart:async';
import '../net/http_util.dart' show HttpUtil;
import '../net/api_service.dart' show WanApi;
import 'package:shared_preferences/shared_preferences.dart';

class MinePage extends StatefulWidget {
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  TextEditingController _userNameControl = TextEditingController();
  TextEditingController _passwordControl = TextEditingController();

  _login() async {
    String userName = _userNameControl.text;
    String pwd = _passwordControl.text;
    if (userName.isEmpty || pwd.isEmpty) {
      ToastUtil.showToast("账号密码不能为空");
      return;
    }

    Map<String, String> params = Map();
    params['username'] = userName;
    params['password'] = pwd;

    var response = await HttpUtil.dioPost(WanApi.LOGIN, params: params);
    var data = response['data'];
    int errorCode = response['errorCode'];
    String errorMsg = response['errorMsg'];

    if (errorCode != 0) {
      ToastUtil.showToast("$errorMsg");
    } else {
      ToastUtil.showToast("登录成功");
      print('data = $data');
    }

    SharedPreferences sp = await SharedPreferences.getInstance();
    var cookie = sp.get("cookie");
    if (cookie != null) {
      print("cookie = $cookie");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        //GestureDetector 默认只监听不透明的 widget。当你点击空白的地方的时候，会监听不到。所以要将它的 behavior 属性改为 HitTestBehavior.opaque。这样就可以了。
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // https://juejin.im/post/5bc2e8cb5188255c930e03fa
          // 通过GestureDetector捕获点击事件，再通过FocusScope将焦点转移至空焦点——new FocusNode()
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "UserName"),
              controller: _userNameControl,
              // onChanged: (text) {
              //   print("UserName = $text");
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: "PassWord"),
              controller: _passwordControl,
              obscureText: true, //加密
              // onChanged: (text) {
              //   print("PassWord = $text");
              // },
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: RaisedButton(
                child: Text(
                  "登录",
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  _login();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
