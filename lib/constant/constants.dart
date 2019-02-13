import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../util/sp_util.dart';
import 'package:common_utils/common_utils.dart';
import 'language_model.dart';
import 'weatherdata.dart';

///首页，发现，福利，我的
enum NavTabItems { HOME, DISCOVER, WELFARE, MINE }

class AppColors {
  static const Color BackgroundColor = Color(0xffebebeb);
  static const Color AppBarColor = Color(0xFFE5463B); //0xFFE5463B,网易云音乐红
  static const Color TabIconNormal = Color(0xff999999);
  static const Color DividerColor = Color(0xffeeeeee);
  static const Color TabIconActive = Color(0xff46c11b);
  static const Color AppBarPopupMenuColor = Color(0xffffffff);
  static const Color DIVIDER = Color(0xffe5e5e5);
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

class TextStyles {
  static TextStyle listTitle = TextStyle(
    fontSize: Dimens.font_sp16,
    color: AppColors.AppBarColor,
    fontWeight: FontWeight.bold,
  );
  static TextStyle listContent = TextStyle(
    fontSize: Dimens.font_sp14,
    // color: ColorT.text_normal,
  );
  static TextStyle listExtra = TextStyle(
    fontSize: Dimens.font_sp12,
    // color: ColorT.text_gray,
  );
}

class Constants {
  static const String accountName = "Bruce Yang";
  static const String accountEmail = "yang.jianan0926@gmail.com";

  // 应用名称
  static const APPNAME = "Mumuxi";
  //应用icon路径
  static const Icon_PATH = "android/app/src/main/res/mipmap-xhdpi/zz.png";
  //阿里巴巴字体图标库
  static const IconFontFamily = "aliIconFont";
  //WorkSansMedium字体
  static const WorkSansMedium = "WorkSansMedium";
  // static const AVATAR_URL = "https://avatars3.githubusercontent.com/u/12471093?v=4";
  //天气网络背景图片
  static const WEATHER_bg =
      "https://github.com/yangxiaoge/PersonResources/blob/master/app_res/pic1.jpg?raw=true";
  //天气默认背景
  static const WEATHER_bg_assetPath = "assets/images/weather_bg.jpg";

  //SharedPreferences对应Key
  static const String Login = "login";
  static const String Cookie = "cookie";
  static const String Language = "language";
  static const String WeatherCache = "weatherCache";

  //通知 main.dart 中_initListener 的 bloc 刷新全局状态的标识
  static const int NOTIFY_SYS_UPDATE = 1;
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
    bool b = sp.getBool(Constants.Login);
    return true == b;
  }

  static Future setLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(Constants.Login, true);
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
    String _saveLanguage = SpUtil.getString(Constants.Language);
    if (ObjectUtil.isNotEmpty(_saveLanguage)) {
      Map userMap = json.decode(_saveLanguage);
      return LanguageModel.fromJson(userMap);
    }
    return null;
  }

  static WeatherData getLastCacheWeather() {
    String _lastWeather = SpUtil.getString(Constants.WeatherCache);
    if (ObjectUtil.isNotEmpty(_lastWeather)) {
      return WeatherData.fromLacalJson(json.decode(_lastWeather));
    }
    return null;
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
