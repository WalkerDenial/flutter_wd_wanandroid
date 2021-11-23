import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  final data;
  const WebViewPage(this.data, {Key? key}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  var isLoad = true;
  late FlutterWebviewPlugin flutterWebviewPlugin;

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin = FlutterWebviewPlugin();
    flutterWebviewPlugin.onStateChanged.listen((event) {
      if (event.type == WebViewState.finishLoad) {
        setState(() {
          isLoad = false;
        });
      } else if (event.type == WebViewState.startLoad) {
        setState(() {
          isLoad = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    flutterWebviewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        appBar: AppBar(
          title: Text(widget.data['title']),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: LinearProgressIndicator(),
          ),
          bottomOpacity: isLoad ? 1.0 : 0.0,
        ),
        withLocalStorage: true,
        url: widget.data['url'],
        withJavascript: true);
  }
}
