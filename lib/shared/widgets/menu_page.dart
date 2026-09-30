import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/router/route_names.dart';
import '../../core/theme/app_text_styles.dart';

/// Halaman sementara untuk menu yang belum dibuat.
/// Tampil di dalam MainLayout, jadi top bar dan bottom bar tetap ada.
class MenuPage extends StatelessWidget {
  final String title;

  const MenuPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSizes.xs,
            AppSizes.sm,
            AppSizes.md,
            0,
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go(Routes.home);
                  }
                },
              ),
              Text(title, style: AppTextStyles.h3),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Text('Halaman $title', style: AppTextStyles.bodyLarge),
          ),
        ),
      ],
    );
  }
}