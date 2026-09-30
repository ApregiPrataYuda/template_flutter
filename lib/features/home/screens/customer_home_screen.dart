import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/home_greeting.dart';
import '../../../shared/widgets/menu_grid.dart';
import '../../../shared/widgets/stat_card.dart';
import '../../../shared/widgets/stat_row.dart';
import '../widgets/visit_plan_card.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

    static const List<MenuItemData> _menus = [
    MenuItemData(Icons.request_quote_outlined, 'Inquiry', Routes.inquiry),
    MenuItemData(Icons.bookmark_border, 'Catalog', Routes.catalog),
    MenuItemData(Icons.receipt_long_outlined, 'Order History', Routes.orderHistory),
    MenuItemData(Icons.local_offer_outlined, 'Promo', Routes.promo),
    MenuItemData(Icons.support_agent, 'Contact', Routes.contact),
    MenuItemData(Icons.help_outline, 'Help', Routes.help),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSizes.md),
      children: [
        const HomeGreeting(title: 'Find what', accent: 'You Need'),
        const SizedBox(height: AppSizes.md),

        // Data dummy, diganti API nanti
        const VisitPlanCard(
          title: 'My Order',
          nextStop: 'Order #INV-0231 is on the way.',
          summary: 'Estimated arrival today at 15:00.',
          progress: 0.7,
          progressLabel: 'in delivery',
          icon: Icons.local_shipping_outlined,
        ),
        const SizedBox(height: AppSizes.md),

        const StatRow(
          cards: [
            StatCard(
              icon: Icons.local_shipping_outlined,
              value: '2',
              label: 'Active Order',
              caption: 'In progress',
            ),
            StatCard(
              icon: Icons.check,
              value: '14',
              label: 'Completed',
              caption: 'Total orders',
            ),
            StatCard(
              icon: Icons.local_offer_outlined,
              value: '3',
              label: 'Promo',
              caption: 'Available now',
            ),
          ],
        ),
        const SizedBox(height: AppSizes.lg),

        Text('All Menu',
            style: AppTextStyles.h3.copyWith(fontSize: AppSizes.font16)),
        const SizedBox(height: AppSizes.md),
        const MenuGrid(items: _menus),
      ],
    );
  }
}