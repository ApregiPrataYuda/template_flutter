import 'package:dio/dio.dart';

/// Semua error dari API diubah jadi satu tipe ini,
/// supaya screen/provider cukup menampilkan `message`.
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, {this.statusCode});

  factory ApiException.fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiException('Koneksi timeout, coba lagi');
      case DioExceptionType.connectionError:
        return const ApiException('Tidak dapat terhubung ke server');
      default:
        break;
    }

    final data = e.response?.data;
    final serverMessage =
        data is Map && data['message'] != null ? data['message'].toString() : null;

    return ApiException(
      serverMessage ?? 'Terjadi kesalahan pada server',
      statusCode: e.response?.statusCode,
    );
  }

  @override
  String toString() => message;
}