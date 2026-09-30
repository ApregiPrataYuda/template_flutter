import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/user_role.dart';
import '../../auth/providers/auth_provider.dart';
import 'customer_home_screen.dart';
import 'manager_home_screen.dart';
import 'sales_home_screen.dart';

/// Memilih tampilan Home sesuai role user.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final role = context.watch<AuthProvider>().role;

    switch (role) {
      case UserRole.sales:
        return const SalesHomeScreen();
      case UserRole.manager:
        return const ManagerHomeScreen();
      case UserRole.customer:
        return const CustomerHomeScreen();
      case null:
        return const SizedBox.shrink();
    }
  }
}