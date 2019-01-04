import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

class AppColors {
  static const BackgroundColor = 0xffebebeb;
  static const Color AppBarColor = Color(0xFFE5463B); //0xFFE5463B,网易云音乐红
  static const TabIconNormal = 0xff999999;
  static const TabIconActive = 0xff46c11b;
  static const AppBarPopupMenuColor = 0xffffffff;
}

class Constants {
  //阿里巴巴字体图标库
  static const IconFontFamily = "aliIconFont";
}

//EventBus对象
class MyEventBus {
  static EventBus eventBus = new EventBus();
}
