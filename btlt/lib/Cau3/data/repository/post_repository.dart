import 'dart:convert';
import '../models/post_model.dart';
import '../services/post_api_service.dart';

class PostRepository {
  final PostApiService apiService = PostApiService();

  Future<PostModel> createPost(PostModel post) async {
    final response = await apiService.createPost(post.toJson());

    if (response.statusCode == 201 || response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return PostModel.fromJson(json);
    }

    throw Exception(
      'Failed to create post. Status code: ${response.statusCode}',
    );
  }
}
