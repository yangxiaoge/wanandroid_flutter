import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

class AppColors {
  static const BackgroundColor = 0xffebebeb;
  static const AppBarColor = 0xFF008577;
  static const TabIconNormal = 0xff999999;
  static const TabIconActive = 0xff46c11b;
  static const AppBarPopupMenuColor = 0xffffffff;
}

//EventBus对象
class MyEventBus {
  static EventBus eventBus = new EventBus();
}
