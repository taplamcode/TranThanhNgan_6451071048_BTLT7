import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';

class UserProfileApiService {
  Future<http.Response> getUser(int userId) async {
    final url = Uri.parse('${AppConstants.baseUrl}/users/$userId');

    return http.get(url, headers: {'Accept': 'application/json'});
  }

  Future<http.Response> updateUser(
    int userId,
    Map<String, dynamic> body,
  ) async {
    final url = Uri.parse('${AppConstants.baseUrl}/users/$userId');

    return http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(body),
    );
  }
}
