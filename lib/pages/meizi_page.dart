import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './zoom_image.dart';
import '../constant/component_index.dart';

class MeiZiPage extends StatefulWidget {
  _MeiZiPageState createState() => _MeiZiPageState();
}

class _MeiZiPageState extends State<MeiZiPage> {
  //第几页，数字，大于 0
  int _pageIndex = 1;
  List meizi = new List();
  //上拉监听
  ScrollController _controller = new ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getMeiZi();

    //注册eventbus事件监听
    MyEventBus.eventBus.on<NotifyPageRefresh>().listen((event) {
      print("收到eventBus当前tabIndex = ${event.tabIndex}");
      if (event.tabIndex == NavTabItems.WELFARE.index) {
        //先滚动到顶部，then下拉刷新
        _controller
            .animateTo(0,
                duration: Duration(milliseconds: 300), curve: Curves.ease)
            .then((_) {
          _refresh();
        });
      }
    });
  }

  //上拉加载更多
  _MeiZiPageState() {
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels) {
        //上拉刷新做处理
        print('load more ...');
        ToastUtil.showToast(IntlUtil.getString(context, Ids.loadingMore));
        _getMeiZi();
      }
    });
  }

  _getMeiZi() {
    HttpUtil.dioGetMeiZi(GankIO.MEIZI, _pageIndex, (response) {
      List _getDatas = response['results'];
      print("-------妹子 tab datas = $_getDatas");
      if (this.mounted) {
        setState(() {
          if (_pageIndex == 0) {
            meizi.clear();
          }
          meizi.addAll(_getDatas);
          _pageIndex++;
        });
      }
    }, errorCallback: (errorMsg) {
      ToastUtil.showToast("获取妹子列表出错，$errorMsg");
    });
  }

  //下拉刷新
  Future _refresh() async {
    _pageIndex = 0;
    _getMeiZi();
  }

  @override
  Widget build(BuildContext context) {
    return meizi.length <= 0
        ? Center(
            //数据加载progress
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            //下拉刷新控件
            child: GridView.builder(
              padding: EdgeInsets.all(5),
              controller: _controller,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.7),
              scrollDirection: Axis.vertical,
              itemCount: meizi.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    print("meizi url = ${meizi[index]['url']}");
                    NavigatorUtil.pushPage(context,
                        GirlView(meizi[index]['url'], meizi[index]['desc']));
                  },
                  child: SizedBox(
                    height: 300,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: CachedNetworkImage(
                            imageUrl: meizi[index]['url'],
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                CupertinoActivityIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Positioned(
                          bottom: 6,
                          left: 6,
                          child: Text(
                            meizi[index]['desc'],
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            onRefresh: _refresh,
          );
  }
}
