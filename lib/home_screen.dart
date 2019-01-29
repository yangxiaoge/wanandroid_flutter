import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'constant/constants.dart' show AppColors, MyEventBus;
import 'util/toast_util.dart' show ToastUtil;
import 'eventbus/tab_page_refresh_event.dart';

import 'widget/drawer.dart';
import 'pages/home_page.dart';
import 'pages/discover_page.dart';
import 'pages/meizi_page.dart';
import 'pages/mine_page.dart';
import 'pages/search_page.dart';
import './widget/popup_menu.dart';
import './constant/component_index.dart';

// 主页面（4个tab的父页面）
class HomeScreen extends StatefulWidget {
  static const String ROUTER_NAME = '/HomeScreen';

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// 当前 tab 索引
  int _currentIndex = 0;

  /// tab标题
  var tabTitles;

  /// 底部导航 item 集合
  List<BottomNavigationBarItem> _navigationItemViews;

  /// 上次点击时间
  int lastClickTime = 0;
  Map<int, int> tabClickTime = new Map<int, int>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initBottomItemList(context);
  }

  /// 初始化底部
  _initBottomItemList(BuildContext context) {
    tabTitles = [
      IntlUtil.getString(context, Ids.titleHome),
      IntlUtil.getString(context, Ids.titleDiscover),
      IntlUtil.getString(context, Ids.titleWelfare),
      IntlUtil.getString(context, Ids.titleMine),
    ];
    // 底部导航 item 初始化
    _navigationItemViews = <BottomNavigationBarItem>[
      new BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        title: new Text(tabTitles[0]),
        backgroundColor: AppColors.AppBarColor,
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.widgets),
        title: new Text(tabTitles[1]),
        backgroundColor: AppColors.AppBarColor,
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.face),
        title: new Text(tabTitles[2]),
        backgroundColor: AppColors.AppBarColor,
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        title: new Text(tabTitles[3]),
        backgroundColor: AppColors.AppBarColor,
      ),
    ];
    tabTitles.forEach((title) {
      tabClickTime[tabTitles.indexOf(title)] = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // _initBottomItemList(context);

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
      // fixedColor: Theme.of(context).primaryColor,
      // type: BottomNavigationBarType.fixed,
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
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: CircleAvatar(
            radius: 35.0,
            backgroundImage: ImageUtil.getImageProvider(Constants.Icon_PATH),
            // child: CachedNetworkImage(imageUrl: Constants.AVATAR_URL),
          ),
          alignment: Alignment.centerLeft,
          tooltip: IntlUtil.getString(context, Ids.drawer),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),

        title: Text(tabTitles[_currentIndex]),
        centerTitle: true,
        elevation: 0, // toolbar 去除阴影效果
        actions: <Widget>[
          Offstage(
            offstage: _currentIndex == 3, //Mine界面不显示
            child: IconButton(
              tooltip: IntlUtil.getString(context, Ids.search),
              icon: Icon(Icons.search),
              onPressed: () {
                ToastUtil.showToast(IntlUtil.getString(context, Ids.search));
                NavigatorUtil.pushPage(context,
                    SearchPage("你好啊${IntlUtil.getString(context, Ids.search)}"),
                    pageName: "SearchPage");
              },
            ),
          ),
          // 首页显示更多按钮（Offstage可见性控件，offstage默认为 true，也就是不显示，当为 flase 的时候，会显示该控件）
          Offstage(
            offstage: _currentIndex != 0,
            child: PopUpMenu(),
          ),
          Offstage(
            offstage: _currentIndex == 0,
            child: SizedBox(
              width: 5,
            ),
          ),
        ],
      ),
      drawer: CustDrawer(), //侧滑抽屉
      body: _body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
