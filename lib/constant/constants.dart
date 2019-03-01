import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/sp_util.dart';
import 'language_model.dart';
import 'weatherdata.dart';

///首页，发现，福利，我的
enum NavTabItems { HOME, DISCOVER, WELFARE, MINE }

class AppColors {
  /// 网易红，默认主题色
  static const Color appColor = Color(0xFFE5463B); //0xFFE5463B,网易云音乐红
  /// 鸢尾蓝
  static const Color PRIMARY_YWL_COLOR = const Color(0xFFF158bb8);

  /// 孔雀绿
  static const Color PRIMARY_KQL_COLOR = const Color(0xFFF229453);

  /// 柠檬黄
  static const Color PRIMARY_NMH_COLOR = const Color(0xFFFfcd337);

  /// 藤萝紫
  static const Color PRIMARY_TLZ_COLOR = const Color(0xFFF8076a3);

  /// 暮云灰
  static const Color PRIMARY_MYH_COLOR = const Color(0xFFF4f383e);

  /// 虾壳青
  static const Color PRIMARY_XKQ_COLOR = const Color(0xFFF869d9d);

  /// 牡丹粉
  static const Color PRIMARY_MDF_COLOR = const Color(0xFFFeea2a4);

  /// 筍皮棕
  static const Color PRIMARY_XPZ_COLOR = const Color(0xFFF732e12);

  static const Color backgroundColor = Color(0xffebebeb);
  static const Color tabIconNormal = Color(0xff999999);
  static const Color dividerColor = Color(0xffeeeeee);
  static const Color tabIconActive = Color(0xff46c11b);
  static const Color popMenuColor = Color(0xffffffff);

  /// 主题色Map
  static const Map<String, Color> themeMap = {
    "网易红": appColor,
    "鸢尾蓝": PRIMARY_YWL_COLOR,
    "孔雀绿": PRIMARY_KQL_COLOR,
    "柠檬黄": PRIMARY_NMH_COLOR,
    "藤萝紫": PRIMARY_TLZ_COLOR,
    "暮云灰": PRIMARY_MYH_COLOR,
    "虾壳青": PRIMARY_XKQ_COLOR,
    "牡丹粉": PRIMARY_MDF_COLOR,
    "筍皮棕": PRIMARY_XPZ_COLOR,
  };
}

class Dimens {
  static const double font_sp10 = 10;
  static const double font_sp12 = 12;
  static const double font_sp14 = 14;
  static const double font_sp16 = 16;
  static const double font_sp18 = 18;

  static const double gap_dp5 = 5;
  static const double gap_dp10 = 10;
  static const double gap_dp12 = 12;
  static const double gap_dp15 = 15;
  static const double gap_dp16 = 16;
}

class Constants {
  static const String accountName = "Bruce Yang";
  static const String accountEmail = "yang.jianan0926@gmail.com";

  // 应用名称
  static const appName = "Mumuxi";

  //应用icon路径
  static const iconPath = "android/app/src/main/res/mipmap-xhdpi/zz.png";

  //阿里巴巴字体图标库
  static const iconFontFamily = "aliIconFont";

  //WorkSansMedium字体
  static const workSansMedium = "WorkSansMedium";

  // static const AVATAR_URL = "https://avatars3.githubusercontent.com/u/12471093?v=4";
  //天气网络背景图片
  static const weatherBackground =
      "https://github.com/yangxiaoge/PersonResources/blob/master/app_res/pic1.jpg?raw=true";

  //天气默认背景
  static const weatherBgAssetPath = "assets/images/weather_bg.jpg";

  static const githubFlutterTrending = "https://github.com/trending/dart";

  //SharedPreferences对应Key
  static const String loginSp = "login";
  static const String cookieSp = "cookie";
  static const String languageSp = "language";
  static const String themeColorSp = "theme";
  static const String weatherCacheSp = "weatherCache";

  //通知 main.dart 中_initListener 的 bloc 刷新全局状态的标识
  static const int notifySysLanguageUpdate = 1;
  static const int notifySysThemeUpdate = 2;

  // 闪屏页的上下文
  static BuildContext mContext;
}

//EventBus对象
class MyEventBus {
  static EventBus eventBus = new EventBus();
}

///SP工具类
class AppStatus {
  //----------------------异步SP-------------------------------//
  //登录状态
  static Future<bool> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool b = sp.getBool(Constants.loginSp);
    return true == b;
  }

  static Future setLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(Constants.loginSp, true);
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

  //----------------------同步SP-------------------------------//
  // T 用于区分存储类型
  // todo ( 目前有问题， T 无法区分类型！！！！)
  static void putObject<T>(String key, Object value) {
    switch (T) {
      case int:
        SpUtil.putInt(key, value);
        break;
      case double:
        SpUtil.putDouble(key, value);
        break;
      case bool:
        SpUtil.putBool(key, value);
        break;
      case String:
        SpUtil.putString(key, value);
        break;
      case List:
        SpUtil.putStringList(key, value);
        break;
      default:
        //对象转json存储
        SpUtil.putString(key, value == null ? "" : json.encode(value));
        break;
    }
  }

  ///获取当前当前语言sp
  static LanguageModel getLanguageModel() {
    String _saveLanguage = SpUtil.getString(Constants.languageSp);
    if (ObjectUtil.isNotEmpty(_saveLanguage)) {
      Map userMap = json.decode(_saveLanguage);
      return LanguageModel.fromJson(userMap);
    }
    return null;
  }

  ///获取当前主题
  static String getThemeColor() {
    String _colorKey = getString(Constants.themeColorSp);
    if (_colorKey == null || _colorKey.isEmpty) {
      //默认颜色
      _colorKey = "网易红";
    }
    return _colorKey;
  }

  static WeatherData getLastCacheWeather() {
    String _lastWeather = getString(Constants.weatherCacheSp);
    if (ObjectUtil.isNotEmpty(_lastWeather)) {
      return WeatherData.fromLacalJson(json.decode(_lastWeather));
    }
    return null;
  }

  static Future putString(String key,String value) {
    return SpUtil.putString(key,value);
  }

  static String getString(String key) {
    return SpUtil.getString(key);
  }

  static bool getBool(String key) {
    //不存在会返回null，因此需要与true比较
    return true == SpUtil.getBool(key);
  }

  ///清除所有SP
  static Future<bool> clearSP() {
    return SpUtil.clear();
  }
}
