import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../net/api_service.dart' show WanApi;
import '../net/http_util.dart' show HttpUtil;
import '../util/toast_util.dart' show ToastUtil;
import '../constant/constants.dart';
import './item_detail_page.dart';
import '../eventbus/tab_page_refresh_event.dart';
import '../eventbus/login_register_success_event.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
  //上拉监听
  ScrollController _controller = new ScrollController();
  //广告集合
  List banners = new List();

  //获取文章列表
  _getHomeArticleList() async {
    var url = WanApi.Home_Article_List + "$_pageIndex/json";
    HttpUtil.getHttp(url, (data) {
      if (data != null) {
        Map<String, dynamic> datas = data;
        var _getDatas = datas['datas'];
        totalLength = datas['total'];

        //print("首页列表----->: " + _getDatas.toString());
        //ToastUtil.showToast("获取数据成功");

        setState(() {
          if (_pageIndex == 0) {
            listData.clear();
          }
          listData.addAll(_getDatas);
          if (listData.length >= totalLength) {
            ToastUtil.showToast("到底啦~");
          }
          _pageIndex++;
        });
      }
    }, errorCallback: (errorMsg) {
      ToastUtil.showToast("获取文章列表出错，$errorMsg");
    });
  }

  //获取广告
  _getBanners() async {
    var url = WanApi.Banner;

    // var response = await HttpUtil.dioGet(url);
    // var data = response['data'];
    // setState(() {
    //   banners.clear();
    //   banners.addAll(data);
    //   print("广告----->: " + banners.toString());
    // });

    HttpUtil.dioGet2(url, (response) {
      var data = response['data'];
      setState(() {
        banners.clear();
        banners.addAll(data);
        //print("广告----->: " + banners.toString());
      });
    });
  }

  //下拉刷新
  Future _refresh() async {
    _pageIndex = 0;
    _getHomeArticleList();
    _getBanners();
  }

  //上拉加载更多
  //https://juejin.im/post/5b6ac41651882519861c3b79
  _HomePageState() {
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels && listData.length < totalLength) {
        //上拉刷新做处理
        print('load more ...');
        ToastUtil.showToast("加载更多...");
        _getHomeArticleList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getBanners();
    _getHomeArticleList();

    //注册eventbus 双击tab事件监听
    MyEventBus.eventBus.on<NotifyPageRefresh>().listen((event) {
      print("收到eventBus当前tabIndex = ${event.tabIndex}");
      if (event.tabIndex == 0) {
        //先滚动到顶部，then下拉刷新
        _controller
            .animateTo(0,
                duration: Duration(milliseconds: 300), curve: Curves.ease)
            .then((_) {
          _refresh();
        });
      }
    });
    //登录注册成功事件监听
    MyEventBus.eventBus.on<LoginRegisterSuccess>().listen((event) {
      print("收到eventBus登录注册成功事件");
      //先滚动到顶部，then下拉刷新
      _controller
          .animateTo(0,
              duration: Duration(milliseconds: 300), curve: Curves.ease)
          .then((_) {
        _refresh();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print('listData.length = ' + listData.length.toString());
    return listData.length <= 0
        ? Center(
            //数据加载progress
            child: CupertinoActivityIndicator(),
          )
        : RefreshIndicator(
            //下拉刷新控件
            child: ListView.builder(
              itemCount: listData.length + 1, //+1是广告位
              itemBuilder: (context, index) => buildListItem(index),
              controller: _controller,
            ),
            onRefresh: _refresh,
          );
  }

  _go2ItemDetail(String url, String title) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ItemDetailPage(url: url, title: title);
    }));
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
