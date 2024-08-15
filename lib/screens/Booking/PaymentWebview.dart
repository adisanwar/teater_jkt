import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  final String paymentUrl;

  const PaymentWebView({required this.paymentUrl, Key? key}) : super(key: key);

  @override
  State<PaymentWebView> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<PaymentWebView> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();

    String urlToLoad = widget.paymentUrl;
    print(urlToLoad);
print('hallo bisa atuh : ${urlToLoad}');
    // Ensure the URL has a scheme (http or https)
    if (!urlToLoad.startsWith('http://') && !urlToLoad.startsWith('https://')) {
      urlToLoad = 'https://$urlToLoad'; // Default to https if no scheme is provided
    }
    
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(urlToLoad), // Access the url using widget.url
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Halaman Pembayaran'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
