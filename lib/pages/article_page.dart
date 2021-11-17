import 'package:flutter/material.dart';

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
  }

  void _getArticleList([bool udpate = true]) async {
    // var data = await Api.
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
