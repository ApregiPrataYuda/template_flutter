class ProductModel {
  final String id;
  final String name;
  final String sku;
  final String category;
  final String description;
  final double price;
  final int stock;

  const ProductModel({
    required this.id,
    required this.name,
    required this.sku,
    required this.category,
    required this.description,
    required this.price,
    required this.stock,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      name: (json['name'] ?? '').toString(),
      sku: (json['sku'] ?? '').toString(),
      category: (json['category'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      // toString dulu: sebagian backend mengirim angka desimal sebagai teks
      price: double.tryParse(json['price'].toString()) ?? 0,
      stock: int.tryParse(json['stock'].toString()) ?? 0,
    );
  }
}