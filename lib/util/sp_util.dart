import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

/**
 * @Author: thl
 * @GitHub: https://github.com/Sky24n
 * @JianShu: https://www.jianshu.com/u/cbf2ad25d33a
 * @Email: 863764940@qq.com
 * @Description: Sp Util.
 * @Date: 2018/9/8
 */
///SharedPreferences 工具类.
class SpUtil {
  static SpUtil _singleton;
  static SharedPreferences _prefs;
  static Lock _lock = Lock();

  //需要app打开时先初始化
  static Future<SpUtil> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          // keep local instance till it is fully initialized.
          // 保持本地实例直到完全初始化。
          var singleton = SpUtil._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  SpUtil._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getString(String key) {
    if (_prefs == null) return null;
    return _prefs.getString(key);
  }

  static Future<bool> putString(String key, String value) {
    if (_prefs == null) return null;
    return _prefs.setString(key, value);
  }

  static bool getBool(String key) {
    if (_prefs == null) return null;
    return _prefs.getBool(key);
  }

  static Future<bool> putBool(String key, bool value) {
    if (_prefs == null) return null;
    return _prefs.setBool(key, value);
  }

  static int getInt(String key) {
    if (_prefs == null) return null;
    return _prefs.getInt(key);
  }

  static Future<bool> putInt(String key, int value) {
    if (_prefs == null) return null;
    return _prefs.setInt(key, value);
  }

  static double getDouble(String key) {
    if (_prefs == null) return null;
    return _prefs.getDouble(key);
  }

  static Future<bool> putDouble(String key, double value) {
    if (_prefs == null) return null;
    return _prefs.setDouble(key, value);
  }

  static List<String> getStringList(String key) {
    return _prefs.getStringList(key);
  }

  static Future<bool> putStringList(String key, List<String> value) {
    if (_prefs == null) return null;
    return _prefs.setStringList(key, value);
  }

  static dynamic getDynamic(String key) {
    if (_prefs == null) return null;
    return _prefs.get(key);
  }

  static Set<String> getKeys() {
    if (_prefs == null) return null;
    return _prefs.getKeys();
  }

  static Future<bool> remove(String key) {
    if (_prefs == null) return null;
    return _prefs.remove(key);
  }

  static Future<bool> clear() {
    if (_prefs == null) return null;
    return _prefs.clear();
  }

  ///Sp is initialized.
  static bool isInitialized() {
    return _prefs != null;
  }
}
