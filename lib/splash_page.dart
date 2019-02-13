import 'package:flutter/material.dart';
import 'home_screen.dart';
import './constant/component_index.dart';

//闪屏页
class SplashPage extends StatefulWidget {
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  TimerUtil _timerUtil;

  ///倒计时3秒
  int _count = 3;

  bool permissionGranted = false;

  @override
  void initState() {
    super.initState();
    Constants.mContext = context;
    _initSplash();
    _doPermissionTask();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timerUtil != null) _timerUtil.cancel();
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
              padding: EdgeInsets.only(top: 150),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 35.0,
                    backgroundImage:
                        ImageUtil.getImageProvider(Constants.Icon_PATH),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(IntlUtil.getString(context, Ids.welcome) + "😊",
                      style: TextStyle(
                          color: AppColors.AppBarColor,
                          fontSize: 25.0,
                          fontFamily: Constants.WorkSansMedium)),
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
                        fontFamily: Constants.WorkSansMedium)),
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
                          color: Colors.black45,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          border: new Border.all(
                              width: 0.33, color: AppColors.DIVIDER))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
