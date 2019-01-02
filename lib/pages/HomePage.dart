import 'package:flutter/material.dart';

import '../net/api_service.dart' show WanApi;
import '../net/http_util.dart' show HttpUtil;
import '../util/ToastUtil.dart' show ToastUtil;

//首页
class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 当前页码
  int _pageIndex = 0;
  // datas
  List listData = new List();
  //数据总长度
  int totalLength = 0;
  //上拉监听
  ScrollController _controller = new ScrollController();

  _getHomeArticleList() async {
    var url = WanApi.Home_Article_List + "$_pageIndex/json";
    HttpUtil.getHttp(url, (data) {
      if (data != null) {
        Map<String, dynamic> datas = data;
        var _getDatas = datas['datas'];
        totalLength = datas['total'];

        print("首页列表: " + _getDatas.toString());
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

  //下拉刷新
  Future _refresh() async {
    _pageIndex = 0;
    _getHomeArticleList();
  }

  //上拉加载
  //https://juejin.im/post/5b6ac41651882519861c3b79
  _HomePageState() {
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels && listData.length < totalLength) {
        //上拉刷新做处理
        print('load more ...');
        ToastUtil.showToast("加载中");
        _getHomeArticleList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getHomeArticleList();
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
              itemCount: listData.length,
              itemBuilder: (context, index) => buildListItem(index),
              controller: _controller,
            ),
            onRefresh: _refresh,
          );
  }

  Widget buildListItem(int index) {
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
        IconButton(
          icon: Icon(
            isCollected ? Icons.favorite : Icons.favorite_border,
            color: isCollected ? Colors.red : null,
          ),
          onPressed: () {},
        )
      ],
    );

    return Column(
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
    );
  }
}
