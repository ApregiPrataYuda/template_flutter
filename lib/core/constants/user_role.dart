enum UserRole {
  manager,
  sales,
  customer;

  /// Mengubah string dari backend menjadi enum.
  /// Contoh: UserRole.fromString('manager') -> UserRole.manager
  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (role) => role.name == value.toLowerCase(),
      orElse: () => UserRole.customer,
    );
  }

  /// Label untuk ditampilkan di UI.
  String get label {
    switch (this) {
      case UserRole.manager:
        return 'Manager';
      case UserRole.sales:
        return 'Sales';
      case UserRole.customer:
        return 'Customer';
    }
  }
}