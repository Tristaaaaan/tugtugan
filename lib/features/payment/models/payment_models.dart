/// Result of creating a Payment Intent via our backend.
class PaymentIntentResult {
  final String paymentIntentId;
  final String clientKey;
  final String status;

  PaymentIntentResult({
    required this.paymentIntentId,
    required this.clientKey,
    required this.status,
  });

  factory PaymentIntentResult.fromJson(Map<String, dynamic> json) {
    return PaymentIntentResult(
      paymentIntentId: json['paymentIntentId'] as String,
      clientKey: json['clientKey'] as String,
      status: json['status'] as String,
    );
  }
}

/// Result of attaching a payment method (card or e-wallet) to a Payment Intent.
class PaymentAttachResult {
  final String status;
  final bool requiresAction;
  final String? redirectUrl;

  PaymentAttachResult({
    required this.status,
    required this.requiresAction,
    required this.redirectUrl,
  });

  factory PaymentAttachResult.fromJson(Map<String, dynamic> json) {
    return PaymentAttachResult(
      status: json['status'] as String,
      requiresAction: (json['requiresAction'] as bool?) ?? (json['redirectUrl'] != null),
      redirectUrl: json['redirectUrl'] as String?,
    );
  }
}

class BillingInfo {
  final String name;
  final String email;
  final String? phone;

  BillingInfo({required this.name, required this.email, this.phone});

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        if (phone != null) 'phone': phone,
      };
}

class CardDetails {
  final String cardNumber;
  final int expMonth;
  final int expYear;
  final String cvc;

  CardDetails({
    required this.cardNumber,
    required this.expMonth,
    required this.expYear,
    required this.cvc,
  });
}

enum EwalletType { gcash, grabPay, paymaya }

extension EwalletTypeApiValue on EwalletType {
  String get apiValue {
    switch (this) {
      case EwalletType.gcash:
        return 'gcash';
      case EwalletType.grabPay:
        return 'grab_pay';
      case EwalletType.paymaya:
        return 'paymaya';
    }
  }
}
