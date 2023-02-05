import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final uri = Uri.parse(
    'https://bubbly-cause-fb4.notion.site/Class-c3284153a2074e9fa8423c193cba40bf');

class HomeScreen extends StatelessWidget {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(uri);

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                controller.loadRequest(uri);
              },
              icon: Icon(Icons.home))
        ],
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
