import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constant/weatherdata.dart';
import '../constant/component_index.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  final String cityName;

  WeatherPage(this.cityName);

  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<WeatherPage> {
  String cityName;
  WeatherData weather = WeatherData.empty();

  @override
  void initState() {
    super.initState();
    cityName = widget.cityName;
    _getWeather();
  }

  void _getWeather() async {
    WeatherData data = await _fetchWeather();
    setState(() {
      weather = data;
    });
  }

  Future<WeatherData> _fetchWeather() async {
    final response = await http.get(
        'https://free-api.heweather.com/s6/weather/now?location=' +
            this.cityName +
            '&key=f7da3083a7bf45b7800704d128bd6900');
    if (response.statusCode == 200) {
      return WeatherData.fromJson(json.decode(response.body));
    } else {
      return WeatherData.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${this.cityName}实时天气"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: Constants.WEATHER_bg,
            fit: BoxFit.fitHeight,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 40.0),
                child: Text(
                  this.cityName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 100.0),
                child: Column(
                  children: <Widget>[
                    Text(weather?.tmp,
                        style: TextStyle(color: Colors.white, fontSize: 80.0)),
                    Text(weather?.cond,
                        style: TextStyle(color: Colors.white, fontSize: 45.0)),
                    Text(
                      weather?.hum,
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
