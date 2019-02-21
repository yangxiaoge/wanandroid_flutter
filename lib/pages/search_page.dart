import 'package:flutter/material.dart';

import '../constant/component_index.dart';
import '../widget/refresh_scaffold.dart';

class SearchPage extends StatefulWidget {
  final String searchWord;

  SearchPage(this.searchWord);

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // 输入的搜索词
  String _search;

  // 显示搜索出来的文章列表
  bool _showSearchList = false;

  // 当前页码
  int _pageIndex = 0;

  // 文章列表集合
  List listData = new List();

  //数据总长度
  int totalLength = 0;

  //热词 Chip 组件
  List<Widget> hotKeyChips = List();

  TextEditingController _searchControl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getHotKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Directionality(
            textDirection: Directionality.of(context),
            child: TextField(
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
              decoration: InputDecoration(
                hintText: IntlUtil.getString(context, Ids.search),
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              autofocus: true,
              controller: _searchControl,
              onSubmitted: (String search) async {
                //此处也可以不查询
                _search = search;
                _queryWord();
              },
            )),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _search = _searchControl.text;
                _queryWord();
              }),
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _searchControl.clear();
                setState(() {
                  _showSearchList = false;
                });
              })
        ],
      ),
      body:   hotKeyListView(),
    );
  }

  Widget hotKeyListView() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('大家都在搜',
              style: new TextStyle(
                  color: Theme.of(context).accentColor, fontSize: 20.0)),
        ),
        Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Wrap(
              spacing: 5.0,
              runSpacing: 5.0,
              children: hotKeyChips,
            )),
      ],
    );
  }

  /*Widget refreshScaffold() {
    return RefreshScaffold(
      //labelId: title ?? IntlUtil.getString(context, titleId),
      isLoading: _showSearchList,
      controller: _controller,
      enablePullUp: false,
      onRefresh: () {
        print("供热放入搜索11111------------");
      },
      itemCount: listData.length,
      itemBuilder: (BuildContext context, int index) {
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
      },
    );
  }*/

  /// 获取热词
  void _getHotKey() {
    HttpUtil.dioGet2(WanApi.HotKey, (response) {
      var data = response['data'];
      print("hotkey----->: " + data.toString());
      if (this.mounted) {
        setState(() {
          //先清除之前的控件
          hotKeyChips.clear();

          for (var itemChip in data) {
            Widget itemChipWidget = ActionChip(
              label:
                  Text(itemChip['name'], style: TextStyle(color: Colors.white)),
              backgroundColor: Theme.of(context).accentColor,
              onPressed: () {
                _search = itemChip['name'];
                _searchControl.text = _search;
                _queryWord();
              },
            );

            hotKeyChips.add(itemChipWidget);
          }
        });
      }
    });
  }

  /// 搜索关键词
  void _queryWord() async {
    setState(() {
      _showSearchList = true;
    });

    print("_search = $_search");
    var url = WanApi.ARTICLE_QUERY + "$_pageIndex/json";
    print("url = $url");
    Map<String, String> paramsMap = Map();
    paramsMap['k'] = _search;
    var response = await HttpUtil.dioPost(url, params: paramsMap);
    var data = response['data'];
    int errorCode = response['errorCode'];
    String errorMsg = response['errorMsg'];

    if (errorCode >= 0) {
      print(response);
    } else {
      print("出错啦，errorMsg : $errorMsg");
      ToastUtil.showToast(errorMsg);
      setState(() {
        _showSearchList = false;
      });
      return;
    }

    List _listData = data['datas'];
    totalLength = data["total"];
    print("datas = $_listData");
    print("totalLength = $totalLength");
    setState(() {
      listData = _listData;
    });
    //_pageIndex++;
  }

  _likeClick(var itemData) async {
    bool login = AppStatus.getBool(Constants.loginSp);
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

  _go2ItemDetail(String url, String title,
      {String titleId, bool isCollected: false}) {
    NavigatorUtil.pushWeb(context,
        title: title, url: url, titleId: titleId, isCollected: isCollected);
  }
}
