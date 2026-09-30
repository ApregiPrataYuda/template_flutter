import '../../../../core/config/app_config.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/services/api_service.dart';
import '../models/notification_model.dart';

class NotificationRepository {
  final ApiService _api;

  NotificationRepository(this._api);

  // ---------------------------------------------------------------
  // KONTRAK API
  //
  // GET  /notifications
  //   -> { "data": [ { id, title, body, type, is_read, created_at, route } ] }
  //   type: "visit" | "order" | "approval" | "promo" | "system"
  //
  // POST /notifications/{id}/read   -> { "message": "..." }
  // POST /notifications/read-all    -> { "message": "..." }
  // ---------------------------------------------------------------

  Future<List<NotificationModel>> getNotifications() async {
    if (AppConfig.useMock) return _mockGet();

    final res = await _api.get('/notifications');
    final list = res['data'] as List;
    return list
        .map((e) =>
            NotificationModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Future<void> markAsRead(String id) async {
    if (AppConfig.useMock) {
      _mockStore = [
        for (final n in _mockStore ?? <NotificationModel>[])
          n.id == id ? n.copyWith(isRead: true) : n,
      ];
      return;
    }
    await _api.post('/notifications/$id/read');
  }

  Future<void> markAllAsRead() async {
    if (AppConfig.useMock) {
      _mockStore = [
        for (final n in _mockStore ?? <NotificationModel>[])
          n.copyWith(isRead: true),
      ];
      return;
    }
    await _api.post('/notifications/read-all');
  }

  // --- MOCK (hapus saat backend sudah siap) ---
  // Disimpan di memori supaya status "sudah dibaca" tidak reset saat refresh
  List<NotificationModel>? _mockStore;

  Future<List<NotificationModel>> _mockGet() async {
    await Future.delayed(const Duration(milliseconds: 600));
    final now = DateTime.now();

    return _mockStore ??= [
      NotificationModel(
        id: '1',
        title: 'Visit reminder',
        body: 'Your visit to PT Sinar Abadi starts at 10:00.',
        type: NotificationType.visit,
        createdAt: now.subtract(const Duration(minutes: 5)),
        route: Routes.visit,
      ),
      NotificationModel(
        id: '2',
        title: 'Expense approved',
        body: 'Your fuel expense of Rp 150.000 has been approved.',
        type: NotificationType.approval,
        createdAt: now.subtract(const Duration(hours: 1)),
        route: Routes.expenses,
      ),
      NotificationModel(
        id: '3',
        title: 'New order',
        body: 'PT Maju Jaya placed order #SO-0418.',
        type: NotificationType.order,
        createdAt: now.subtract(const Duration(hours: 3)),
        isRead: true,
        route: Routes.order,
      ),
      NotificationModel(
        id: '4',
        title: 'New promo available',
        body: '10% discount for the Sembako category this week.',
        type: NotificationType.promo,
        createdAt: now.subtract(const Duration(days: 1)),
        isRead: true,
        route: Routes.catalog,
      ),
      NotificationModel(
        id: '5',
        title: 'App update',
        body: 'Version 1.1 is available with performance improvements.',
        type: NotificationType.system,
        createdAt: now.subtract(const Duration(days: 3)),
        isRead: true,
      ),
    ];
  }
}