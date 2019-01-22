import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";

import './item_detail_page.dart';
import '../constant/constants.dart';
import '../eventbus/login_register_success_event.dart';
import '../eventbus/tab_page_refresh_event.dart';
import '../net/api_service.dart' show WanApi;
import '../net/http_util.dart' show HttpUtil;
import '../util/toast_util.dart' show ToastUtil;
import '../widget/indicator_factory.dart';
import '../util/navigator_util.dart';
// import '../constant/component_index.dart';

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

  //获取文章列表
  Future _getHomeArticleList() async {
    if (_pageIndex == 0 && listData.length != 0) {
      // 先滚动到顶部
      Future.delayed(Duration(milliseconds: 600)).then((_) {
        _refreshController.scrollTo(0);
      });
    }

    var url = WanApi.Home_Article_List + "$_pageIndex/json";
    HttpUtil.getHttp(url, (data) {
      if (data != null) {
        Map<String, dynamic> datas = data;
        var _getDatas = datas['datas'];
        totalLength = datas['total'];

        //print("首页列表----->: " + _getDatas.toString());
        //ToastUtil.showToast("获取数据成功");

        if (this.mounted) {
          setState(() {
            if (_pageIndex == 0) {
              listData.clear();
            }
            listData.addAll(_getDatas);
            if (listData.length >= totalLength) {
              ToastUtil.showToast("到底啦~");
            }
            _pageIndex++;
            _isLoading = false;
          });
        }
      }
    }, errorCallback: (errorMsg) {
      _isLoading = false;
      ToastUtil.showToast("获取文章列表出错，$errorMsg");
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
      if (event.tabIndex == 0) {
        _refresh(true);
      }
    });
    //登录注册成功事件监听
    MyEventBus.eventBus.on<LoginRegisterSuccess>().listen((event) {
      print("收到eventBus登录注册成功事件");
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

  _go2ItemDetail(String url, String title) {
    NavigatorUtil.pushPage(context, ItemDetailPage(url: url, title: title),
        pageName: "ItemDetailPage");
  }

  _likeClick(var itemData) async {
    AppStatus.isLogin().then((login) async {
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
          ToastUtil.showToast(!itemData['collect'] ? "收藏成功" : "取消收藏");
          setState(() {
            itemData['collect'] = !itemData['collect'];
          });
        } else {
          ToastUtil.showToast("$errorMsg");
        }
      } else {
        ToastUtil.showToast("未登录");
      }
    });
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

        //   Swiper(
        //   indicatorAlignment: AlignmentDirectional.topEnd,
        //   circular: true,
        //   interval: const Duration(seconds: 5),
        //   // indicator: NumberSwiperIndicator(),
        //   children: banners.map((banner) {
        //     return new InkWell(
        //       onTap: () {
        //         LogUtil.e("Banner: " + banner.toString());
        //         NavigatorUtil.pushWeb(context,
        //             title: banner['title'], url: banner['url']);
        //       },
        //       child: new CachedNetworkImage(
        //         fit: BoxFit.fill,
        //         imageUrl: banner['url'],
        //         placeholder: CupertinoActivityIndicator(),
        //         errorWidget: new Icon(Icons.error),
        //       ),
        //     );
        //   }).toList(),
        // ),
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
              //ToastUtil.showToast('别摸我~');
              _likeClick(itemData);
            },
          )
          // InkWell(
          //   child: Icon(
          //     isCollected ? Icons.favorite : Icons.favorite_border,
          //     color: isCollected ? Colors.red : null,
          //   ),
          //   onTap: () {},
          // )
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
            _go2ItemDetail(itemData['link'], itemData['title']);
          },
        ),
        color: Colors.white,
        elevation: 3,
      );
    }
  }
}
