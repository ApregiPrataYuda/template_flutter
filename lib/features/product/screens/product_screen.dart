import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/services/api_service.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/page_header.dart';
import '../../../shared/widgets/state_views.dart';
import '../data/models/product_model.dart';
import '../data/repositories/product_repository.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider dibuat di sini, jadi hanya hidup selama halaman ini terbuka
    return ChangeNotifierProvider(
      create: (ctx) =>
          ProductProvider(ProductRepository(ctx.read<ApiService>()))..load(),
      child: const _ProductView(),
    );
  }
}

class _ProductView extends StatefulWidget {
  const _ProductView();

  @override
  State<_ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<_ProductView> {
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  // Tunggu 400 ms setelah berhenti mengetik, baru cari
  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      context.read<ProductProvider>().load(search: value.trim());
    });
  }

  void _showDetail(ProductModel p) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusLg),
        ),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSizes.lg, 0, AppSizes.lg, AppSizes.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(p.name, style: AppTextStyles.h3),
            const SizedBox(height: AppSizes.xs),
            Text('${p.sku} • ${p.category}', style: AppTextStyles.caption),
            const SizedBox(height: AppSizes.md),
            Row(
              children: [
                Text(
                  Formatters.rupiah(p.price),
                  style: AppTextStyles.h2.copyWith(color: AppColors.primary),
                ),
                const Spacer(),
                StockBadge(stock: p.stock),
              ],
            ),
            const SizedBox(height: AppSizes.md),
            Text(p.description, style: AppTextStyles.body),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(ProductProvider provider) {
    if (provider.isLoading && provider.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.error != null) {
      return ErrorState(
        message: provider.error!,
        onRetry: () => provider.load(),
      );
    }
    if (provider.items.isEmpty) {
      return EmptyState(
        message: provider.search.isEmpty
            ? 'Belum ada produk'
            : 'Produk "${provider.search}" tidak ditemukan',
        icon: Icons.search_off,
      );
    }

    return RefreshIndicator(
      onRefresh: () => provider.load(),
      child: ListView.separated(
        padding: const EdgeInsets.all(AppSizes.md),
        itemCount: provider.items.length,
        separatorBuilder: (_, _) => const SizedBox(height: AppSizes.sm),
        itemBuilder: (context, i) {
          final product = provider.items[i];
          return ProductCard(product: product, onTap: () => _showDetail(product));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageHeader(title: 'Product'),
        Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSizes.md, AppSizes.sm, AppSizes.md, 0),
          child: TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              hintText: 'Cari nama, SKU, atau kategori',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        // Garis loading tipis saat memuat ulang di atas data yang sudah ada
        SizedBox(
          height: 3,
          child: provider.isLoading && provider.items.isNotEmpty
              ? const LinearProgressIndicator()
              : null,
        ),
        Expanded(child: _buildBody(provider)),
      ],
    );
  }
}