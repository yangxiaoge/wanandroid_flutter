import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'constant/constants.dart' show AppColors;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WanAndroid',
      debugShowCheckedModeBanner: false, // 去除右上角 Debug 标签
      theme: ThemeData.light().copyWith(
        primaryColor: Color(AppColors.AppBarColor),
        cardColor: Color(AppColors.AppBarColor),
      ),
      home: HomeScreen(),
    );
  }
}
