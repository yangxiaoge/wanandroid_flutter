import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ItemDetailPage extends StatefulWidget {
  String url;
  String title;
  ItemDetailPage(
      {Key key, @required String this.url, @required String this.title})
      : super(key: key);

  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
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

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        title: Text(widget.title),
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        color: Colors.redAccent,
        child: Center(
          child: Text('Waiting.....'),
        ),
      ),
    );
  }
}
