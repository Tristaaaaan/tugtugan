import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/payment_models.dart';
import 'api_client.dart';

/// Handles the full PayMongo flow from the Flutter side:
///
/// 1. Ask OUR backend to create a Payment Intent (server holds the secret key).
/// 2a. CARD: create the Payment Method directly against PayMongo using the PUBLIC key
///     (this is the one PayMongo call allowed straight from the app - the public key
///     is designed to be embedded client-side, same idea as a Stripe publishable key).
///     Raw card numbers never touch our own backend.
/// 2b. E-WALLET: no card data involved, so our backend creates the Payment Method too.
/// 3. Ask OUR backend to attach the Payment Method to the Intent (secret key required).
/// 4. If a redirectUrl comes back (3DS or e-wallet checkout), open it in a WebView.
/// 5. Poll /status or listen for your own "payment confirmed" signal (ideally backed by
///    the webhook updating your database) before unlocking the purchased content.
class PaymentService {
  PaymentService._();
  static final PaymentService instance = PaymentService._();

  final Dio _backend = ApiClient.instance.dio;

  // Public key is safe to ship in the app binary - it can only create Payment Methods,
  // never move money or read account data. NEVER put the secret key here.
  static const String _paymongoPublicKey = '';

  final Dio _paymongoDirect = Dio(
    BaseOptions(
      baseUrl: 'https://api.paymongo.com/v1',
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$_paymongoPublicKey:'))}',
        'Content-Type': 'application/json',
      },
    ),
  );

  /// Step 1: create the Payment Intent through our backend.
  Future<PaymentIntentResult> createPaymentIntent({
    required double amount,
    required String method, // 'card' | 'gcash' | 'grab_pay' | 'paymaya'
    String? description,
  }) async {
    final response = await _backend.post('/payments/intent', data: {
      'amount': amount,
      'method': method,
      if (description != null) 'description': description,
    });
    return PaymentIntentResult.fromJson(response.data as Map<String, dynamic>);
  }

  /// Step 2a + 3: tokenize the card directly with PayMongo (public key), then have
  /// our backend attach it to the Payment Intent (secret key).
  Future<PaymentAttachResult> payWithCard({
    required PaymentIntentResult intent,
    required CardDetails card,
  }) async {
    final pmResponse = await _paymongoDirect.post('/payment_methods', data: {
      'data': {
        'attributes': {
          'type': 'card',
          'details': {
            'card_number': card.cardNumber,
            'exp_month': card.expMonth,
            'exp_year': card.expYear,
            'cvc': card.cvc,
          },
        },
      },
    });

    final paymentMethodId = pmResponse.data['data']['id'] as String;

    final attachResponse = await _backend.post('/payments/attach-card', data: {
      'paymentIntentId': intent.paymentIntentId,
      'paymentMethodId': paymentMethodId,
      'clientKey': intent.clientKey,
    });

    return PaymentAttachResult.fromJson(
        attachResponse.data as Map<String, dynamic>);
  }

  /// Step 2b + 3: e-wallets are handled entirely by our backend since no sensitive
  /// card data is involved - it creates the Payment Method AND attaches it in one call.
  Future<PaymentAttachResult> payWithEwallet({
    required PaymentIntentResult intent,
    required EwalletType method,
    required BillingInfo billing,
  }) async {
    final response = await _backend.post('/payments/ewallet', data: {
      'paymentIntentId': intent.paymentIntentId,
      'clientKey': intent.clientKey,
      'method': method.apiValue,
      'billing': billing.toJson(),
    });
    return PaymentAttachResult.fromJson(response.data as Map<String, dynamic>);
  }

  /// Step 5: poll the current status as a fallback/confirmation alongside your webhook.
  Future<String> getStatus(String paymentIntentId) async {
    final response = await _backend.get('/payments/$paymentIntentId/status');
    return response.data['status'] as String;
  }
}
