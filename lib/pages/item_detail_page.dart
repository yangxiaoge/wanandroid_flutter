import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemDetailPage extends StatefulWidget {
  final String url;
  final String title;

  ItemDetailPage({Key key, @required this.url, @required this.title})
      : super(key: key);

  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onScrollYChanged.listen((double offsetY) {
      // latest offset value in vertical scroll
      // compare vertical scroll changes here with old value
      print("offsetY = $offsetY");
    });

    flutterWebviewPlugin.onScrollXChanged.listen((double offsetX) {
      // latest offset value in horizontal scroll
      // compare horizontal scroll changes here with old value
      print("offsetX = $offsetX");
    });
  }

  //打开手机浏览器打开网页
  void _launchURL(String url, BuildContext context) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.language),
              onPressed: () {
               _launchURL(widget.url, context);
              }),
        ],
      ),
      body: WebviewScaffold(
        url: widget.url,
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initialChild: Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}
