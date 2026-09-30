import 'package:go_router/go_router.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/main_layout/main_layout.dart';
import '../../features/product/screens/product_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../shared/widgets/menu_page.dart';
import '../../shared/widgets/placeholder_screen.dart';
import '../../features/notification/screens/notification_screen.dart';
import 'route_names.dart';

class AppRouter {
  AppRouter._();

  // Menu yang halamannya belum dibuat (masih placeholder).
  // Kalau fiturnya jadi, pindahkan ke route sendiri seperti Product.
  static const Map<String, String> _menuPages = {
    Routes.businessPartner: 'Business Partner',
    Routes.contact: 'Contact',
    Routes.followUp: 'Follow Up',
    Routes.population: 'Population',
    Routes.inventory: 'Inventory',
    Routes.expenses: 'Expenses',
    Routes.targetVisit: 'Target Visit',
    Routes.targetSales: 'Target Sales',
    Routes.catalog: 'Catalog',


    Routes.salesTeam: 'Sales Team',
    Routes.visitMonitor: 'Visit Monitor',
    Routes.approval: 'Approval',
    Routes.orderHistory: 'Order History',
    Routes.promo: 'Promo',
    Routes.help: 'Help',
    Routes.inquiry: 'Inquiry',
  };


  

  static GoRouter create(AuthProvider auth) {
    return GoRouter(
      initialLocation: Routes.login,
      refreshListenable: auth,
      redirect: (context, state) {
        final loggedIn = auth.isLoggedIn;
        final path = state.uri.path;
        final onAuthPage = path == Routes.login || path == Routes.register;

        if (!loggedIn && !onAuthPage) return Routes.login;
        if (loggedIn && onAuthPage) return Routes.home;
        return null;
      },
      routes: [
        GoRoute(
          path: Routes.login,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: Routes.register,
          builder: (context, state) => const RegisterScreen(),
        ),

        ShellRoute(
          builder: (context, state, child) => MainLayout(child: child),
          routes: [
            GoRoute(
              path: Routes.visit,
              builder: (c, s) => const PlaceholderScreen(title: 'Visit'),
            ),
            GoRoute(
              path: Routes.order,
              builder: (c, s) => const PlaceholderScreen(title: 'Order'),
            ),
            GoRoute(
              path: Routes.home,
              builder: (c, s) => const HomeScreen(),
            ),
            GoRoute(
              path: Routes.report,
              builder: (c, s) => const PlaceholderScreen(title: 'Report'),
            ),
            GoRoute(
              path: Routes.profile,
              builder: (c, s) => const ProfileScreen(),
            ),

            // Fitur yang sudah jadi
            GoRoute(
              path: Routes.product,
              builder: (c, s) => const ProductScreen(),
            ),

                        GoRoute(
              path: Routes.notification,
              builder: (c, s) => const NotificationScreen(),
            ),

            // Fitur yang masih placeholder
            for (final entry in _menuPages.entries)
              GoRoute(
                path: entry.key,
                builder: (c, s) => MenuPage(title: entry.value),
              ),
          ],
        ),
      ],
    );
  }
}