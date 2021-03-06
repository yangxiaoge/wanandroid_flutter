import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/component_index.dart';
import '../util/navigator_util.dart';

//webview页面（item详情页）
class ItemDetailPage extends StatefulWidget {
  final String url;
  final String title;
  final String titleId;
  final bool isCollected;

  ItemDetailPage(
      {Key key,
      @required this.url,
      @required this.title,
      this.titleId,
      this.isCollected})
      : super(key: key);

  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  FlutterWebviewPlugin flutterWebViewPlugin = new FlutterWebviewPlugin();
  //  flutterWebViewPlugin.reload(); //重新加载网页
  bool isLoad = true;
  //bool _isShowFloatBtn = false;
  bool isCollected = false;

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isCollected = widget.isCollected;
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          isLoad = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoad = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              isCollected ? Icons.favorite : Icons.favorite_border,
              color: isCollected ? Colors.red : null,
            ),
            onPressed: () {},
          ),
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
        bottom: new PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: isLoad
                ? new LinearProgressIndicator(
                    backgroundColor: Colors.transparent,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.black54),
                  )
                : new Divider(
                    height: 0.0,
                    color: Theme.of(context).primaryColor,
                  )),
      ),
      body: WebviewScaffold(
        hidden: true,
        url: widget.url,
        withZoom: true,
        withLocalStorage: true,
        withJavascript: true,
        initialChild: Container(
          child: const Center(
            child: CupertinoActivityIndicator(),
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    return new FloatingActionButton(
        heroTag: widget.title,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.close,
        ),
        onPressed: () {
          Navigator.of(context).pop(true);
        });
  }
}
