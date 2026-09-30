import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/info_row.dart';
import '../../../shared/widgets/status_badge.dart';
import '../../auth/data/models/user_model.dart';
import '../../auth/providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  String _initials(String name) {
    final parts = name.trim().split(' ').where((e) => e.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  Color _statusColor(UserStatus status) {
    switch (status) {
      case UserStatus.active:
        return AppColors.success;
      case UserStatus.inactive:
        return AppColors.error;
      case UserStatus.unknown:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    if (user == null) return const SizedBox.shrink();

    return ListView(
      padding: const EdgeInsets.all(AppSizes.md),
      children: [
        // Header: avatar, nama, role, status
        AppCard(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    _initials(user.name),
                    style: AppTextStyles.h2.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(height: AppSizes.md),
                Text(user.name, style: AppTextStyles.h3),
                const SizedBox(height: AppSizes.xs),
                Text(user.email, style: AppTextStyles.caption),
                const SizedBox(height: AppSizes.md),
                Wrap(
                  spacing: AppSizes.sm,
                  children: [
                    StatusBadge(
                      label: user.role.label,
                      color: AppColors.primary,
                    ),
                    StatusBadge(
                      label: user.status.label,
                      color: _statusColor(user.status),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSizes.md),

        // Detail
        AppCard(
          child: Column(
            children: [
              InfoRow(
                icon: Icons.business_outlined,
                label: 'Company',
                value: user.company ?? '-',
              ),
              const Divider(height: 1, color: AppColors.border),
              InfoRow(
                icon: Icons.account_tree_outlined,
                label: 'Division',
                value: user.division ?? '-',
              ),
              const Divider(height: 1, color: AppColors.border),
              InfoRow(
                icon: Icons.calendar_month_outlined,
                label: 'Join Date',
                value: user.joinDate == null
                    ? '-'
                    : Formatters.date(user.joinDate!),
              ),
              const Divider(height: 1, color: AppColors.border),
              InfoRow(
                icon: Icons.verified_user_outlined,
                label: 'Status',
                value: user.status.label,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.lg),

        AppButton(
          label: 'Logout',
          icon: Icons.logout,
          isOutlined: true,
          onPressed: () => context.read<AuthProvider>().logout(),
        ),
      ],
    );
  }
}