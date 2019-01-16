import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import '../util/toast_util.dart';

class DiscoverPage extends StatefulWidget {
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  Socket socket;
  _socketConnectServer() async {
    await Socket.connect('192.168.131.168', 2010).then((sock) {
      socket = sock;
      socket.transform(utf8.decoder).listen((onData) {
        print("接收到来自Server的数据：" + onData);
      }, onError: (error, StackTrace trace) {
        print("onError = $error");
      }, onDone: () {
        print("onDone");
        socket.destroy();
      }, cancelOnError: false);

      print("开始定时给服务端发消息---");
      Timer.periodic(Duration(milliseconds: 1000),(_){
        socket.write("你好服务器 ${DateTime.now()} \n");
      });
    }).catchError((e) {
      print("Unable to connect: $e");
      ToastUtil.showToast("socket连接失败");
    });
  }

  @override
  void initState() {
    super.initState();
    //连接socket服务器
    _socketConnectServer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("发现"),
    );
  }
}
