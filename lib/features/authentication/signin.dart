import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tugtugan/commons/widgets/loading_state_notifier.dart';
import 'package:tugtugan/commons/widgets/regular_button.dart';
import 'package:tugtugan/core/apptext/app_text.dart';
import 'package:tugtugan/features/authentication/auth_services.dart';

class SigninPage extends ConsumerWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text.rich(
                      TextSpan(
                        text: "Welcome to ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        children: const [
                          TextSpan(
                            text: "Suri",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
                RegularButton(
                  text: AppText.google,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  textColor: Theme.of(context).colorScheme.primary,
                  buttonKey: "signinwithgoogle",
                  onTap: () async {
                    final signInNotifier =
                        ref.read(regularButtonLoadingProvider.notifier);

                    signInNotifier.setLoading("signinwithgoogle", true);
                    await ref
                        .read(authServicesProvider)
                        .signInWithGoogle(ref, context);

                    signInNotifier.setLoading("signinwithgoogle", false);
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
