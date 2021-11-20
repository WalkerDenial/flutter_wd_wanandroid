import 'package:banner_view/banner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wd_wanandroid/net/api.dart';

import 'article_item.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  var _controller = ScrollController();
  var _isLoading = true;
  var articles = [];
  var banners = [];
  var listTotalSize = 0;
  var curPage = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;

      if (maxScroll == pixels && articles.length < listTotalSize) {
        _getArticleList();
      }
    });
    _pullToRefresh();
  }

  _getArticleList([bool update = true]) async {
    var data = await Api.getArticleList(curPage);
    if (data != null) {
      var map = data['data'];
      var datas = map['datas'];

      listTotalSize = map['total'];

      if (curPage == 0) {
        articles.clear();
      }
      curPage++;
      articles.addAll(datas);
      if (update) setState(() {});
    }
  }

  _getBanner([bool update = true]) async {
    var data = await Api.getBanner();
    if (data != null) {
      banners.clear();
      banners.addAll(data['data']);
      if (update) setState(() {});
    }
  }

  Future<void> _pullToRefresh() async {
    curPage = 0;
    Iterable<Future> futures = [_getArticleList(), _getBanner()];
    await Future.wait(futures);
    _isLoading = false;
    setState(() {});
    return;
  }

  Widget? _bannerView() {
    var list = banners.map((item) {
      return Image.network(item['imagePath'], fit: BoxFit.cover);
    }).toList();
    return list.isNotEmpty
        ? BannerView(list, intervalDuration: const Duration(seconds: 3))
        : null;
  }

  Widget _buildItem(int i) {
    if (i == 0) {
      return SizedBox(
        height: 180.0,
        child: _bannerView(),
      );
    }
    var itemData = articles[i - 1];
    return ArticleItem(itemData);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Offstage(
          offstage: !_isLoading,
          child: const Center(child: CircularProgressIndicator()),
        ),
        Offstage(
          offstage: _isLoading,
          child: RefreshIndicator(
              child: ListView.builder(
                  itemCount: articles.length + 1,
                  itemBuilder: (context, i) => _buildItem(i),
                  controller: _controller),
              onRefresh: _pullToRefresh),
        )
      ],
    );
  }
}
