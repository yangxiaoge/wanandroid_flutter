import 'package:dio/dio.dart';
import 'package:http/http.dart' as http; // 网络

import 'dart:convert';
import 'api_service.dart' show WanApi;

class HttpUtil {
  static final Dio dio = new Dio();
  // dio 网络请求，有点问题，后面解决
  static get(String url, Function callback,
      {Map<String, String> params,
      Map<String, String> headers,
      Function errorCallback}) async {
    // url组合
    url = WanApi.BaseUrl + url;
    print("url1=" + url);
    // 参数拼接
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer();
      sb.write("?");
      params.forEach((key, value) {
        sb.write("$key=$value&");
      });
      // url + params
      url += sb.toString().substring(0, sb.toString().length - 1);
    }
    print("url2=" + url);
    //请求网络
    print("params.toString() = " + params.toString());
    Response response = await dio.get(url);
    print(response.data);
    callback(response.data);
    //return response.data;
  }

  //http 网络请求
  static Future getHttp(String url, Function callback,
      {Map<String, String> params,
      Map<String, String> headers,
      Function errorCallback}) async {
    // url组合
    url = WanApi.BaseUrl + url;
    print("url1=" + url);
    // 参数拼接
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer();
      sb.write("?");
      params.forEach((key, value) {
        sb.write("$key=$value&");
      });
      // url + params
      url += sb.toString().substring(0, sb.toString().length - 1);
    }
    print("url2=" + url);
    //请求网络
    print("params.toString() = " + params.toString());
    var response = await http.get(url);
    //print(response.body);

    Map<String, dynamic> resMap = json.decode(response.body);
    int errorCode = resMap['errorCode'];
    String errorMsg = resMap['errorMsg'];
    var data = resMap['data'];
    if (errorCode >= 0) {
      print(resMap.toString());
      //print(data);
      callback(data);
    } else {
      print("出错啦，errorMsg : $errorMsg");
      errorCallback(errorMsg);
    }
  }
}
