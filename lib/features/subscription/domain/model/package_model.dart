class MockProduct {
  final String identifier;
  final String title;
  final String description;
  final double price;
  final String priceString;
  final String currencyCode;
  final String subscriptionPeriod; // e.g., 'P1M' for 1 month

  MockProduct({
    required this.identifier,
    required this.title,
    required this.description,
    required this.price,
    required this.priceString,
    required this.currencyCode,
    required this.subscriptionPeriod,
  });
}

class MockPackage {
  final String identifier; // e.g., 'monthly', 'annual'
  final String offeringIdentifier;
  final String packageType; // e.g., 'monthly', 'annual'
  final MockProduct product;

  MockPackage({
    required this.identifier,
    required this.offeringIdentifier,
    required this.packageType,
    required this.product,
  });
}
