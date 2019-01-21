import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../util/navigator_util.dart';
import '../constant/component_index.dart';
//webview页面（item详情页）
class ItemDetailPage extends StatefulWidget {
  final String url;
  final String title;

  ItemDetailPage({Key key, @required this.url, @required this.title})
      : super(key: key);

  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  WebViewController _webViewController;
  bool _isShowFloatBtn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.language),
              onPressed: () {
                //打开浏览器
                NavigatorUtil.launchInBrowser(widget.url);
              }),
               IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              print("分享网页");
              //分享文本
              Share.share(widget.url);
            },
          )
        ],
      ),
      body: WebView(
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
          _webViewController.addListener(() {
            int _scrollY = _webViewController.scrollY.toInt();
            if (_scrollY < 480 && _isShowFloatBtn) {
              _isShowFloatBtn = false;
              setState(() {});
            } else if (_scrollY > 480 && !_isShowFloatBtn) {
              _isShowFloatBtn = true;
              setState(() {});
            }
          });
        },
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    if (_webViewController == null || _webViewController.scrollY < 480) {
      return null;
    }
    return new FloatingActionButton(
        heroTag: widget.title,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.keyboard_arrow_up,
        ),
        onPressed: () {
          _webViewController.scrollTop();
        });
  }
}
