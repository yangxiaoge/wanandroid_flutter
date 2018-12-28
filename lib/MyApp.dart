import 'package:flutter/material.dart';
import 'constant/constants.dart' show AppColors;

import 'pages/HomePage.dart';
import 'pages/DiscoverPage.dart';
import 'pages/MeiZiPage.dart';
import 'pages/MinePage.dart';

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

    return MaterialApp(
      title: 'WanAndroid',
      debugShowCheckedModeBanner: false, // 去除右上角 Debug 标签
      theme: ThemeData.light().copyWith(
        primaryColor: Color(AppColors.AppBarColor),
        cardColor: Color(AppColors.AppBarColor),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(tabTitles[_currentIndex]),
          elevation: 0, // 阴影效果
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            SizedBox(
              width: 8,
            )
          ],
        ),
        body: _body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
