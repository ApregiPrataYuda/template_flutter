import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../config/app_config.dart';
import 'api_exception.dart';
import 'storage_service.dart';

/// Client HTTP tunggal untuk seluruh app (setara instance Axios).
class ApiService {
  final StorageService _storage;
  late final Dio dio;

  /// Dipanggil saat server membalas 401 (token kedaluwarsa/tidak valid).
  VoidCallback? onUnauthorized;

  ApiService(this._storage) {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        // Tempel token otomatis di setiap request
        onRequest: (options, handler) async {
          final token = await _storage.readToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (e, handler) {
          final isLoginCall = e.requestOptions.path.contains('/auth/login');
          if (e.response?.statusCode == 401 && !isLoginCall) {
            onUnauthorized?.call();
          }
          handler.next(e);
        },
      ),
    );
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) =>
      _send(() => dio.get(path, queryParameters: query));

  Future<dynamic> post(String path, {Object? data}) =>
      _send(() => dio.post(path, data: data));

  Future<dynamic> put(String path, {Object? data}) =>
      _send(() => dio.put(path, data: data));

  Future<dynamic> delete(String path) => _send(() => dio.delete(path));

  Future<dynamic> _send(Future<Response<dynamic>> Function() call) async {
    try {
      final response = await call();
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}