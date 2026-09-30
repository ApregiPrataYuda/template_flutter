import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/router/route_names.dart';
import '../../core/theme/app_text_styles.dart';

class PageHeader extends StatelessWidget {
  final String title;

  /// Widget opsional di kanan judul, misalnya tombol aksi
  final Widget? trailing;

  const PageHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSizes.xs, AppSizes.sm, AppSizes.md, 0),
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
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.h3,
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}