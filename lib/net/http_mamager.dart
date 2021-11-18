import 'package:dio/dio.dart';
import 'package:flutter_wd_wanandroid/net/api.dart';

class HttpManager {
  Dio? _dio;
  static HttpManager? _instance;

  factory HttpManager.getInstance() {
    _instance ??= HttpManager._internal();
    return _instance!;
  }

  HttpManager._internal() {
    var options = BaseOptions(
        baseUrl: Api.baseUrl, connectTimeout: 50000, receiveTimeout: 30000);
    _dio = Dio(options);
  }

  request(url, {String method = "get"}) async {
    try {
      var option = Options(method: method);
      var response = await _dio!.request(url, options: option);
      return response.data;
    } catch (e) {
      return null;
    }
  }
}
