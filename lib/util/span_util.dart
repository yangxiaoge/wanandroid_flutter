import 'package:flutter/material.dart';

class SpanUtil {
  static TextSpan getTextSpan(BuildContext context, String text, String key) {
    if (text == null || key == null) {
      return null;
    }

    if (text == null || key == null) {
      return null;
    }

    String splitString1 = "<em class='highlight'>";
    String splitString2 = "</em>";

    String textOrigin =
        text.replaceAll(splitString1, '').replaceAll(splitString2, '');

    TextSpan textSpan = new TextSpan(
        text: key, style: new TextStyle(color: Theme.of(context).primaryColor));

    List<String> split = textOrigin.split(key);

    List<TextSpan> list = new List<TextSpan>();
    //  "<em class='highlight'>Android</em> 开发高手课 文章更新学习笔记"
    for (int i = 0; i < split.length; i++) {
      list.add(new TextSpan(text: split[i]));
      list.add(textSpan);
    }

    list.removeAt(list.length - 1);

    return new TextSpan(children: list);
  }

  static String getTextSpanStr(String text, String key) {
    if (text == null || key == null) {
      return null;
    }

    if (text == null || key == null) {
      return null;
    }

    String splitString1 = "<em class='highlight'>";
    String splitString2 = "</em>";

    String textOrigin =
        text.replaceAll(splitString1, '').replaceAll(splitString2, '');
    List<String> split = textOrigin.split(key);

    List<String> list = new List();
    for (int i = 0; i < split.length; i++) {
      list.add(split[i]);
      list.add(key);
    }

    list.removeAt(list.length - 1);
    StringBuffer sb = StringBuffer();
    for (String s in list) {
      sb.write(s);
    }
    return sb.toString();
  }

  /// html 字符实体转义
  static String htmlCharacterEntityEscape(String title) {
    //可以自行添加更多的字符
    return title
        .replaceAll("&ldquo;", "“")
        .replaceAll("&rdquo;", "”")
        .replaceAll("&nbsp;", " ")
        .replaceAll("&#38;", "'")
        .replaceAll("&#39;", "&")
        .replaceAll("&rsquo;", "’")
        .replaceAll("&mdash;", "—")
        .replaceAll("&ndash;", "–");
  }
}
