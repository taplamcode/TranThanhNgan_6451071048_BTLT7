class PostModel {
  final int? id;
  final String title;
  final String body;
  final int userId;

  PostModel({
    this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: (json['id'] as num?)?.toInt(),
      title: (json['title'] ?? '').toString(),
      body: (json['body'] ?? '').toString(),
      userId: (json['userId'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'body': body, 'userId': userId};
  }
}
