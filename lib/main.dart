import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'splash_page.dart';
import 'home_screen.dart';
import './constant/component_index.dart';
import './constant/language_model.dart';

void main() {
  setCustomErrorPage();

  runApp(BlocProvider<ApplicationBloc>(
    bloc: ApplicationBloc(),
    child: BlocProvider(child: MyApp(), bloc: null),
  ));

  //沉浸式
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

///自定义错误页面
void setCustomErrorPage() {
  ErrorWidget.builder = (flutterErrorDetails) {
    //打出错误信息
    print(flutterErrorDetails.toString());
    return Scaffold(
      body: Center(child: Text(Ids.errorWidgetMsg)),
    );
  };
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  @override
  void initState() {
    super.initState();
    //配置多语言资源
    setLocalizedValues(localizedValues);
    _initAsync();
    _initListener();
  }

  ///初始化SPUtil
  void _initAsync() async {
    await SpUtil.getInstance().then((_) {
      print("SP初始化完成");
      _getLocale();
    });
  }

  ///bloc状态监听
  void _initListener() {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    bloc.appEventStream.listen((value) {
      print("Stream listen:value = $value");
      _getLocale();
    });
  }

  ///获取上次设置的语言
  void _getLocale() {
    setState(() {
      LanguageModel languageModel = AppStatus.getLanguageModel();
      if (languageModel != null) {
        _locale = Locale(languageModel.languageCode, languageModel.countryCode);
      } else {
        _locale = null;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,

      locale: _locale,
      theme: ThemeData.light().copyWith(
          accentColor: AppColors.appColor,
          primaryColor: AppColors.appColor,
          cardColor: AppColors.popMenuColor, //影响popupmenu,等其他控件颜色
          dividerColor: AppColors.dividerColor,
          indicatorColor: Colors.white,
          platform: TargetPlatform.android),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        CustomLocalizations.delegate //设置本地化代理
      ],
      supportedLocales: CustomLocalizations.supportedLocales, //设置支持本地化语言集合

      home: SplashPage(), // 闪屏页
      routes: {
        // 路由
        HomeScreen.ROUTER_NAME: (context) => HomeScreen()
      },
    );
  }
}
