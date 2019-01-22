import 'package:flutter/material.dart';
import 'dart:async';

import '../eventbus/login_register_success_event.dart'
    show LoginRegisterSuccess;
import '../constant/component_index.dart';

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

    if (errorCode >= 0) {
      print('data = $data');
      ToastUtil.showToast("登录成功");
      //SP配置文件更新登录状态
      AppStatus.setLogin().then((_) {
        //通知页面登录成功
        MyEventBus.eventBus.fire(new LoginRegisterSuccess());
        setState(() {});
      });
    } else {
      ToastUtil.showToast("$errorMsg");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = AppStatus.getBool(Constants.Login);
    print("isLoginaaaa = $isLogin");
    if (isLogin) {
      return Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child:RichText(
              text: new TextSpan(
                text: '已经登录成功了',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                    ),
                children: <TextSpan>[
                  new TextSpan(
                      text: '😎😜😬',
                      style: new TextStyle(color: Colors.blueAccent),
                      ),
                ],
              ),
            ),
            ),
            CachedNetworkImage(
              imageUrl:
                  "http://im6.leaderhero.com/emotion/6572/388108213/c379e0e318.gif",
            )
          ],
        ),
      );
    }
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
              decoration: InputDecoration(labelText: "用户名"),
              controller: _userNameControl,
              // onChanged: (text) {
              //   print("UserName = $text");
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: "密码"),
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
