import 'package:flutter/material.dart';
import '../constant/component_index.dart';
import '../constant/language_model.dart';

class LanguagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LanguagePageState();
  }
}

class _LanguagePageState extends State<LanguagePage> {
  List<LanguageModel> _list = List();

  LanguageModel _currentLanguage;

  @override
  void initState() {
    super.initState();

    _list.add(LanguageModel(Ids.languageAuto, '', ''));
    _list.add(LanguageModel(Ids.languageZH, 'zh', 'CH'));
    _list.add(LanguageModel(Ids.languageTW, 'zh', 'TW'));
    _list.add(LanguageModel(Ids.languageHK, 'zh', 'HK'));
    _list.add(LanguageModel(Ids.languageEN, 'en', 'US'));

    //当前语言
    _currentLanguage = AppStatus.getLanguageModel();
    if (ObjectUtil.isEmpty(_currentLanguage)) {
      _currentLanguage = _list[0];
    }

    _updateData();
  }

  ///更新语言选择列表
  void _updateData() {
    LogUtil.e('currentLanguage: ' + _currentLanguage.toString());
    String language = _currentLanguage.countryCode;
    for (int i = 0, length = _list.length; i < length; i++) {
      _list[i].isSelected = (_list[i].countryCode == language);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          IntlUtil.getString(context, Ids.titleLanguage),
          style: TextStyle(fontSize: 16.0),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: SizedBox(
              width: 64.0,
              child: RaisedButton(
                textColor: Colors.white,
                color: AppColors.AppBarColor,
                child: Text(
                  IntlUtil.getString(context, Ids.save),
                  style: TextStyle(fontSize: 12.0),
                ),
                onPressed: () {
                  AppStatus.putObject(
                      Constants.Language,
                      //languageCode为空，跟随系统
                      ObjectUtil.isEmpty(_currentLanguage.languageCode)
                          ? null
                          : _currentLanguage);
                  bloc.sendAppEvent(Constants.NOTIFY_SYS_UPDATE);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int index) {
            LanguageModel model = _list[index];
            return ListTile(
              title: Text(
                (model.titleId == Ids.languageAuto
                    ? IntlUtil.getString(context, model.titleId)
                    : IntlUtil.getString(context, model.titleId,
                        languageCode: 'zh', countryCode: 'CH')),
                style: TextStyle(fontSize: 13.0),
              ),
              trailing: Radio(
                  value: true,
                  groupValue: model.isSelected == true,
                  activeColor: AppColors.AppBarColor,
                  onChanged: (value) {
                    setState(() {
                      _currentLanguage = model;
                      _updateData();
                    });
                  }),
              onTap: () {
                setState(() {
                  _currentLanguage = model;
                  _updateData();
                });
              },
            );
          }),
    );
  }
}
