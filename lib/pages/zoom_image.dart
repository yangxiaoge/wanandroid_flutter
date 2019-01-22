import 'package:flutter/material.dart';
import '../constant/component_index.dart';

class GirlView extends StatefulWidget {
  static const String ROUTER_NAME = '/GirlView';

  final String url;
  final String time;
  GirlView(this.url, this.time);
  _GirlViewState createState() => _GirlViewState();
}

class _GirlViewState extends State<GirlView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.time),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              print("分享妹子");
              //分享文本
              Share.share(widget.url);
            },
          )
        ],
      ),
      body: Container(
          child: GestureDetector(
        onTap: () {
          print("点击了妹子");
          //todo 不关闭页面
          //Navigator.pop(context);
        },
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(widget.url),
        ),
      )),
    );
  }
}
