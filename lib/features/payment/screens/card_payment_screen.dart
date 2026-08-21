import 'dart:developer' as developer;

import 'package:flutter/material.dart';

/// Minimal example screen showing the full card-payment flow end to end.
/// Swap the raw TextFields for a proper masked card-input widget in production.
class CardPaymentScreen extends StatefulWidget {
  final double? amount;
  const CardPaymentScreen({super.key, this.amount = 100});

  @override
  State<CardPaymentScreen> createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  final _cardNumberCtrl = TextEditingController();
  final _expMonthCtrl = TextEditingController();
  final _expYearCtrl = TextEditingController();
  final _cvcCtrl = TextEditingController();

  final bool _processing = false;
  String? _error;

  Future<void> _pay() async {
    // setState(() {
    //   _processing = true;
    //   _error = null;
    // });

    // try {
    //   // Step 1: create the intent through our backend.
    //   final intent = await PaymentService.instance.createPaymentIntent(
    //     amount: widget.amount!,
    //     method: 'card',
    //     description: 'Order payment',
    //   );

    //   // Step 2 + 3: tokenize with PayMongo directly, then attach via our backend.
    //   final result = await PaymentService.instance.payWithCard(
    //     intent: intent,
    //     card: CardDetails(
    //       cardNumber: _cardNumberCtrl.text.trim(),
    //       expMonth: int.parse(_expMonthCtrl.text.trim()),
    //       expYear: int.parse(_expYearCtrl.text.trim()),
    //       cvc: _cvcCtrl.text.trim(),
    //     ),
    //   );

    //   if (result.requiresAction && result.redirectUrl != null) {
    //     // Step 4: 3D Secure challenge required.

    //     final success = await Navigator.of(context).push<bool>(
    //       MaterialPageRoute(
    //         builder: (_) => PaymentWebviewScreen(
    //           checkoutUrl: result.redirectUrl!,
    //           successUrlPrefix: 'https://example.com/failed/success',
    //           failedUrlPrefix: 'https://example.com/failed',
    //         ),
    //       ),
    //     );
    //     _handleOutcome(success == true, intent.paymentIntentId);
    //   } else if (result.status == 'succeeded') {
    //     _handleOutcome(true, intent.paymentIntentId);
    //   } else {
    //     _handleOutcome(false, intent.paymentIntentId);
    //   }
    // } catch (e) {
    //   if (e is DioException) {
    //     developer.log('DIO ERROR STATUS: ${e.response?.statusCode}');
    //     developer.log('DIO ERROR BODY: ${e.response?.data}');
    //   }
    //   setState(() => _error = e.toString());
    // } finally {
    //   if (mounted) setState(() => _processing = false);
    // }
  }

  // Future<void> _handleOutcome(
  //     bool likelySuccess, String paymentIntentId) async {
  //   // Step 5: confirm with our backend rather than trusting the client alone -
  //   // the webhook is the real source of truth, but a status check here gives
  //   // instant UI feedback.
  //   final status = await PaymentService.instance.getStatus(paymentIntentId);
  //   if (!mounted) return;

  //   if (status == 'succeeded') {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Payment successful!')),
  //     );
  //     Navigator.of(context).pop(true);
  //   } else {
  //     setState(() => _error = 'Payment was not completed (status: $status)');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    developer.log("error: $_error");
    return Scaffold(
      appBar: AppBar(title: const Text('Pay with card')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _cardNumberCtrl,
              decoration: const InputDecoration(labelText: 'Card number'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _expMonthCtrl,
                    decoration: const InputDecoration(labelText: 'MM'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _expYearCtrl,
                    decoration: const InputDecoration(labelText: 'YYYY'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _cvcCtrl,
                    decoration: const InputDecoration(labelText: 'CVC'),
                    keyboardType: TextInputType.number,
                    obscureText: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: _processing ? null : _pay,
              child: _processing
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : Text('Pay ₱${widget.amount!.toStringAsFixed(2)}'),
            ),
          ],
        ),
      ),
    );
  }
}
