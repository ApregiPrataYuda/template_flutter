import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/app_card.dart';
import '../data/models/notification_model.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel item;
  final VoidCallback? onTap;

  const NotificationTile({super.key, required this.item, this.onTap});

  /// Ikon dan warna per jenis notifikasi
  static (IconData, Color) _styleFor(NotificationType type) {
    return switch (type) {
      NotificationType.visit => (Icons.location_on_outlined, AppColors.primary),
      NotificationType.order => (Icons.receipt_long_outlined, AppColors.warning),
      NotificationType.approval => (Icons.fact_check_outlined, AppColors.successDark),
      NotificationType.promo => (Icons.local_offer_outlined, AppColors.error),
      NotificationType.system => (Icons.info_outline, AppColors.textSecondary),
    };
  }

  @override
  Widget build(BuildContext context) {
    final (icon, color) = _styleFor(item.type);

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSizes.sm + 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: AppSizes.sm + 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: item.isRead
                            ? AppTextStyles.bodyMedium
                            : AppTextStyles.bodySemiBold,
                      ),
                    ),
                    const SizedBox(width: AppSizes.sm),
                    Text(
                      Formatters.timeAgo(item.createdAt),
                      style: AppTextStyles.small,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  item.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption.copyWith(
                    color: item.isRead
                        ? AppColors.textSecondary
                        : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          // Titik hijau = belum dibaca
          if (!item.isRead)
            Padding(
              padding: const EdgeInsets.only(left: AppSizes.sm, top: 6),
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}