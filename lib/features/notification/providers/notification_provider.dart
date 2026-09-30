import 'package:flutter/material.dart';
import '../../../core/services/api_exception.dart';
import '../data/models/notification_model.dart';
import '../data/repositories/notification_repository.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepository _repo;

  NotificationProvider(this._repo);

  List<NotificationModel> _items = [];
  bool _isLoading = false;
  String? _error;
  bool _loggedIn = false;
  int _requestId = 0;

  List<NotificationModel> get items => _items;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get unreadCount => _items.where((e) => !e.isRead).length;

  /// Dipanggil otomatis tiap status login berubah (lihat app.dart).
  /// Login  -> ambil notifikasi. Logout -> kosongkan.
  void onAuthChanged(bool loggedIn) {
    if (loggedIn == _loggedIn) return;
    _loggedIn = loggedIn;

    // Ditunda sebentar: fungsi ini dipanggil saat build,
    // dan notifyListeners tidak boleh jalan di tengah build.
    Future.microtask(() => loggedIn ? load() : clear());
  }

  Future<void> load() async {
    final id = ++_requestId;
    _isLoading = true;
    _error = null;
    notifyListeners();

    List<NotificationModel>? result;
    String? error;

    try {
      result = await _repo.getNotifications();
    } on ApiException catch (e) {
      error = e.message;
    } catch (_) {
      error = 'Something went wrong';
    }

    // Abaikan hasil lama kalau sudah ada request baru / sudah logout
    if (id != _requestId) return;

    if (result != null) _items = result; // kalau gagal, data lama tetap tampil
    _error = error;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> markAsRead(String id) async {
    final index = _items.indexWhere((e) => e.id == id);
    if (index < 0 || _items[index].isRead) return;

    // Update tampilan dulu (optimistic), baru kirim ke server
    _items = [..._items]..[index] = _items[index].copyWith(isRead: true);
    notifyListeners();

    try {
      await _repo.markAsRead(id);
    } catch (_) {
      // Abaikan: status akan tersinkron lagi saat refresh
    }
  }

  Future<void> markAllAsRead() async {
    if (unreadCount == 0) return;

    _items = [for (final n in _items) n.isRead ? n : n.copyWith(isRead: true)];
    notifyListeners();

    try {
      await _repo.markAllAsRead();
    } catch (_) {}
  }

  void clear() {
    _requestId++; // batalkan request yang masih berjalan
    _items = [];
    _error = null;
    _isLoading = false;
    notifyListeners();
  }
}