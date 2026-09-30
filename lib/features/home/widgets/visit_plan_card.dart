import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/app_card.dart';

/// Kartu ringkasan dengan progress bar. Dipakai semua role.
class VisitPlanCard extends StatelessWidget {
  final String title;
  final String nextStop;
  final String summary;
  final double progress; // 0.0 sampai 1.0
  final String progressLabel;
  final IconData icon;

  const VisitPlanCard({
    super.key,
    this.title = 'Visit Plan',
    required this.nextStop,
    required this.summary,
    required this.progress,
    this.progressLabel = 'on target',
    this.icon = Icons.location_on,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();

    return AppCard(
      padding: const EdgeInsets.all(AppSizes.md),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.h3),
                const SizedBox(height: AppSizes.xs),
                Text(nextStop, style: AppTextStyles.caption),
                Text(summary, style: AppTextStyles.caption),
                const SizedBox(height: AppSizes.sm),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: AppColors.primarySoft,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: AppSizes.xs + 2),
                Text(
                  '$percent% $progressLabel',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.md),
          Container(
            height: 56,
            width: 56,
            decoration: const BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 30, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}