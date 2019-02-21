import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../widget/link_text_span.dart';
import '../constant/component_index.dart';

class AboutPage extends StatefulWidget {
  static const String ROUTER_NAME = 'about';

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    TextStyle linkTextStyle = Theme.of(context).textTheme.body1.copyWith(
        color: Theme.of(context).accentColor,
        fontSize: 15,
        decoration: TextDecoration.underline);
    TextStyle linkTitleStyle = Theme.of(context).textTheme.body1;
    return Scaffold(
      appBar: AppBar(
        title: Text(IntlUtil.getString(context, Ids.titleAbout)),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    backgroundImage:
                        ImageUtil.getImageProvider(Constants.iconPath),
                    radius: 35.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                ),
                Text(IntlUtil.getString(context, Ids.introduction),
                    style: Theme.of(context).textTheme.title),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Divider(height: 0.0),
                ),
                Text(IntlUtil.getString(context, Ids.mumuxiDesc),
                    style: Theme.of(context).textTheme.body1),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text(
                          IntlUtil.getString(context, Ids.personalWebSite),
                          style: linkTitleStyle,
                        ),
                      ),
                      RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            style: Theme.of(context).textTheme.body1.copyWith(
                                color: Theme.of(context).accentColor,
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                            text: "https://yangxiaoge.github.io",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launch('https://yangxiaoge.github.io');
                              })
                      ]))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text(
                          IntlUtil.getString(context, Ids.sourceCode),
                          style: linkTitleStyle,
                        ),
                      ),
                      RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            style: Theme.of(context).textTheme.body1.copyWith(
                                color: Theme.of(context).accentColor,
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                            text: "yangxiaoge/wanandroid_flutter",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launch(
                                    'https://github.com/yangxiaoge/wanandroid_flutter');
                              })
                      ]))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text(
                          IntlUtil.getString(context, Ids.apiWebSite),
                          style: linkTitleStyle,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          RichText(
                              text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .body1
                                    .copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 15,
                                        decoration: TextDecoration.underline),
                                text: "http://www.wanandroid.com/",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launch(
                                        'http://www.wanandroid.com/blog/show/2');
                                  })
                          ])),
                          RichText(
                              text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .body1
                                    .copyWith(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 15,
                                        decoration: TextDecoration.underline),
                                text: "https://gank.io/app/gank",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launch('https://gank.io/app/gank');
                                  })
                          ])),
                        ],
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text(
                          '代码开发规范',
                          style: linkTitleStyle,
                        ),
                      ),
                      RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                style: Theme.of(context).textTheme.body1.copyWith(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline),
                                text: "github.com/alibaba/flutter-go",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launch(
                                        'https://github.com/alibaba/flutter-go/blob/develop/Flutter_Go%20%E4%BB%A3%E7%A0%81%E5%BC%80%E5%8F%91%E8%A7%84%E8%8C%83.md');
                                  })
                          ]))
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(IntlUtil.getString(context, Ids.developer),
                      style: Theme.of(context).textTheme.title),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Divider(height: 0.0),
                ),
                Text("yangxiaoge", style: Theme.of(context).textTheme.body1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: CachedNetworkImage(
                          width: 30,
                          height: 30,
                          imageUrl:
                              "https://img.icons8.com/windows/1600/github-2.png",
                        ),
                      ),
                      RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            style: Theme.of(context).textTheme.body1.copyWith(
                                color: Theme.of(context).accentColor,
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                            text: "https://github.com/yangxiaoge",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launch('https://github.com/yangxiaoge');
                              })
                      ]))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(IntlUtil.getString(context, Ids.referenceProject),
                      style: Theme.of(context).textTheme.title),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Divider(height: 0.0),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Text("Sky24n",
                            style: Theme.of(context).textTheme.body1),
                      ),
                      RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            style: Theme.of(context).textTheme.body1.copyWith(
                                color: Theme.of(context).accentColor,
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                            text: "https://github.com/Sky24n",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launch(
                                    'https://github.com/Sky24n/flutter_wanandroid');
                              })
                      ]))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Text("lijinshanmx",
                            style: Theme.of(context).textTheme.body1),
                      ),
                      RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            style: Theme.of(context).textTheme.body1.copyWith(
                                color: Theme.of(context).accentColor,
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                            text: "https://github.com/lijinshanmx",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launch(
                                    'https://github.com/lijinshanmx/flutter_gank');
                              })
                      ]))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                      IntlUtil.getString(context, Ids.openSourceLibrary),
                      style: Theme.of(context).textTheme.title),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Divider(height: 0.0),
                ),
                LinkTextSpan(
                    'cached_network_image',
                    'https://github.com/renefloor/flutter_cached_network_image',
                    linkTitleStyle,
                    linkTextStyle),
                LinkTextSpan(
                    'flutter_webview_plugin',
                    'https://github.com/dart-flitter/flutter_webview_plugin',
                    linkTitleStyle,
                    linkTextStyle),
                LinkTextSpan(
                    'fluttertoast',
                    'https://github.com/PonnamKarthik/FlutterToast',
                    linkTitleStyle,
                    linkTextStyle),
                LinkTextSpan(
                    'photo_view',
                    'https://github.com/renancaraujo/photo_view',
                    linkTitleStyle,
                    linkTextStyle),
                LinkTextSpan(
                    'flutter_pulltorefresh',
                    'https://github.com/peng8350/flutter_pulltorefresh',
                    linkTitleStyle,
                    linkTextStyle),
                LinkTextSpan('dio', 'https://github.com/flutterchina/dio',
                    linkTitleStyle, linkTextStyle),
                LinkTextSpan('http', 'https://github.com/dart-lang/http',
                    linkTitleStyle, linkTextStyle),
                LinkTextSpan(
                    'dart-event-bus',
                    'https://github.com/marcojakob/dart-event-bus',
                    linkTitleStyle,
                    linkTextStyle),
                LinkTextSpan(
                    'url_launcher',
                    'https://github.com/flutter/plugins/tree/master/packages/url_launcher',
                    linkTitleStyle,
                    linkTextStyle),
                LinkTextSpan(
                    'flutter_swiper',
                    'https://github.com/best-flutter/flutter_swiper',
                    linkTitleStyle,
                    linkTextStyle),
                LinkTextSpan(
                    'flutter/plugins',
                    'https://github.com/yangxiaoge/plugins',
                    linkTitleStyle,
                    linkTextStyle),
                LinkTextSpan('flukit', 'https://github.com/flutterchina/flukit',
                    linkTitleStyle, linkTextStyle),
                LinkTextSpan(
                    'pull_to_refresh',
                    'https://github.com/peng8350/flutter_pulltorefresh',
                    linkTitleStyle,
                    linkTextStyle),
                Text("未完待续~~~"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
