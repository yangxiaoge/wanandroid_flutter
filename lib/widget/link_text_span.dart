import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkTextSpan extends StatefulWidget {
  final title, url, linkTitleStyle, linkTextStyle;

  LinkTextSpan(this.title, this.url, this.linkTitleStyle, this.linkTextStyle);

  @override
  _LinkTextSpanState createState() => _LinkTextSpanState();
}

class _LinkTextSpanState extends State<LinkTextSpan> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
          ),
          RichText(
              text: TextSpan(children: <TextSpan>[
            TextSpan(
                style: widget.linkTextStyle,
                text: widget.title,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launch(widget.url);
                  })
          ]))
        ],
      ),
    );
  }
}
