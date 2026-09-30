import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/app_card.dart';
import '../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            child: const Icon(Icons.inventory_2_outlined, color: AppColors.primary),
          ),
          const SizedBox(width: AppSizes.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySemiBold,
                ),
                const SizedBox(height: 2),
                Text('${product.sku} • ${product.category}',
                    style: AppTextStyles.caption),
                const SizedBox(height: AppSizes.xs),
                Text(
                  Formatters.rupiah(product.price),
                  style: AppTextStyles.bodySemiBold
                      .copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.sm),
          StockBadge(stock: product.stock),
        ],
      ),
    );
  }
}

class StockBadge extends StatelessWidget {
  final int stock;

  const StockBadge({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final Color color;
    final String label;

    if (stock == 0) {
      color = AppColors.error;
      label = 'Habis';
    } else if (stock < 10) {
      color = AppColors.warning;
      label = 'Sisa $stock';
    } else {
      color = AppColors.success;
      label = 'Stok $stock';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: AppSizes.font11,
        ),
      ),
    );
  }
}