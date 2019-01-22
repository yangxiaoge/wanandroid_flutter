import 'package:flutter/material.dart';
import 'splash_page.dart';
import 'home_screen.dart';
import 'constant/constants.dart';
import './util/sp_util.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _init();
    _initAsync();
  }

  ///初始化SPUtil
  void _initAsync() async {
    await SpUtil.getInstance().then((_){
      print("SP初始化完成");
    });
    if (!mounted) return;
  }
  void _init() {
    //DioUtil.openDebug();
    // Options options = DioUtil.getDefOptions();
    // options.baseUrl = Constant.SERVER_ADDRESS;
    // HttpConfig config = new HttpConfig(options: options);
    // DioUtil().setConfig(config);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WanAndroid',
      debugShowCheckedModeBanner: false, // 去除右上角 Debug 标签
      theme: ThemeData.light().copyWith(
        primaryColor: AppColors.AppBarColor,
        cardColor: AppColors.AppBarPopupMenuColor, //影响popupmenu,等其他控件颜色

        accentColor: AppColors.AppBarColor,
        indicatorColor: Colors.white,
      ),
      home: SplashPage(), // 闪屏页
      routes: {
        // 路由
        HomeScreen.ROUTER_NAME: (context) => HomeScreen()
      },
    );
  }
}
