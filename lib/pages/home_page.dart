import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constant/component_index.dart';

//首页
class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 当前页码
  int _pageIndex = 0;
  // 文章列表集合
  List listData = new List();
  //数据总长度
  int totalLength = 0;
  //刷新
  RefreshController _refreshController;
  //加载中
  bool _isLoading = true;
  //广告集合
  List banners = new List();

  // 获取文章列表
  Future _getHomeArticleList() async {
    if (_pageIndex == 0 && listData.length != 0) {
      // 先滚动到顶部
      Future.delayed(Duration(milliseconds: 600)).then((_) {
        _refreshController.scrollTo(0);
      });
    }

    var url = WanApi.Home_Article_List + "$_pageIndex/json";
    //todo dio请求有缓存问题，注销后cookie似乎还有效
    HttpUtil.getHttp(url, (data) {
      if (data != null) {
        Map<String, dynamic> datas = data;
        var _getDatas = datas['datas'];
        totalLength = datas['total'];

        //print("首页列表 ----->:" + _getDatas.toString());
        //ToastUtil.showToast("获取数据成功");

        if (this.mounted) {
          setState(() {
            if (_pageIndex == 0) {
              listData.clear();
            }
            listData.addAll(_getDatas);
            if (listData.length >= totalLength) {
              ToastUtil.showToast(IntlUtil.getString(context, Ids.noMore));
            }
            _pageIndex++;
            _isLoading = false;
          });
        }
      }
    }, errorCallback: (errorMsg) {
      _isLoading = false;
      ToastUtil.showToast(" 获取文章列表出错，$errorMsg");
    });
  }

  //获取广告
  _getBanners() async {
    var url = WanApi.Banner;

    HttpUtil.dioGet2(url, (response) {
      var data = response['data'];
      if (this.mounted) {
        setState(() {
          banners.clear();
          banners.addAll(data);
          //print("广告----->: " + banners.toString());
        });
      }
    });
  }

  //下拉刷新
  void _refresh(bool up) {
    print("---------------------上啊啊啊up = $up");
    _isLoading = false;
    if (up) {
      _pageIndex = 0;
      _getHomeArticleList().then((_) {
        Future.delayed(Duration(seconds: 3)).then((_) {
          _refreshController.sendBack(true, RefreshStatus.completed);
        });
      });
    } else {
      _getHomeArticleList().then((_) {
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

    _getBanners();
    _getHomeArticleList();

    //注册eventbus 双击tab事件监听
    MyEventBus.eventBus.on<NotifyPageRefresh>().listen((event) {
      print("收到eventBus当前tabIndex = ${event.tabIndex}");
      if (event.tabIndex == NavTabItems.HOME.index) {
        _refresh(true);
        //双击时也刷新广告
        _getBanners();
      }
    });
    //登录注册成功事件监听
    MyEventBus.eventBus.on<LoginRegisterLogoutSuccess>().listen((event) {
      print("收到eventBus登录注册注销成功事件");
      _refresh(true);
    });
  }

  @override
  void dispose() {
    print("---------------------销毁");
    super.dispose();
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
              itemCount: listData.length + 1, //+1是广告位
              itemBuilder: (context, index) => buildListItem(index),
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

  _go2ItemDetail(String url, String title,
      {int titleId, bool isCollected: false}) {
    NavigatorUtil.pushWeb(context,
        title: title, url: url, titleId: titleId, isCollected: isCollected);
  }

  _likeClick(var itemData) async {
    bool login = AppStatus.getBool(Constants.Login);
    print("--------------login = $login");
    if (login) {
      //已登录
      var url;
      if (itemData['collect']) {
        url = WanApi.UNCOLLECT_ORIGINID;
      } else {
        url = WanApi.COLLECT;
      }
      url += '${itemData['id']}/json';
      //print("url = $url");
      var response = await HttpUtil.dioPost(url);
      print("response = ${response.toString()}");
      var data = response['data'];
      int errorCode = response['errorCode'];
      String errorMsg = response['errorMsg'];
      print("data = $data,errorCode = $errorCode,errorMsg = $errorMsg");
      if (errorCode >= 0) {
        ToastUtil.showToast(!itemData['collect']
            ? IntlUtil.getString(context, Ids.collectSuccess)
            : IntlUtil.getString(context, Ids.cancelCollect));
        setState(() {
          itemData['collect'] = !itemData['collect'];
        });
      } else {
        ToastUtil.showToast("$errorMsg");
      }
    } else {
      ToastUtil.showToast(IntlUtil.getString(context, Ids.notLogin));
    }
  }

  Widget buildListItem(int index) {
    // print("index = $index");
    if (index == 0) {
      //广告无数据时，显示loading
      if (banners.length == 0) {
        return Container(
          height: 180,
          child: CupertinoActivityIndicator(),
        );
      }
      return Container(
        child: Swiper(
          itemBuilder: (context, i) {
            //print("banners[$i] = ${banners[i]}, imagePath = ${banners[i]['imagePath']}");
            return CachedNetworkImage(
              imageUrl: banners[i]['imagePath'],
              fit: BoxFit.fill,
            );
          },
          itemCount: banners.length,
          loop: true,
          autoplay: true,
          autoplayDelay: 3000,
          duration: 600,
          // control: new SwiperControl(),
          pagination: new SwiperCustomPagination(
              builder: (BuildContext context, SwiperPluginConfig config) {
            int index = config.activeIndex;
            return Container(
              child: Text(
                banners[index]['title'],
                style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontStyle: FontStyle.italic),
              ),
              margin: EdgeInsets.fromLTRB(10, 155, 0, 0),
            );
          }),
          onTap: (i) {
            print("banners[$i]['url'] = ${banners[i]['url']}");
            _go2ItemDetail(banners[i]['url'], banners[i]['title']);
          },
        ),
        height: 180,
      );
    } else {
      index -= 1; //下标需要减去广告位
      var itemData = listData[index];
      bool isCollected = itemData['collect'];
      //print("喜欢isCollected = $isCollected");
      Row line1 = new Row(
        children: <Widget>[
          Text('作者：'),
          Expanded(
            child: Text(
              itemData['author'],
              style: new TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          Text(itemData['niceDate'])
        ],
      );

      Align line2 = Align(
        alignment: Alignment.centerLeft,
        child: Text(
          itemData['title'],
        ),
      );

      Row line3 = new Row(
        children: <Widget>[
          Expanded(
            child: Text(
              itemData['chapterName'],
              style: new TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          GestureDetector(
            child: Icon(
              isCollected ? Icons.favorite : Icons.favorite_border,
              color: isCollected ? Colors.red : null,
            ),
            onTap: () {
              _likeClick(itemData);
            },
          )
        ],
      );

      return Card(
        child: InkWell(
          child: Column(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.all(10.0),
                child: line1,
              ),
              new Padding(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: line2,
              ),
              new Padding(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
                child: line3,
              ),
            ],
          ),
          onTap: () {
            _go2ItemDetail(itemData['link'], itemData['title'],
                titleId: itemData['id'], isCollected: itemData['collect']);
          },
        ),
        color: Colors.white,
        elevation: 3,
      );
    }
  }
}
