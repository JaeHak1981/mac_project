import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final homeUrl = Uri.parse(
    'https://bubbly-cause-fb4.notion.site/Class-c3284153a2074e9fa8423c193cba40bf');

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(
        'https://bubbly-cause-fb4.notion.site/Class-c3284153a2074e9fa8423c193cba40bf'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Baduk Calss',
          style: TextStyle(fontSize: 40),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (controller != null) {
                controller.loadRequest(Uri.parse(
                    'https://bubbly-cause-fb4.notion.site/Class-c3284153a2074e9fa8423c193cba40bf'));
              }
            },
            icon: const Icon(Icons.home),
          )
        ],
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
