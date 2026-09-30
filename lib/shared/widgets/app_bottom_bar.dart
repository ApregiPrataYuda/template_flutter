import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

/// Bottom bar dengan sudut atas membulat + bayangan ke atas,
/// supaya terlihat terpisah dari konten (sesuai desain).
class AppBottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationDestination> destinations;

  const AppBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
  });

  static const _radius = BorderRadius.vertical(
    top: Radius.circular(AppSizes.radiusXl),
  );

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: _radius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, -4), // bayangan ke atas
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: _radius,
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          height: 72,
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          destinations: destinations,
        ),
      ),
    );
  }
}