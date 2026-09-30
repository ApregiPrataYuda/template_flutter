enum NotificationType {
  visit,
  order,
  approval,
  promo,
  system;

  static NotificationType fromString(String? value) {
    return NotificationType.values.firstWhere(
      (e) => e.name == value?.toLowerCase(),
      orElse: () => NotificationType.system,
    );
  }
}

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final NotificationType type;
  final DateTime createdAt;
  final bool isRead;

  /// Halaman tujuan saat notifikasi ditekan (boleh kosong)
  final String? route;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.createdAt,
    this.isRead = false,
    this.route,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'].toString(),
      title: (json['title'] ?? '').toString(),
      body: (json['body'] ?? '').toString(),
      type: NotificationType.fromString(json['type']?.toString()),
      createdAt: DateTime.tryParse((json['created_at'] ?? '').toString()) ??
          DateTime.now(),
      isRead: json['is_read'] == true || json['is_read'] == 1,
      route: json['route']?.toString(),
    );
  }

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      body: body,
      type: type,
      createdAt: createdAt,
      isRead: isRead ?? this.isRead,
      route: route,
    );
  }
}