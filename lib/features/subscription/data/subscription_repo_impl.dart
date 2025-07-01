import 'dart:io';

import 'package:purchases_flutter/purchases_flutter.dart';

import '../domain/model/package_model.dart';
import '../domain/repo/subscription_repo.dart';

class SubscriptionRepoImpl extends SubscriptionRepo {
  @override
  Future<List<MockPackage>> subscribe() async {
    final MockProduct mockProduct = MockProduct(
      identifier: 'com.app.subscription.monthly',
      title: 'Monthly Plan',
      description: 'Access all features monthly.',
      price: 4.99,
      priceString: '\$4.99',
      currencyCode: 'USD',
      subscriptionPeriod: 'P1M',
    );

    final MockPackage mockPackage = MockPackage(
      identifier: 'monthly_mock',
      offeringIdentifier: 'default',
      packageType: 'monthly',
      product: mockProduct,
    );

    return [mockPackage];
  }
}

//TO DO: add the entitlement ID from the RevenueCat dashboard that is activated upon successful in-app purchase for the duration of the purchase.
const entitlementID = 'Basic';

//TO DO: add your subscription terms and conditions
const footerText =
    """Don't forget to add your subscription terms and conditions. 

Read more about this here: https://www.revenuecat.com/blog/schedule-2-section-3-8-b""";

//TO DO: add the Apple API key for your app from the RevenueCat dashboard: https://app.revenuecat.com
const appleApiKey = 'appl_api_key';

//TO DO: add the Google API key for your app from the RevenueCat dashboard: https://app.revenuecat.com
const googleApiKey = '';

//TO DO: add the Amazon API key for your app from the RevenueCat dashboard: https://app.revenuecat.com
const amazonApiKey = 'amazon_api_key';

class StoreConfig {
  final Store store;
  final String apiKey;
  static StoreConfig? _instance;

  factory StoreConfig({required Store store, required String apiKey}) {
    _instance ??= StoreConfig._internal(store, apiKey);
    return _instance!;
  }

  StoreConfig._internal(this.store, this.apiKey);

  static StoreConfig get instance {
    if (_instance == null) {
      throw Exception('StoreConfig has not been initialized.');
    }
    return _instance!;
  }

  static bool isForAppleStore() => instance.store == Store.appStore;
  static bool isForGooglePlay() => instance.store == Store.playStore;
  static bool isForAmazonAppstore() => instance.store == Store.amazon;
}

Future<void> initPlatformState() async {
  await Purchases.setLogLevel(LogLevel.debug);

  if (Platform.isIOS || Platform.isMacOS) {
    StoreConfig(store: Store.appStore, apiKey: appleApiKey);
  } else if (Platform.isAndroid) {
    const useAmazon = bool.fromEnvironment("amazon");
    StoreConfig(
      store: useAmazon ? Store.amazon : Store.playStore,
      apiKey: useAmazon ? amazonApiKey : googleApiKey,
    );
  } else {
    throw UnsupportedError('Unsupported platform');
  }

  await _configureSDK();
}

Future<void> _configureSDK() async {
  PurchasesConfiguration configuration;

  if (StoreConfig.isForAmazonAppstore()) {
    configuration = AmazonConfiguration(StoreConfig.instance.apiKey);
  } else {
    configuration = PurchasesConfiguration(StoreConfig.instance.apiKey);
  }

  configuration
    ..appUserID = null
    ..purchasesAreCompletedBy = const PurchasesAreCompletedByRevenueCat();

  await Purchases.configure(configuration);
}
