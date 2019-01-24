import 'package:flutter/material.dart';
import '../constant/component_index.dart';

import '../pages/drawer_setting_page.dart';
import '../pages/drawer_about_page.dart';
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
  List<PageInfo> _pageInfo = new List();

  @override
  void initState() {
    super.initState();
    //_pageInfo.add(PageInfo(Ids.titleCollection, Icons.collections, CollectionPage()));
    _pageInfo.add(PageInfo(Ids.titleWeather, Icons.cloud, WeatherPage('南京')));
    _pageInfo.add(PageInfo(Ids.titleSetting, Icons.settings, SettingPage()));
    _pageInfo.add(PageInfo(Ids.titleAbout, Icons.info, AboutPage()));
    _pageInfo.add(PageInfo(Ids.titleShare, Icons.share, null));
    _pageInfo.add(PageInfo(Ids.titleSignOut, Icons.power_settings_new, null));
  }

  final Widget userHeader = UserAccountsDrawerHeader(
    accountName: Text('Bruce Yang'),
    accountEmail: Text('yang.jianan0926@gmail.com'),
    currentAccountPicture: CircleAvatar(
      backgroundImage: CachedNetworkImageProvider(Constants.AVATAR_URL),
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
          child: new ListView.builder(
              padding: const EdgeInsets.all(0.0),
              itemCount: _pageInfo.length,
              itemBuilder: (BuildContext context, int index) {
                PageInfo pageInfo = _pageInfo[index];
                return new ListTile(
                  leading: new Icon(pageInfo.iconData),
                  title: new Text(pageInfo.titleId),
                  onTap: () {
                    if (pageInfo.titleId != Ids.titleSignOut &&
                        pageInfo.titleId != Ids.titleShare) {
                      //Scaffold.of(context).openEndDrawer();//可以先关闭抽屉
                      NavigatorUtil.pushPage(context, pageInfo.page,
                          pageName: pageInfo.titleId);
                    } else if (pageInfo.titleId == Ids.titleSignOut) {
                      Scaffold.of(context).openEndDrawer(); //可以先关闭抽屉
                      ToastUtil.showToast(Ids.titleSignOut);
                      //注销清除所有数据
                      AppStatus.clearSP().then((boolean) {
                        //通知页面注销成功
                        MyEventBus.eventBus
                            .fire(new LoginRegisterLogoutSuccess());
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
