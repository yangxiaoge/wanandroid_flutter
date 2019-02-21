import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../constant/component_index.dart';
import '../pages/zoom_image.dart';

class DiscoverItem extends StatelessWidget {
  const DiscoverItem(
    this.model, {
    Key key,
  }) : super(key: key);

  final Map<String, dynamic> model;

  @override
  Widget build(BuildContext context) {
    var title = model['title'];
    var titleId = model['id'];
    var link = model['link'];
    var desc = model['desc'];
    var author = model['author'];
    var niceDate = model['niceDate'];
    var envelopePic = model['envelopePic'];

    return new InkWell(
      onTap: () {
        NavigatorUtil.pushWeb(context,
            title: title, url: link, titleId: titleId.toString());
      },
      child: new Container(
          height: 160.0,
          padding: EdgeInsets.all(16.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                  child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.listTitle,
                  ),
                  SizedBox(height: Dimens.gap_dp10),
                  new Expanded(
                    flex: 1,
                    child: new Text(
                      desc,
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.listContent,
                    ),
                  ),
                  SizedBox(height: Dimens.gap_dp10),
                  new Row(
                    children: <Widget>[
                      new Text(
                        author,
                        style: TextStyles.listExtra,
                      ),
                      SizedBox(width: Dimens.gap_dp10),
                      new Text(
                        niceDate,
                        style: TextStyles.listExtra,
                      ),
                    ],
                  )
                ],
              )),
              new InkWell(
                child: Container(
                  width: 72,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 10.0),
                  child: new CachedNetworkImage(
                    width: 72,
                    height: 128,
                    fit: BoxFit.fill,
                    imageUrl: envelopePic,
                    placeholder: new CupertinoActivityIndicator(),
                    errorWidget: new Icon(Icons.error),
                  ),
                ),
                onTap: () {
                  NavigatorUtil.pushPage(context, GirlView(envelopePic, desc),
                      pageName: GirlView.ROUTER_NAME);
                },
              )
            ],
          ),
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                  bottom:
                      new BorderSide(width: 0.33, color: AppColors.dividerColor)))),
    );
  }
}
