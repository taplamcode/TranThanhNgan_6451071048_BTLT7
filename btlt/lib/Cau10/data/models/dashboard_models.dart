class UserSummary {
  final int id;
  final String name;
  final String email;

  UserSummary({required this.id, required this.name, required this.email});

  factory UserSummary.fromJson(Map<String, dynamic> json) {
    return UserSummary(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: (json['name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
    );
  }
}

class PostSummary {
  final int id;
  final String title;
  final String body;

  PostSummary({required this.id, required this.title, required this.body});

  factory PostSummary.fromJson(Map<String, dynamic> json) {
    return PostSummary(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: (json['title'] ?? '').toString(),
      body: (json['body'] ?? '').toString(),
    );
  }
}

class ProductSummary {
  final int id;
  final String title;
  final double price;

  ProductSummary({required this.id, required this.title, required this.price});

  factory ProductSummary.fromJson(Map<String, dynamic> json) {
    return ProductSummary(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: (json['title'] ?? '').toString(),
      price: (json['price'] as num?)?.toDouble() ?? 0,
    );
  }
}

class DashboardData {
  final UserSummary user;
  final PostSummary post;
  final ProductSummary product;

  DashboardData({
    required this.user,
    required this.post,
    required this.product,
  });
}
