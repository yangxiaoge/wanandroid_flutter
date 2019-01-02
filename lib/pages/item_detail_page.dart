import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ItemDetailPage extends StatefulWidget {
  String url;
  String title;
  ItemDetailPage({Key key, @required String this.url, @required String this.title})
      : super(key: key);

  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Text(widget.url),);
  }
}
