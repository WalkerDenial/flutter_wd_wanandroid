import 'package:flutter/material.dart';
import 'package:flutter_wd_wanandroid/pages/article_page.dart';

class ArticleApp extends StatelessWidget {
  const ArticleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('文章', style: TextStyle(color: Colors.white)),
        ),
        body: const ArticlePage(),
      ),
    );
  }
}
