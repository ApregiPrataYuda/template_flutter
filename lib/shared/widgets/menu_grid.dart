import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_sizes.dart';
import 'menu_tile.dart';

/// Data satu menu: ikon, label, dan path tujuan.
class MenuItemData {
  final IconData icon;
  final String label;
  final String path;

  const MenuItemData(this.icon, this.label, this.path);
}

/// Grid 4 kolom dari daftar menu. Tekan menu = pindah ke path-nya.
class MenuGrid extends StatelessWidget {
  final List<MenuItemData> items;

  const MenuGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSizes.md,
      crossAxisSpacing: AppSizes.sm,
      childAspectRatio: 0.78,
      children: [
        for (final item in items)
          MenuTile(
            icon: item.icon,
            label: item.label,
            onTap: () => context.push(item.path),
          ),
      ],
    );
  }
}