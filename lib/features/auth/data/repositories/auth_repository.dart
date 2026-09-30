import 'dart:convert';
import '../../../../core/config/app_config.dart';
import '../../../../core/constants/user_role.dart';
import '../../../../core/services/api_exception.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/services/storage_service.dart';
import '../models/user_model.dart';

class AuthRepository {
  final ApiService _api;
  final StorageService _storage;

  AuthRepository({required ApiService api, required StorageService storage})
      : _api = api,
        _storage = storage;

  // ---------------------------------------------------------------
  // KONTRAK API (acuan untuk membuat backend)
  //
  // POST /auth/login     body: { email, password }
  //   -> { "data": { "token": "...", "user": { id, name, email, role } } }
  //
  // POST /auth/register  body: { name, email, password }
  //   -> { "message": "..." }
  //
  // GET  /auth/me        header: Authorization: Bearer <token>
  //   -> { "data": { id, name, email, role } }
  //
  // POST /auth/logout    header: Authorization: Bearer <token>
  //   -> { "message": "..." }
  //
  // Error: HTTP 4xx dengan body { "message": "teks untuk ditampilkan" }
  // role bernilai: "manager" | "sales" | "customer"
  // ---------------------------------------------------------------

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final Map<String, dynamic> data;

    if (AppConfig.useMock) {
      data = await _mockLogin(email, password);
    } else {
      final res = await _api.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      data = Map<String, dynamic>.from(res['data'] as Map);
    }

    final user = UserModel.fromJson(Map<String, dynamic>.from(data['user']));
    await _storage.saveToken(data['token'].toString());
    await _storage.saveUserJson(jsonEncode(user.toJson()));
    return user;
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    if (AppConfig.useMock) {
      await Future.delayed(const Duration(seconds: 1));
      return;
    }
    await _api.post(
      '/auth/register',
      data: {'name': name, 'email': email, 'password': password},
    );
  }

  /// Dipanggil saat app dibuka: kalau token masih ada, langsung masuk.
  Future<UserModel?> restoreSession() async {
    final token = await _storage.readToken();
    if (token == null) return null;

    final cachedJson = await _storage.readUserJson();
    final UserModel? cached = cachedJson == null
        ? null
        : UserModel.fromJson(jsonDecode(cachedJson) as Map<String, dynamic>);

    if (AppConfig.useMock) return cached;

    try {
      final res = await _api.get('/auth/me');
      final user =
          UserModel.fromJson(Map<String, dynamic>.from(res['data'] as Map));
      await _storage.saveUserJson(jsonEncode(user.toJson()));
      return user;
    } on ApiException catch (e) {
      if (e.statusCode == 401) {
        await _storage.clear(); // token sudah tidak valid
        return null;
      }
      return cached; // gagal karena jaringan: pakai data tersimpan
    }
  }

  Future<void> logout() async {
    if (!AppConfig.useMock) {
      try {
        await _api.post('/auth/logout');
      } catch (_) {
        // abaikan: yang penting data lokal dibersihkan
      }
    }
    await clearSession();
  }

  Future<void> clearSession() => _storage.clear();

    Future<Map<String, dynamic>> _mockLogin(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (password != '123456') {
      throw const ApiException('Email atau password salah', statusCode: 401);
    }

    final lower = email.toLowerCase();
    final UserRole role;
    final String division;

    if (lower.contains('manager')) {
      role = UserRole.manager;
      division = 'Sales Management';
    } else if (lower.contains('customer')) {
      role = UserRole.customer;
      division = 'Purchasing';
    } else {
      role = UserRole.sales;
      division = 'Field Sales';
    }

    return {
      'token': 'mock-token',
      'user': {
        'id': '1',
        'name': email.split('@').first,
        'email': email,
        'role': role.name,
        'company': 'PT Sinar Abadi',
        'division': division,
        'join_date': '2023-01-12',
        'status': 'active',
      },
    };
  }
  
}