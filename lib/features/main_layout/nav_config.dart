import 'package:flutter/material.dart';
import '../../core/constants/user_role.dart';
import '../../core/router/route_names.dart';

class NavItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final String path;

  const NavItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.path,
  });
}

class NavConfig {
  NavConfig._();

  static const _home = NavItem(
    label: 'Home',
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
    path: Routes.home,
  );
  static const _profile = NavItem(
    label: 'Profile',
    icon: Icons.person_outline,
    selectedIcon: Icons.person,
    path: Routes.profile,
  );

  static List<NavItem> forRole(UserRole role) {
    switch (role) {
      case UserRole.sales:
        return const [
          NavItem(
            label: 'Visit',
            icon: Icons.location_on_outlined,
            selectedIcon: Icons.location_on,
            path: Routes.visit,
          ),
          NavItem(
            label: 'Order',
            icon: Icons.receipt_long_outlined,
            selectedIcon: Icons.receipt_long,
            path: Routes.order,
          ),
          _home,
          NavItem(
            label: 'Report',
            icon: Icons.bar_chart_outlined,
            selectedIcon: Icons.bar_chart,
            path: Routes.report,
          ),
          _profile,
        ];
      case UserRole.manager:
        return const [
          _home,
          NavItem(
            label: 'Report',
            icon: Icons.bar_chart_outlined,
            selectedIcon: Icons.bar_chart,
            path: Routes.report,
          ),
          _profile,
        ];
      case UserRole.customer:
        return const [
          _home,
          NavItem(
            label: 'Order',
            icon: Icons.receipt_long_outlined,
            selectedIcon: Icons.receipt_long,
            path: Routes.order,
          ),
          _profile,
        ];
    }
  }
}