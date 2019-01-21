import 'package:flutter/material.dart';
import 'home_screen.dart';
import './constant/constants.dart';

//闪屏页
class SplashPage extends StatefulWidget {
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.ROUTER_NAME);
    });
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
                child: Image.asset(
                  'assets/images/zz.png',
                  width: 100,
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
          ],
        ),
      ),
    );
  }
}
