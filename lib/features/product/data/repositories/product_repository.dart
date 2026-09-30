import '../../../../core/config/app_config.dart';
import '../../../../core/services/api_exception.dart';
import '../../../../core/services/api_service.dart';
import '../models/product_model.dart';

class ProductRepository {
  final ApiService _api;

  ProductRepository(this._api);

  // ---------------------------------------------------------------
  // KONTRAK API
  //
  // GET /products?search=kata
  //   header: Authorization: Bearer <token>
  //   -> { "data": [ { id, name, sku, category, description, price, stock } ] }
  // ---------------------------------------------------------------

  Future<List<ProductModel>> getProducts({String search = ''}) async {
    if (AppConfig.useMock) return _mockProducts(search);

    final res = await _api.get(
      '/products',
      query: {if (search.isNotEmpty) 'search': search},
    );
    final list = res['data'] as List;
    return list
        .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  // --- MOCK (hapus saat backend sudah siap) ---
  static const _mockData = [
    ProductModel(
      id: '1', name: 'Beras Premium 5 Kg', sku: 'BRS-005', category: 'Sembako',
      description: 'Beras pulen kualitas premium, kemasan 5 kg.',
      price: 72000, stock: 120,
    ),
    ProductModel(
      id: '2', name: 'Minyak Goreng 2 L', sku: 'MNY-002', category: 'Sembako',
      description: 'Minyak goreng kelapa sawit, kemasan pouch 2 liter.',
      price: 38500, stock: 8,
    ),
    ProductModel(
      id: '3', name: 'Gula Pasir 1 Kg', sku: 'GUL-001', category: 'Sembako',
      description: 'Gula pasir putih bersih, kemasan 1 kg.',
      price: 17500, stock: 0,
    ),
    ProductModel(
      id: '4', name: 'Kopi Bubuk 200 g', sku: 'KPI-200', category: 'Minuman',
      description: 'Kopi bubuk robusta, aroma kuat.',
      price: 28000, stock: 45,
    ),
    ProductModel(
      id: '5', name: 'Teh Celup Isi 25', sku: 'TEH-025', category: 'Minuman',
      description: 'Teh celup melati, isi 25 kantong.',
      price: 12500, stock: 200,
    ),
    ProductModel(
      id: '6', name: 'Mie Instan Goreng', sku: 'MIE-001', category: 'Makanan',
      description: 'Mie instan goreng, per bungkus.',
      price: 3500, stock: 5,
    ),
    ProductModel(
      id: '7', name: 'Sabun Cuci Piring 800 ml', sku: 'SBN-800', category: 'Rumah Tangga',
      description: 'Sabun cuci piring cair, kemasan refill 800 ml.',
      price: 16000, stock: 64,
    ),
    ProductModel(
      id: '8', name: 'Detergen Bubuk 1 Kg', sku: 'DTG-001', category: 'Rumah Tangga',
      description: 'Detergen bubuk untuk mesin cuci dan cuci tangan.',
      price: 24000, stock: 30,
    ),
  ];

  Future<List<ProductModel>> _mockProducts(String search) async {
    await Future.delayed(const Duration(milliseconds: 800));

    // Untuk menguji tampilan error: ketik "error" di kolom pencarian
    if (search.toLowerCase() == 'error') {
      throw const ApiException('Tidak dapat terhubung ke server');
    }

    final q = search.toLowerCase();
    return _mockData
        .where((p) =>
            p.name.toLowerCase().contains(q) ||
            p.sku.toLowerCase().contains(q) ||
            p.category.toLowerCase().contains(q))
        .toList();
  }
}