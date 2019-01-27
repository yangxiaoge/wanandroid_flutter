import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'splash_page.dart';
import 'home_screen.dart';
import 'constant/constants.dart';
import './util/sp_util.dart';
// import './util/toast_util.dart';

void main() {
  runApp(MyApp());

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  ///初始化SPUtil
  void _initAsync() async {
    await SpUtil.getInstance().then((_) {
      print("SP初始化完成");
    });
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APPNAME,
      debugShowCheckedModeBanner: false, // 去除右上角 Debug 标签
      theme: ThemeData.light().copyWith(
          accentColor: AppColors.AppBarColor,
          primaryColor: AppColors.AppBarColor,
          cardColor: AppColors.AppBarPopupMenuColor, //影响popupmenu,等其他控件颜色
          dividerColor: AppColors.DividerColor,
          indicatorColor: Colors.white,
          platform: TargetPlatform.android),
      home: SplashPage(), // 闪屏页
      routes: {
        // 路由
        HomeScreen.ROUTER_NAME: (context) => HomeScreen()
      },
    );
  }
}
