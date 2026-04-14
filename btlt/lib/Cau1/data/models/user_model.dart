class UserModel {
  String? id;
  String name;
  String email;
  String? phone;
  String? createdAt;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    this.phone,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString(),
      name: (json['name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phone: json['phone']?.toString(),
      createdAt: json['createdAt']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{'name': name, 'email': email};

    if (phone != null && phone!.isNotEmpty) {
      data['phone'] = phone;
    }

    if (createdAt != null && createdAt!.isNotEmpty) {
      data['createdAt'] = createdAt;
    }

    return data;
  }

  /// dùng cho PATCH
  Map<String, dynamic> toPatchJson({
    bool updateName = false,
    bool updateEmail = false,
  }) {
    Map<String, dynamic> data = {};

    if (updateName) {
      data['name'] = name;
    }
    if (updateEmail) {
      data['email'] = email;
    }

    return data;
  }
}
