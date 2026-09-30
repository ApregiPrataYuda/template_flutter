import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/theme/app_text_styles.dart';
import 'app_card.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final String caption;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                child: Icon(icon, size: 18, color: AppColors.primary),
              ),
              const SizedBox(width: AppSizes.xs),
              Flexible(
                child: FittedBox(
                  child: Text(value, style: AppTextStyles.h2),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.sm),
          Text(
            label,
            style: AppTextStyles.bodySemiBold.copyWith(fontSize: AppSizes.font13),
          ),
          Text(caption, maxLines: 2, style: AppTextStyles.small),
        ],
      ),
    );
  }
}