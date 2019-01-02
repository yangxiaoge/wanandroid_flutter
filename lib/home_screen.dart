import 'package:flutter/material.dart';
import 'constant/constants.dart' show AppColors;
import 'util/ToastUtil.dart' show ToastUtil;

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
        setState(() {
          _currentIndex = index;
        });
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
          // 首页显示更多按钮
          _currentIndex == 0
              ? IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    ToastUtil.showToast('更多');
                  },
                )
              : SizedBox(
                  width: 5,
                )
        ],
      ),
      body: _body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
