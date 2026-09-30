import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/theme/app_text_styles.dart';

class AppTopBar extends StatelessWidget {
  final String name;
  final int notificationCount;
  final VoidCallback? onNotificationTap;

  const AppTopBar({
    super.key,
    required this.name,
    this.notificationCount = 0,
    this.onNotificationTap,
  });

  /// "Jimmy Tinambunan" -> "JT", "budi" -> "B"
  String get _initials {
    final parts =
        name.trim().split(' ').where((e) => e.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(AppSizes.radiusXl),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      // SafeArea di dalam kontainer: warna putih ikut menutup area status bar
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSizes.md,
            AppSizes.sm,
            AppSizes.md,
            AppSizes.md,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primary,
                child: Text(
                  _initials,
                  style: AppTextStyles.bodySemiBold
                      .copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(width: AppSizes.sm + 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Welcome back,', style: AppTextStyles.caption),
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySemiBold
                          .copyWith(fontSize: AppSizes.font16),
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.white,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onNotificationTap,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Badge(
                      isLabelVisible: notificationCount > 0,
                      label: Text('$notificationCount'),
                      backgroundColor: AppColors.warning,
                      textColor: Colors.white,
                      child: const Icon(
                        Icons.notifications_none,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}