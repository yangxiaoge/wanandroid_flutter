import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../constant/component_index.dart';
import '../widget/discover_item.dart';

class DiscoverPage extends StatefulWidget {
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  /// 当前页码
  int _pageIndex = 0;
//刷新
  RefreshController _refreshController;

  /// project 集合
  List projects = new List();
  //数据总长度
  int totalLength = 0;
  //加载中
  bool _isLoading = true;

  Future _disCoverListProject() async {
    if (_pageIndex == 0 && projects.length != 0) {
      // 先滚动到顶部
      Future.delayed(Duration(milliseconds: 600)).then((_) {
        _refreshController.scrollTo(0);
      });
    }

    var url = WanApi.DISCOVER_LIST_PROJECT + "$_pageIndex/json";
    HttpUtil.dioGet2(url, (response) {
      Map<String, dynamic> datas = response['data'];
      List _getDatas = datas['datas'];
      totalLength = datas['total'];
      print("-------最新项目 tab datas = $_getDatas");
      if (this.mounted) {
        setState(() {
          if (_pageIndex == 0) {
            projects.clear();
          }
          projects.addAll(_getDatas);
          if (projects.length >= totalLength) {
            ToastUtil.showToast(IntlUtil.getString(context, Ids.noMore));
          }
          _pageIndex++;
          _isLoading = false;
        });
      }
    }, errorCallback: (errorMsg) {
      _isLoading = false;
      ToastUtil.showToast("获取项目列表出错，$errorMsg");
    });
  }

  //下拉刷新
  void _refresh(bool up) {
    print("---------------------发现页面 = $up");
    _isLoading = false;
    if (up) {
      _pageIndex = 0;
      _disCoverListProject().then((_) {
        Future.delayed(Duration(seconds: 3)).then((_) {
          _refreshController.sendBack(true, RefreshStatus.completed);
        });
      });
    } else {
      _disCoverListProject().then((_) {
        Future.delayed(Duration(seconds: 3)).then((_) {
          print("_refreshController.scrollController.offset = " +
              _refreshController.scrollController.offset.toString());
          _refreshController.sendBack(false, RefreshStatus.idle);
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshController = new RefreshController();
    _disCoverListProject();

    //注册eventbus 双击tab事件监听
    MyEventBus.eventBus.on<NotifyPageRefresh>().listen((event) {
      print("收到eventBus当前tabIndex = ${event.tabIndex}");
      if (event.tabIndex == NavTabItems.DISCOVER.index) {
        _refresh(true);
      }
    });
    //登录注册成功事件监听
    MyEventBus.eventBus.on<LoginRegisterLogoutSuccess>().listen((event) {
      print("收到eventBus登录注册注销成功事件");
      _refresh(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //内容区
        Offstage(
          offstage: _isLoading ? true : false,
          child: SmartRefresher(
            enablePullDown: true, //下拉
            enablePullUp: true, //上拉
            controller: _refreshController,
            onRefresh: _refresh,
            onOffsetChange: null,
            headerBuilder: buildDefaultHeader,
            footerBuilder: buildDefaultFooter,
            footerConfig: RefreshConfig(),
            child: ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                var item = projects[index];
                return DiscoverItem(item);
              },
              // controller: _controller,
            ),
          ),
        ),

        //loading动画
        Offstage(
          offstage: _isLoading ? false : true,
          child: Center(child: CupertinoActivityIndicator()),
        )
      ],
    );
  }
}
