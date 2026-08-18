import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/user_repository_impl.dart';
import '../../domain/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl();
});
