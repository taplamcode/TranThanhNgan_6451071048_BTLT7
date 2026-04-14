import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';

class PostApiService {
  Future<http.Response> createPost(Map<String, dynamic> body) async {
    final url = Uri.parse('${AppConstants.baseUrl}/posts');

    return http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(body),
    );
  }
}
