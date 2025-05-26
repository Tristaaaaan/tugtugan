import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:tugtugan/config/app_config.dart';
import 'package:tugtugan/config/app_environments.dart';
import 'package:tugtugan/core/appthemes/app_themes.dart';
import 'package:tugtugan/features/authentication/auth_gate.dart';
import 'package:tugtugan/features/maps/maps.dart';
import 'package:tugtugan/firebase/prod/firebase_options.dart';

void main() async {
  AppConfig.setEnvironment(Flavors.development);

  await dotenv.load(fileName: '.env');

  String token = dotenv.env['MAPBOX_SECRET_TOKEN'] ?? '';

  MapboxOptions.setAccessToken(token);

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
          path: 'maps',
          builder: (BuildContext context, GoRouterState state) {
            final name = state.uri.queryParameters['name'] ?? 'Guest';
            return Maps(name: name);
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
      theme: theme,
      routerConfig: _router,
    );
  }
}
