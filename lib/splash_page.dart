import 'package:flutter/material.dart';

import './constant/component_index.dart';
import 'home_screen.dart';

//闪屏页
class SplashPage extends StatefulWidget {
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  TimerUtil _timerUtil;

  ///倒计时3秒
  int _count = 3;

  bool permissionGranted = false;

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    Constants.mContext = context;
    _initSplash();
    _doPermissionTask();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    //图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    //启动动画(正向执行)
    controller.forward();
  }

  @override
  void dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    if (_timerUtil != null) _timerUtil.cancel();
    super.dispose();
  }

  _doPermissionTask() async {
    permissionGranted = await PermissionUtil.deal([
      PermissionGroup.storage,
      PermissionGroup.location,
      PermissionGroup.phone
    ]);
    if (permissionGranted) {
      if (_count == 0) {
        if (this.mounted) {
          _go2Main();
        } else {
          LogUtil.v("闪屏页面已经销毁");
        }
      }
    }
  }

  void _initSplash() {
    //定时器
    _timerUtil = new TimerUtil(mTotalTime: 3 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
      });
      if (_tick == 0) {
        _go2Main();
      }
    });
    _timerUtil.startCountDown();
  }

  void _go2Main() {
    // 暂时不判断权限是否不足，可以直接进入主页（目前项目不需要申请危险权限，后续可能要用到）
    if (!permissionGranted) return;
    NavigatorUtil.pushPageReplacementNamed(context, HomeScreen.ROUTER_NAME);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 130),
              child: Column(
                children: <Widget>[
                  Container(
                    child: CircleAvatar(
                      radius: 35.0,
                      backgroundImage:
                          ImageUtil.getImageProvider(Constants.iconPath),
                    ),
                    width: animation.value,
                    height: animation.value,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(IntlUtil.getString(context, Ids.welcome) + "😊",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 25.0,
                          fontFamily: Constants.workSansMedium)),
                ],
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('${DateTime.now().year}@Bruce Yang',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontFamily: Constants.workSansMedium)),
              ),
            ),
            Offstage(
              offstage: false,
              child: new Container(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: InkWell(
                  onTap: () {
                    _go2Main();
                  },
                  child: new Container(
                      padding: EdgeInsets.all(12.0),
                      child: new Text(
                        '${IntlUtil.getString(context, Ids.skip)} $_count',
                        style:
                            new TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                      decoration: new BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          border: new Border.all(
                              width: 0.33, color: AppColors.dividerColor))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
