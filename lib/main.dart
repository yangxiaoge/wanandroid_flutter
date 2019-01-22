import 'package:flutter/material.dart';
import 'splash_page.dart';
import 'home_screen.dart';
import 'constant/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WanAndroid',
      debugShowCheckedModeBanner: false, // 去除右上角 Debug 标签
      theme: ThemeData.light().copyWith(
        primaryColor: AppColors.AppBarColor,
        cardColor: AppColors.AppBarPopupMenuColor, //影响popupmenu,等其他控件颜色

        accentColor: AppColors.AppBarColor,
        indicatorColor: Colors.white,
      ),
      home: SplashPage(), // 闪屏页
      routes: { // 路由
        HomeScreen.ROUTER_NAME:(context)=>HomeScreen()
      },
    );
  }
}
