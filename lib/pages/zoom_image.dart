import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_extend/share_extend.dart';

class GirlView extends StatefulWidget {
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
              ShareExtend.share(widget.url, "text");
            },
          )
        ],
      ),
      body: Container(
          child: GestureDetector(
        onTap: () {
          print("点击了妹子");
          Navigator.pop(context);
        },
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(widget.url),
        ),
      )),
    );
  }
}
