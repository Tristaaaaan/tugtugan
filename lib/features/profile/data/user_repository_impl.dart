import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/appmodels/users.dart';
import '../domain/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserData> getUserData(String userId) async {
    try {
      final DocumentSnapshot snapshot =
          await _firestore.collection("users").doc(userId).get();

      if (!snapshot.exists || snapshot.data() == null) {
        throw Exception('User not found');
      }

      final data = snapshot.data() as Map<String, dynamic>;
      return UserData.fromJson(data);
    } catch (e) {
      throw Exception('Failed to fetch user data: $e');
    }
  }
}
