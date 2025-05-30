import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tugtugan/features/authentication/signin.dart';
import 'package:tugtugan/features/navigation/presentation/gate.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateAsync = ref.watch(authStateProvider);

    final user = authStateAsync.value;

    return Scaffold(
      body: user != null ? const NavigationGate() : const SigninPage(),
    );
  }
}
