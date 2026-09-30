import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/router/route_names.dart';
import '../../shared/widgets/app_background.dart';
import '../../shared/widgets/app_top_bar.dart';
import '../auth/providers/auth_provider.dart';
import '../notification/providers/notification_provider.dart';
import '../../core/constants/app_colors.dart';
import '../../shared/widgets/app_bottom_bar.dart';
import 'nav_config.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
 
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final unread = context.watch<NotificationProvider>().unreadCount;

    // Saat logout, role sempat null sebentar sebelum router pindah ke Login
    final role = auth.role;
    if (role == null) return const SizedBox.shrink();

    final items = NavConfig.forRole(role);
    final location = GoRouterState.of(context).uri.path;

    var index = items.indexWhere((e) => location.startsWith(e.path));
    if (index < 0) {
      // Halaman menu Home (bukan tab): tandai tab Home sebagai aktif
      index = items.indexWhere((e) => e.path == Routes.home);
    }
    if (index < 0) index = 0;

       return Scaffold(
      // Putih, supaya area di balik sudut bottom bar tidak terlihat abu-abu
      backgroundColor: AppColors.surface,
      body: AppBackground(
        child: Column(
          children: [
            AppTopBar(
              name: auth.name,
              notificationCount: unread,
              onNotificationTap: () {
                if (location != Routes.notification) {
                  context.push(Routes.notification);
                }
              },
            ),
            Expanded(child: child),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomBar(
        selectedIndex: index,
        onDestinationSelected: (i) => context.go(items[i].path),
        destinations: [
          for (final item in items)
            NavigationDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.selectedIcon),
              label: item.label,
            ),
        ],
      ),
    );
  }
}