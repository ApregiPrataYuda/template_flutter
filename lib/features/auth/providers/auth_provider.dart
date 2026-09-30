import 'package:flutter/material.dart';
import '../../../core/constants/user_role.dart';
import '../../../core/services/api_exception.dart';
import '../data/models/user_model.dart';
import '../data/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repo;

  AuthProvider(this._repo);

  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoggedIn => _user != null;
  bool get isLoading => _isLoading;
  UserRole? get role => _user?.role;
  String get name => _user?.name ?? '';
  String? get errorMessage => _errorMessage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Dipanggil sekali di main() sebelum app tampil (auto-login).
  Future<void> init() async {
    _user = await _repo.restoreSession();
    notifyListeners();
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _errorMessage = null;
    _setLoading(true);

    try {
      _user = await _repo.login(email: email, password: password);
      _isLoading = false;
      notifyListeners(); // router membaca ini lalu pindah ke Home
      return true;
    } on ApiException catch (e) {
      _errorMessage = e.message;
      _setLoading(false);
      return false;
    } catch (_) {
      _errorMessage = 'Terjadi kesalahan tak terduga';
      _setLoading(false);
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _errorMessage = null;
    _setLoading(true);

    try {
      await _repo.register(name: name, email: email, password: password);
      _setLoading(false);
      return true;
    } on ApiException catch (e) {
      _errorMessage = e.message;
      _setLoading(false);
      return false;
    } catch (_) {
      _errorMessage = 'Terjadi kesalahan tak terduga';
      _setLoading(false);
      return false;
    }
  }

  Future<void> logout() async {
    final done = _repo.logout(); // token dipakai dulu untuk request logout
    _user = null;
    _errorMessage = null;
    notifyListeners();
    await done;
  }

  /// Dipanggil ApiService saat server membalas 401.
  Future<void> handleUnauthorized() async {
    if (_user == null) return;
    await _repo.clearSession();
    _user = null;
    notifyListeners();
  }
}