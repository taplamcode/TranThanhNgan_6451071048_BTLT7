class ProductModel {
  final int id;
  final String title;
  final double price;

  ProductModel({required this.id, required this.title, required this.price});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: (json['title'] ?? '').toString(),
      price: (json['price'] as num?)?.toDouble() ?? 0,
    );
  }
}
