import 'package:flutter/material.dart';

import '../constant/component_index.dart';
import '../pages/drawer_about_page.dart';
import '../pages/drawer_setting_page.dart';
import '../pages/drawer_weather_page.dart';

//Drawer 抽屉
class CustDrawer extends StatefulWidget {
  _CustDrawerState createState() => _CustDrawerState();
}

//item对象
class PageInfo {
  PageInfo(this.titleId, this.iconData, this.page, [this.withScaffold = true]);

  String titleId;
  IconData iconData;
  Widget page;
  bool withScaffold;
}

class _CustDrawerState extends State<CustDrawer> {
  List<PageInfo> _pageInfo = List();

  @override
  void initState() {
    super.initState();
    _pageInfo.add(PageInfo(Ids.titleGithubTrending, Icons.trending_up, null));
    _pageInfo.add(PageInfo(Ids.titleWeather, Icons.cloud, WeatherPage('南京')));
    _pageInfo.add(PageInfo(Ids.titleSetting, Icons.settings, SettingPage()));
    _pageInfo.add(PageInfo(Ids.titleAbout, Icons.info, AboutPage()));
    _pageInfo.add(PageInfo(Ids.titleShare, Icons.share, null));
    _pageInfo.add(PageInfo(Ids.titleSignOut, Icons.power_settings_new, null));
  }

  final Widget userHeader = UserAccountsDrawerHeader(
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover, //居中剪裁
        // image: ImageUtil.getImageProvider(Constants.WEATHER_bg),
        image: ImageUtil.getImageProvider(Constants.weatherBgAssetPath),
      ),
    ),
    accountName: Text(Constants.accountName),
    accountEmail: Text(Constants.accountEmail),
    currentAccountPicture: CircleAvatar(
      backgroundImage: ImageUtil.getImageProvider(Constants.iconPath),
      radius: 35.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        userHeader,
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: _pageInfo.length,
              itemBuilder: (BuildContext context, int index) {
                PageInfo pageInfo = _pageInfo[index];
                return ListTile(
                  leading: Icon(pageInfo.iconData),
                  title: Text(IntlUtil.getString(context, pageInfo.titleId)),
                  onTap: () {
                    print("----titleId = " + pageInfo.titleId);
                    Scaffold.of(context).openEndDrawer(); //可以先关闭抽屉
                    if (pageInfo.titleId == Ids.titleWeather ||
                        pageInfo.titleId == Ids.titleSetting ||
                        pageInfo.titleId == Ids.titleAbout) {
                      NavigatorUtil.pushPage(context, pageInfo.page,
                          pageName: pageInfo.titleId);
                    } else if (pageInfo.titleId == Ids.titleGithubTrending) {
                      NavigatorUtil.pushWeb(context,
                          title: IntlUtil.getString(
                              context, Ids.titleGithubTrending),
                          url: Constants.githubFlutterTrending);
                    } else if (pageInfo.titleId == Ids.titleSignOut) {
                      ToastUtil.showToast(
                          IntlUtil.getString(context, Ids.titleSignOut));
                      //注销清除所有数据
                      AppStatus.clearSP().then((boolean) {
                        //通知页面注销成功
                        MyEventBus.eventBus.fire(LoginRegisterLogoutSuccess());
                      });
                    } else if (pageInfo.titleId == Ids.titleShare) {
                      Share.share(Ids.shareTxt);
                    }
                  },
                );
              }),
          flex: 1,
        ),
      ],
    ));
  }
}
