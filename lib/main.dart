import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'splash_page.dart';
import 'home_screen.dart';
import 'constant/constants.dart';
import './util/sp_util.dart';

void main() {
  runApp(MyApp());

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    /**
         const SystemUiOverlayStyle({
         /// 底部状态栏和app内主题颜色 (Android O 8.0 及以上)
          this.systemNavigationBarColor,
          /// 底部虚拟按键和内容中间展示的Divider颜色  (Android P 9.0 及以上)
          this.systemNavigationBarDividerColor,
          /// 底部虚拟按键展示的主题  (light/dark)  (Android O 8.0 及以上)
          this.systemNavigationBarIconBrightness,
          /// 状态栏颜色  (Android M 6.0 及以上)
          this.statusBarColor,
          /// 只针对iOS 顶部状态栏颜色配置
          this.statusBarBrightness,
          /// 状态栏主题   (dark/light)  (Android M 6.0 及以上)
          this.statusBarIconBrightness,
        });
       */
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
      title: '玩Android',
      // debugShowCheckedModeBanner: false, // 去除右上角 Debug 标签
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
