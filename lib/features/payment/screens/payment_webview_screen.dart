import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Opens the redirect URL returned by PayMongo (3D Secure challenge for cards,
/// or the GCash/GrabPay/Maya checkout page). Pops with `true` once the URL
/// navigates to your configured success/failed redirect endpoint.
class PaymentWebviewScreen extends StatefulWidget {
  final String checkoutUrl;
  final String
      successUrlPrefix; // must match PAYMENT_SUCCESS_REDIRECT_URL on the backend
  final String
      failedUrlPrefix; // must match PAYMENT_FAILED_REDIRECT_URL on the backend

  const PaymentWebviewScreen({
    super.key,
    required this.checkoutUrl,
    required this.successUrlPrefix,
    required this.failedUrlPrefix,
  });

  @override
  State<PaymentWebviewScreen> createState() => _PaymentWebviewScreenState();
}

class _PaymentWebviewScreenState extends State<PaymentWebviewScreen> {
  late final WebViewController _controller;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _loading = true),
          onPageFinished: (_) => setState(() => _loading = false),
          onNavigationRequest: (request) {
            if (request.url.startsWith(widget.successUrlPrefix)) {
              Navigator.of(context).pop(true);
              return NavigationDecision.prevent;
            }
            if (request.url.startsWith(widget.failedUrlPrefix)) {
              Navigator.of(context).pop(false);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete your payment')),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_loading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
