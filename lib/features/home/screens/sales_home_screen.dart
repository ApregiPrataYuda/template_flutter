import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_text_styles.dart';
// import '../../../shared/widgets/home_greeting.dart';
import '../../../shared/widgets/menu_grid.dart';
import '../../../shared/widgets/stat_card.dart';
import '../../../shared/widgets/stat_row.dart';
import '../widgets/visit_plan_card.dart';

class SalesHomeScreen extends StatelessWidget {
  const SalesHomeScreen({super.key});

  static const List<MenuItemData> _menus = [
    MenuItemData(Icons.badge_outlined, 'Business Partner', Routes.businessPartner),
    MenuItemData(Icons.menu_book_outlined, 'Contact', Routes.contact),
    MenuItemData(Icons.checklist, 'Follow Up', Routes.followUp),
    MenuItemData(Icons.inventory_2_outlined, 'Product', Routes.product),
    MenuItemData(Icons.public, 'Population', Routes.population),
    MenuItemData(Icons.view_in_ar_outlined, 'Inventory', Routes.inventory),
    MenuItemData(Icons.account_balance_wallet_outlined, 'Expenses', Routes.expenses),
    MenuItemData(Icons.track_changes, 'Target Visit', Routes.targetVisit),
    MenuItemData(Icons.paid_outlined, 'Target Sales', Routes.targetSales),
    MenuItemData(Icons.bookmark_border, 'Catalog', Routes.catalog),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSizes.md),
      children: [
        // const HomeGreeting(title: 'Ready for', accent: "Today's Visits"),
        // const SizedBox(height: AppSizes.md),

        // Data dummy, diganti API nanti
        const VisitPlanCard(
          nextStop: 'Next stop: PT Sinar Abadi at 10:00.',
          summary: 'All 20 planned visits completed today.',
          progress: 1.0,
        ),
        const SizedBox(height: AppSizes.md),

        StatRow(
          cards: [
            StatCard(
              icon: Icons.calendar_today_outlined,
              value: '20',
              label: 'Visit Plan',
              caption: 'Scheduled today',
              onTap: () => context.go(Routes.visit),
            ),
            StatCard(
              icon: Icons.check,
              value: '12',
              label: 'Outstanding Progress',
              caption: 'Scheduled month',
              onTap: () => context.push(Routes.followUp),
            ),
            StatCard(
              icon: Icons.groups_outlined,
              value: '2/35',
              label: 'Market Coverage',
              caption: 'Lead & Customer',
              onTap: () => context.push(Routes.businessPartner),
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