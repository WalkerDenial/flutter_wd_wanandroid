import 'package:flutter/material.dart';

class ArticleItem extends StatelessWidget {
  final itemData;
  const ArticleItem(this.itemData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var author = Row(
      children: [
        Expanded(
            child: Text.rich(TextSpan(children: [
          const TextSpan(text: '作者'),
          TextSpan(
              text: itemData['author'],
              style: TextStyle(color: Theme.of(context).primaryColor))
        ]))),
        Text(itemData['niceDate'])
      ],
    );
    var title = Text(itemData['title'],
        style: const TextStyle(fontSize: 16.0, color: Colors.black),
        textAlign: TextAlign.start);

    var chapterName = Text(itemData['chapterName'],
        style: TextStyle(color: Theme.of(context).primaryColor));

    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.all(10.0), child: author),
        Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            child: title),
        Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
            child: chapterName)
      ],
    );
    return Card(
      elevation: 4.0,
      child: column,
    );
  }
}
