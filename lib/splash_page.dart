import 'package:flutter/material.dart';
import 'home_screen.dart';
import './constant/component_index.dart';

//闪屏页
class SplashPage extends StatefulWidget {
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  TimerUtil _timerUtil;
  int _count = 3;

  void _go2Main() {
    NavigatorUtil.pushPageReplacementNamed(context, HomeScreen.ROUTER_NAME);
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

  @override
  void initState() {
    super.initState();
    _initSplash();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timerUtil != null) _timerUtil.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: FractionalOffset.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 150.0),
                child: CircleAvatar(
                  radius: 35.0,
                  child: Image.asset(
                    'android/app/src/main/res/mipmap-xhdpi/zz.png',
                    width: 100,
                  ),
                ),
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
                        '跳过 $_count',
                        style:
                            new TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                      decoration: new BoxDecoration(
                          color: Color(0x66000000),
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
