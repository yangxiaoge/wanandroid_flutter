import 'package:flutter/material.dart';
import '../constant/component_index.dart';

class SettingPage extends StatefulWidget {
  static const String ROUTER_NAME = 'setting';
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Ids.titleAbout),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text("设置页面~\n 多语言 \n 主题 \n"),
        ),
      ),
    );
  }
}
