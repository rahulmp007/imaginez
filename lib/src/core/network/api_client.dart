import 'dart:developer';

import 'package:dio/dio.dart';

class ApiClient {
  static ApiClient? _singleton;
  late final Dio _dio;

  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Logging Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // log('➡️ [REQUEST]');
          log('URL: ${options.uri}');
          // log('Method: ${options.method}');
          // log('Headers: ${options.headers}');
          // log('Data: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // log('✅ [RESPONSE]');
          // log('Status Code: ${response.statusCode}');
          // log('Data: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          log('❌ [ERROR]');
          log('Message: ${error.message}');
          log('Response: ${error.response}');
          return handler.next(error);
        },
      ),
    );
  }

  factory ApiClient() => _singleton ??= ApiClient._internal();

  // Store cancel tokens to cancel later if needed
  final Map<String, CancelToken> _cancelTokens = {};

  /// GET with optional cancel token
  Future<Map<String, dynamic>> get({
    required String url,
    String? requestId,
  }) async {
    // final cancelToken = _createCancelToken(requestId);
    try {
      final response = await _dio.get(url);

      log('response : $response');
      log('response : ${response.statusCode}');
      log('response : ${response.statusMessage}');

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  /// POST with optional cancel token
  Future<Map<String, dynamic>> post({
    required String url,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
    String? requestId,
  }) async {
    // final cancelToken = _createCancelToken(requestId);
    try {
      final response = await _dio.post(
        url,
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  /// PUT with optional cancel token
  Future<Map<String, dynamic>> put({
    required String url,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
    String? requestId,
  }) async {
    // final cancelToken = _createCancelToken(requestId);
    try {
      final response = await _dio.put(
        url,
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  /// Cancel a specific request
  void cancelRequest(String requestId) {
    if (_cancelTokens.containsKey(requestId)) {
      _cancelTokens[requestId]?.cancel(
        'Request [$requestId] cancelled by user.',
      );
      _cancelTokens.remove(requestId);
    }
  }

  /// Cancel all active requests
  void cancelAllRequests() {
    for (final token in _cancelTokens.values) {
      token.cancel('All requests cancelled by user.');
    }
    _cancelTokens.clear();
  }

  /// Helper: create & store CancelToken
  CancelToken _createCancelToken(String? requestId) {
    final token = CancelToken();
    if (requestId != null) {
      _cancelTokens[requestId] = token;
    }
    return token;
  }

  /// Dispose Singleton
  void dispose() {
    _singleton = null;
  }
}
