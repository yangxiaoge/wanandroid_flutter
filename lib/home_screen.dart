import 'package:flutter/material.dart';
import 'constant/constants.dart' show AppColors, MyEventBus;
import 'util/ToastUtil.dart' show ToastUtil;
import 'eventbus/tab_page_refresh_event.dart';

import 'pages/HomePage.dart';
import 'pages/DiscoverPage.dart';
import 'pages/MeiZiPage.dart';
import 'pages/MinePage.dart';
import 'pages/SearchPage.dart';

// 主页面（4个tab的父页面）
class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 当前 tab 索引
  int _currentIndex = 0;
  // tab标题
  var tabTitles = ["首页", "发现", "福利", "我的"];
  // 底部导航 item 集合
  List<BottomNavigationBarItem> _navigationItemViews;
  //上次点击时间
  int lastClickTime = 0;
  Map<int, int> tabClickTime = new Map<int, int>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 底部导航 item 初始化
    _navigationItemViews = <BottomNavigationBarItem>[
      new BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        title: new Text(tabTitles[0]),
        backgroundColor: Color(AppColors.AppBarColor),
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.widgets),
        title: new Text(tabTitles[1]),
        backgroundColor: Color(AppColors.AppBarColor),
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.face),
        title: new Text(tabTitles[2]),
        backgroundColor: Color(AppColors.AppBarColor),
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        title: new Text(tabTitles[3]),
        backgroundColor: Color(AppColors.AppBarColor),
      ),
    ];

    tabTitles.forEach((title) {
      tabClickTime[tabTitles.indexOf(title)] = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _body = IndexedStack(
      index: _currentIndex,
      children: <Widget>[
        HomePage(),
        DiscoverPage(),
        MeiZiPage(),
        MinePage(),
      ],
    );

    final bottomNavigationBar = BottomNavigationBar(
      currentIndex: _currentIndex,
      items: _navigationItemViews,
      onTap: (index) {
        print("_currentIndex = $_currentIndex, index = $index");
        int currentTime = DateTime.now().microsecondsSinceEpoch;
        if (index == _currentIndex) {
          int indexTabLastClickTime = tabClickTime[index];
          print("currentTime - indexTabLastClickTime = " +
              (currentTime - indexTabLastClickTime).toString());
          if (currentTime - indexTabLastClickTime < 1000000) {
            //1秒内
            print("通知页面$index刷新");

            NotifyPageRefresh notify = new NotifyPageRefresh(index);
            MyEventBus.eventBus.fire(notify);
          }
          print("tabClickTime[index]1 = ${tabClickTime[index]}");
          tabClickTime[index] = currentTime;
          print("tabClickTime[index]2 = ${tabClickTime[index]}");
        } else {
          setState(() {
            _currentIndex = index;
          });
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(tabTitles[_currentIndex]),
        elevation: 0, // toolbar 去除阴影效果
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              ToastUtil.showToast('搜索');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage("你好啊搜索页"),
                  )).then((result) {
                print('返回数据$result');
              });
            },
          ),
          // 首页显示更多按钮（Offstage可见性控件，offstage默认为 true，也就是不显示，当为 flase 的时候，会显示该控件）
          Offstage(
            offstage: _currentIndex != 0,
            child: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                ToastUtil.showToast('更多');
              },
            ),
          ),
          Offstage(
            offstage: _currentIndex == 0,
            child: SizedBox(
              width: 5,
            ),
          )
        ],
      ),
      body: _body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}