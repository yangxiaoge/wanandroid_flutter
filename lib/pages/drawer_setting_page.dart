import 'package:flutter/material.dart';

import '../constant/component_index.dart';
import 'drawer_language_page.dart';

class SettingPage extends StatefulWidget {
  static const String ROUTER_NAME = 'setting';

  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(IntlUtil.getString(context, Ids.titleSetting)),
        // centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.color_lens,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    IntlUtil.getString(context, Ids.titleTheme),
                  ),
                )
              ],
            ),
            children: <Widget>[
              Wrap(
                children: AppColors.themeMap.keys.map((String key) {
                  Color value = AppColors.themeMap[key];
                  return InkWell(
                    onTap: () {
                      AppStatus.putString(Constants.themeColorSp, key);
                      //通知刷新主题
                      bloc.sendAppEvent(Constants.notifySysThemeUpdate);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      width: 36.0,
                      height: 36.0,
                      color: value,
                    ),
                  );
                }).toList(),
              )
            ],
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.language,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    IntlUtil.getString(context, Ids.titleLanguage),
                  ),
                )
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    AppStatus.getLanguageModel() == null
                        ? IntlUtil.getString(context, Ids.languageAuto)
                        : IntlUtil.getString(
                            context, AppStatus.getLanguageModel().titleId,
                            languageCode: 'zh', countryCode: 'CH'),
                    style: TextStyle(
                      fontSize: 14.0,
                    )),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
            onTap: () {
              NavigatorUtil.pushPage(context, LanguagePage(),
                  pageName: Ids.titleLanguage);
            },
          )
        ],
      ),
    );
  }
}
