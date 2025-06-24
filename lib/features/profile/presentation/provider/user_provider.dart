import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tugtugan/features/profile/data/user_repository_impl.dart';
import 'package:tugtugan/features/profile/domain/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl();
});
