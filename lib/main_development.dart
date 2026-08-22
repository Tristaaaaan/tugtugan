import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'config/app_config.dart';
import 'config/app_environments.dart';
import 'core/appthemes/app_themes.dart';
import 'features/appointments/presentation/screen/appointment_screen.dart';
import 'features/authentication/auth_gate.dart';
import 'features/chat/presentation/chat_screen.dart';
import 'features/home/presentation/home.dart';
import 'features/inbox/presentation/screen/inbox.dart';
import 'features/maps/presentation/maps.dart';
import 'features/navigation/presentation/gate.dart';
import 'features/payment/screens/card_payment_screen.dart';
import 'features/profile/presentation/screen/profile.dart';
import 'features/studios/presentation/screen/studio_screen.dart';
import 'firebase/prod/firebase_options.dart';

void main() async {
  AppConfig.setEnvironment(Flavors.development);

  await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "tugtugan-dev",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MainApp()));
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthGate();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'studio',
          builder: (context, state) {
            final studioId = state.uri.queryParameters['studioId'] ?? '';
            return Studio(studioId: studioId);
          },
        ),
        ShellRoute(
          builder: (context, state, child) {
            return const NavigationGate();
          },
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) {
                return const HomePage();
              },
            ),
            GoRoute(
              path: '/search-studio',
              builder: (context, state) {
                return const InboxPage();
              },
            ),
            GoRoute(
              path: '/appointments',
              builder: (BuildContext context, GoRouterState state) {
                return const AppointmentScreen();
              },
            ),
            GoRoute(
              path: '/inbox',
              builder: (BuildContext context, GoRouterState state) {
                return const InboxPage();
              },
            ),
            GoRoute(
              path: '/profile',
              builder: (BuildContext context, GoRouterState state) {
                return const ProfilePage();
              },
            ),
          ],
        ),
        GoRoute(
          path: 'chat',
          builder: (BuildContext context, GoRouterState state) {
            final studioId = state.uri.queryParameters['studioId'] ?? '';

            return ChatPage(
              studioId: studioId,
            );
          },
        ),
        GoRoute(
          path: 'booking-payment',
          builder: (context, state) => const CardPaymentScreen(),
        ),
        GoRoute(
          path: 'maps',
          builder: (BuildContext context, GoRouterState state) {
            final name = state.uri.queryParameters['name'] ?? 'Guest';
            final double longitude =
                double.tryParse(state.uri.queryParameters['longitude'] ?? '') ??
                    0.0;
            final double latitude =
                double.tryParse(state.uri.queryParameters['latitude'] ?? '') ??
                    0.0;

            return Maps(
              name: name,
              longitude: longitude,
              latitude: latitude,
            );
          },
        ),
      ],
    ),
  ],
);

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(themeNotifierProvider);

    final theme = ref.read(themeNotifierProvider.notifier).currentTheme;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: _router,
    );
  }
}
