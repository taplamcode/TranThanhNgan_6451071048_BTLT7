class UserProfileModel {
  final int id;
  final String name;
  final String email;
  final String phone;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: (json['name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'phone': phone};
  }
}
