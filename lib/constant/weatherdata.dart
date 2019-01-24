///https://free-api.heweather.com/s6/weather/now?location=%E5%B9%BF%E5%B7%9E&key=换成自己的key（和风天气）
class WeatherData{
  String cond; //天气
  String tmp; //温度
  String hum; //湿度

  WeatherData({this.cond, this.tmp, this.hum});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cond: json['HeWeather6'][0]['now']['cond_txt'],
      tmp: json['HeWeather6'][0]['now']['tmp']+"°",
      hum: "湿度  "+json['HeWeather6'][0]['now']['hum']+"%",
    );
  }

  factory WeatherData.empty() {
    return WeatherData(
      cond: "",
      tmp: "",
      hum: "",
    );
  }
}