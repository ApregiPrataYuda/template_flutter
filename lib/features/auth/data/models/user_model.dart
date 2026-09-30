import '../../../../core/constants/user_role.dart';

enum UserStatus {
  active,
  inactive,
  unknown;

  static UserStatus fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'active':
        return UserStatus.active;
      case 'inactive':
        return UserStatus.inactive;
      default:
        return UserStatus.unknown;
    }
  }

  String get label {
    switch (this) {
      case UserStatus.active:
        return 'Active';
      case UserStatus.inactive:
        return 'Inactive';
      case UserStatus.unknown:
        return '-';
    }
  }
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String? company;
  final String? division;
  final DateTime? joinDate;
  final UserStatus status;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.company,
    this.division,
    this.joinDate,
    this.status = UserStatus.unknown,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: (json['name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      role: UserRole.fromString((json['role'] ?? '').toString()),
      company: json['company']?.toString(),
      division: json['division']?.toString(),
      joinDate: DateTime.tryParse((json['join_date'] ?? '').toString()),
      status: UserStatus.fromString(json['status']?.toString()),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'role': role.name,
        'company': company,
        'division': division,
        'join_date': joinDate?.toIso8601String(),
        'status': status.name,
      };
}