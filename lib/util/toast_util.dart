import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static showToast(String msg,
      {Toast toastType,
      ToastGravity gravity,
      int timeInSecForIos,
      Color backgroundColor,
      Color textColor}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: toastType ?? Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.CENTER,
      timeInSecForIos: timeInSecForIos ?? 1,
      backgroundColor: backgroundColor ?? null,
      textColor: textColor ?? Colors.white,
    );
  }
}
