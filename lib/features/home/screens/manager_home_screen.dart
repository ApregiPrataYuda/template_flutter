import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/home_greeting.dart';
import '../../../shared/widgets/menu_grid.dart';
import '../../../shared/widgets/stat_card.dart';
import '../../../shared/widgets/stat_row.dart';
import '../widgets/visit_plan_card.dart';

class ManagerHomeScreen extends StatelessWidget {
  const ManagerHomeScreen({super.key});

  static const List<MenuItemData> _menus = [
    MenuItemData(Icons.groups_outlined, 'Sales Team', Routes.salesTeam),
    MenuItemData(Icons.map_outlined, 'Visit Monitor', Routes.visitMonitor),
    MenuItemData(Icons.fact_check_outlined, 'Approval', Routes.approval),
    MenuItemData(Icons.badge_outlined, 'Business Partner', Routes.businessPartner),
    MenuItemData(Icons.paid_outlined, 'Target Sales', Routes.targetSales),
    MenuItemData(Icons.account_balance_wallet_outlined, 'Expenses', Routes.expenses),
    MenuItemData(Icons.view_in_ar_outlined, 'Inventory', Routes.inventory),
    MenuItemData(Icons.inventory_2_outlined, 'Product', Routes.product),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSizes.md),
      children: [
        const HomeGreeting(title: 'Team overview', accent: "Today's Performance"),
        const SizedBox(height: AppSizes.md),

        // Data dummy, diganti API nanti
        const VisitPlanCard(
          title: 'Team Target',
          nextStop: 'Monthly sales target: Rp 1.200.000.000.',
          summary: 'Achievement so far, 9 days left this month.',
          progress: 0.78,
          progressLabel: 'achieved',
          icon: Icons.trending_up,
        ),
        const SizedBox(height: AppSizes.md),

        const StatRow(
          cards: [
            StatCard(
              icon: Icons.groups_outlined,
              value: '12',
              label: 'Sales Team',
              caption: 'Active members',
            ),
            StatCard(
              icon: Icons.location_on_outlined,
              value: '86',
              label: 'Visits',
              caption: 'Completed today',
            ),
            StatCard(
              icon: Icons.fact_check_outlined,
              value: '5',
              label: 'Approval',
              caption: 'Waiting review',
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