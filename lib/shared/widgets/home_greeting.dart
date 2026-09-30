import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/theme/app_text_styles.dart';

/// Tanggal hari ini + judul dua baris (tebal, lalu serif italic).
class HomeGreeting extends StatelessWidget {
  final String title;
  final String accent;

  const HomeGreeting({super.key, required this.title, required this.accent});

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  String get _today {
    final d = DateTime.now();
    return 'Today, ${d.day} ${_months[d.month - 1]} ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _today,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
        ),
        const SizedBox(height: AppSizes.sm),
        Text(title, style: AppTextStyles.h1),
        Text(
          accent,
          style: GoogleFonts.playfairDisplay(
            fontSize: AppSizes.font32,
            fontStyle: FontStyle.italic,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}