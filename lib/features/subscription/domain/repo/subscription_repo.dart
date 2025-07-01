import '../model/package_model.dart';

abstract class SubscriptionRepo {
  Future<List<MockPackage>> subscribe();
}
