import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Central Dio client used by every service that talks to OUR backend
/// (never to PayMongo directly for anything requiring the secret key).
///
/// Every request automatically carries the current Firebase user's ID token
/// as `Authorization: Bearer <token>`, and refreshes it transparently when
/// it's close to expiry.
class ApiClient {
  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            // forceRefresh: false lets the SDK reuse a cached token until ~5 min before expiry.
            final token = await user.getIdToken(false);
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          // If the backend says the token is invalid/expired, force one refresh and retry once.
          if (error.response?.statusCode == 401) {
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              try {
                final freshToken = await user.getIdToken(true);
                final retryRequest = error.requestOptions;
                retryRequest.headers['Authorization'] = 'Bearer $freshToken';
                final response = await _dio.fetch(retryRequest);
                return handler.resolve(response);
              } catch (_) {
                // fall through to original error if refresh/retry also fails
              }
            }
          }
          handler.next(error);
        },
      ),
    );
  }

  static final ApiClient instance = ApiClient._internal();

  late final Dio _dio;

  Dio get dio => _dio;

  // when testing against a local server from the Android emulator.
  static const String baseUrl = 'http://10.0.2.2:4242/api';
}
