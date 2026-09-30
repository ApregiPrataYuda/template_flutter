import 'package:flutter/material.dart';
import '../../../core/services/api_exception.dart';
import '../data/models/product_model.dart';
import '../data/repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository _repo;

  ProductProvider(this._repo);

  List<ProductModel> _items = [];
  bool _isLoading = false;
  String? _error;
  String _search = '';
  int _requestId = 0; // penanda request terbaru
  bool _disposed = false;

  List<ProductModel> get items => _items;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get search => _search;

  /// Ambil data. Kalau [search] diisi, kata pencarian ikut diperbarui.
  Future<void> load({String? search}) async {
    if (search != null) _search = search;

    final id = ++_requestId;
    _isLoading = true;
    _error = null;
    notifyListeners();

    List<ProductModel> result = [];
    String? error;

    try {
      result = await _repo.getProducts(search: _search);
    } on ApiException catch (e) {
      error = e.message;
    } catch (_) {
      error = 'Terjadi kesalahan tak terduga';
    }

    // Abaikan hasil request lama kalau sudah ada request yang lebih baru
    if (_disposed || id != _requestId) return;

    _items = result;
    _error = error;
    _isLoading = false;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}