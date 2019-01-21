import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  //WorkSansMedium字体
  static const WorkSansMedium = "WorkSansMedium";

  //SharedPreferences对应Key
  static const String Login = "login";
  static const String Cookie = "cookie";
}

//EventBus对象
class MyEventBus {
  static EventBus eventBus = new EventBus();
}

//都是Future的异步执行
class AppStatus {
  //登录状态
  static Future<bool> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool b = sp.getBool(Constants.Login);
    return true == b;
  }

  static Future setLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(Constants.Login, true);
  }

  //清楚所有SP
  static Future clearSP() async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.clear();
  }

  static Future saveSP(String key, value) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.setString(key, value);
  }

  static Future saveList(String key, List<String> value) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.setStringList(key, value);
  }

  static Future get(String key) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    return spf.get(key);
  }

  static remove(String key) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.remove(key);
  }
}
