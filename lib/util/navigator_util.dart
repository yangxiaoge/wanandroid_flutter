import 'package:flutter/cupertino.dart';

import '../constant/component_index.dart';
import '../pages/item_detail_page.dart';

//导航工具类
class NavigatorUtil {
  static void pushPage(BuildContext context, Widget page, {String pageName}) {
    if (context == null || page == null /**||ObjectUtil.isEmpty(pageName)*/)
      return;
    Navigator.push(
        context, new CupertinoPageRoute<void>(builder: (ctx) => page));
  }

  static void pushPageReplacementNamed(BuildContext context, String pageName) {
    if (context == null || ObjectUtil.isEmpty(pageName)) return;
    Navigator.pushReplacementNamed(context, pageName);
  }

  static void pushWeb(BuildContext context,
      {@required String title,
      @required String url,
      String titleId,
      bool isCollected: false}) {
    if (context == null || ObjectUtil.isEmpty(url)) return;
    if (url.endsWith(".apk")) {
      launchInBrowser(url, title: title);
    } else {
      Navigator.push(
          context,
          // WebviewScaffold 侧滑退出有bug，因此换成MaterialPageRoute
          new MaterialPageRoute<void>(
              builder: (ctx) => ItemDetailPage(
                  title: title,
                  titleId: titleId ?? title,
                  url: url,
                  isCollected: isCollected)));
    }
  }

  static Future<Null> launchInBrowser(String url, {String title}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
