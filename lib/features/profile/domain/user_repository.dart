import '../../../core/appmodels/users.dart';

abstract class UserRepository {
  Future<UserData> getUserData(String userId);
}
