import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../constant/constants.dart';
import 'api_service.dart' show WanApi, GankIO;
// 网络

class HttpUtil {
  //-----------------------------dio---------------------------------//
  static final Dio dio = new Dio();

  // dio get网络请求,方式一（Future作为返回值）
  static Future dioGet1(String url, {Map<String, dynamic> params}) async {
    var response = await dio.get(WanApi.BaseUrl + url, queryParameters: params);
    return response.data;
  }

  // dio 网络请求,方式二（callback，errorCallback回调）
  static dioGet2(String url, Function callback,
      {Map<String, String> params,
      Map<String, String> headers,
      Function errorCallback}) async {
    // url组合
    url = WanApi.BaseUrl + url;
    print("dio:URL=" + url);
    print(
        "AppStatus.getString(Constants.Login) = ${AppStatus.getBool(Constants.loginSp)}");
    var response = await dio.get(url,
        queryParameters: params,
        options: Options(
            connectTimeout: 5000,
            receiveTimeout: 100000,
            headers: {
              Constants.cookieSp: AppStatus.getString(Constants.cookieSp)
            },
            contentType: ContentType.json,
            responseType: ResponseType.json));
    //todo 可以进一步判断错误码等等（此处默认返回数据）
    print("------------->response = ${response.request.headers}");
    callback(response.data);
  }

  static dioPost(String url, {Map<String, String> params}) async {
    url = WanApi.BaseUrl + url;
    //玩android的参数怎么是url拼接的呢，为啥不放在body中？
    if (params != null && params.length > 0) {
      StringBuffer sb = new StringBuffer();
      sb.write("?");
      params.forEach((key, value) {
        sb.write("$key=$value&");
      });
      // url + params
      url += sb.toString().substring(0, sb.toString().length - 1);
    }
    print('--------------------------url = $url');
    var response = await dio.post(url,
        options: Options(
            //baseUrl: WanApi.BaseUrl,
            connectTimeout: 5000,
            receiveTimeout: 100000,
            // 5s
            headers: {
              Constants.cookieSp: AppStatus.getString(Constants.cookieSp)??''
            },
            contentType: ContentType.json,
            responseType: ResponseType.json));

    print("------------POST:request.headers = " + response.request.headers.toString());

    //缓存cookie
    //登录后会在 cookie 中返回账号密码，只要在客户端做 cookie 持久化存储即可自动登录验证。
    if (url.contains(WanApi.LOGIN)) {
      AppStatus.putString(
          Constants.cookieSp, response.headers['set-cookie'].toString());
    }

    return response.data;
  }

  //-----------------------------http---------------------------------//
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

    //获取cookie
    String cookieSTR = AppStatus.getString(Constants.cookieSp);
    Map<String, String> headerMap = Map();
    headerMap[Constants.cookieSp] = cookieSTR;
    print("--------cookieSTR = $cookieSTR");

    var response = await http.get(url, headers: headerMap);
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

  //获取福利图
  static Future getMeiZi(String url, List<String> params, Function callback,
      {Function errorCallback}) async {
    url = GankIO.BaseUrl + url;
    print("url1 = $url");
    if (params == null || params.isEmpty) {
      print("参数不能为空！");
      return null;
    }

    StringBuffer sb = new StringBuffer();
    params.forEach((param) {
      sb.write("/$param");
    });
    url += sb.toString();
    print("url2 = $url");
    var response = await http.get(url);
    Map<String, dynamic> resMap = json.decode(response.body);
    bool error = resMap['error'];
    var data = resMap['results'];
    if (!error) {
      print("data = $data");
      callback(data);
    } else {
      errorCallback("出错啦");
    }
  }

  /// dio 网络请求getMeiZi [category:分类, page: 页数, count:每页的个数]
  static dioGetMeiZi(String category, int page, Function callback,
      {count = 20, Function errorCallback}) async {
    // url组合
    String url = GankIO.BaseUrl + category + "/$count/$page";
    print("dio:URL=" + url);
    var response = await dio.get(url);
    print("------------->response = $response.data");
    callback(response.data);
  }
}
