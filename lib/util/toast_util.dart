import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:synchronized/synchronized.dart';

class ToastUtil {
  static ToastUtil _singleton;
  static Fluttertoast _toast;
  static Lock _lock = Lock();

  ToastUtil._();

  _init() {
    _toast = Fluttertoast.instance;
  }

  //需要app打开时先初始化
  static Future<ToastUtil> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          // keep local instance till it is fully initialized.
          // 保持本地实例直到完全初始化。
          var singleton = ToastUtil._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  static showToast(String msg,
      {Toast toastType,
      ToastGravity gravity,
      int timeInSecForIos,
      Color backgroundColor,
      Color textColor}) {
    _toast.showToast(
      msg: msg,
      toastLength: toastType ?? Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.CENTER,
      timeInSecForIos: timeInSecForIos ?? 1,
      backgroundColor: backgroundColor ?? null,
      textColor: textColor ?? null,
    );
  }
}
