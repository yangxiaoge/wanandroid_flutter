import 'package:flutter/material.dart';

import '../net/api_service.dart' show WanApi;
import '../net/http_util.dart' show HttpUtil;
import '../util/ToastUtil.dart' show ToastUtil;
import '../constant/constants.dart';
import '../eventbus/tab_page_refresh_event.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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

        print("首页列表----->: " + _getDatas.toString());
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
    });
  }

  //获取广告
  _getBanners() async {
    var url = WanApi.Banner;
    HttpUtil.getHttp(url, (data) {
      if (data != null) {
        setState(() {
          banners.clear();
          banners.addAll(data);
          print("广告----->: " + banners.toString());
        });
      }
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

    //注册eventbus事件监听
    MyEventBus.eventBus.on<NotifyPageRefresh>().listen((event) {
      print("收到eventBus当前tabIndex = ${event.tabIndex}");
      if (event.tabIndex == 0) {
        //先滚动到顶部，then下拉刷新
        _controller
            .animateTo(0,
                duration: Duration(milliseconds: 300), curve: Curves.ease)
            .then((Null) {
          _refresh();
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('listData.length = ' + listData.length.toString());
    return listData.length == null
        ? Center(
            //数据加载progress
            child: CircularProgressIndicator(),
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

  Widget buildListItem(int index) {
    // print("index = $index");
    if (index == 0) {
      return Container(
        child: Swiper(
          itemBuilder: (context, i) {
            //print("banners[$i] = ${banners[i]}, imagePath = ${banners[i]['imagePath']}");
            return Image.network(
              banners[i]['imagePath'],
              fit: BoxFit.fill,
            );
          },
          itemCount: banners.length,
          loop: true,
          autoplay: true,
          duration: 1500,
          // control: new SwiperControl(),
          pagination: new SwiperCustomPagination(
              builder: (BuildContext context, SwiperPluginConfig config) {
            int index = config.activeIndex;
            return Container(
              child: Text(
                banners[index]['title'],
                style: new TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              margin: EdgeInsets.fromLTRB(10, 155, 0, 0),
            );
          }),
          onTap: (i) {
            print("banners[$i]['url'] = ${banners[i]['url']}");
          },
        ),
        height: 180,
      );
    } else {
      index -= 1; //下标需要减去广告位
      var itemData = listData[index];
      bool isCollected = itemData['collect'];
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
            onTap: () {},
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
          onTap: () {},
        ),
        color: Colors.white,
        elevation: 3,
      );
    }
  }
}
