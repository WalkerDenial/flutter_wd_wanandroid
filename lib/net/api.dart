import 'package:flutter_wd_wanandroid/net/http_mamager.dart';

typedef void OnResult(Map<String, dynamic> data);

class Api {
  static const baseUrl = "http://www.wanandroid.com/";

  static const String articleList = "article/list/";

  static const String banner = "banner/json";

  static getArticleList(int page) async {
    return HttpManager.getInstance().request('$articleList$page/json');
  }

  static getBanner() async {
    return await HttpManager.getInstance().request(banner);
  }
}
