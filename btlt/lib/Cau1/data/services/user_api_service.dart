import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';

class UserApiService {
  Future<http.Response> getUsers() async {
    Uri url = Uri.parse('${AppConstants.baseUrl}/users');

    http.Response response = await http.get(
      url,
      headers: {'Accept': 'application/json'},
    );

    return response;
  }

  Future<http.Response> createUser(Map<String, dynamic> body) async {
    return await http.post(
      Uri.parse('${AppConstants.baseUrl}/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
  }

  Future<http.Response> updateUser(String id, Map<String, dynamic> body) async {
    return await http.put(
      Uri.parse('${AppConstants.baseUrl}/users/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
  }

  Future<http.Response> deleteUser(String id) async {
    return await http.delete(Uri.parse('${AppConstants.baseUrl}/users/$id'));
  }

  Future<http.Response> headUsers() async {
    return await http.head(Uri.parse('${AppConstants.baseUrl}/users'));
  }

  Future<http.Response> updateUserPut(
    String id,
    Map<String, dynamic> body,
  ) async {
    return await http.put(
      Uri.parse('${AppConstants.baseUrl}/users/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
  }

  Future<http.Response> patchUser(String id, Map<String, dynamic> body) async {
    return await http.patch(
      Uri.parse('${AppConstants.baseUrl}/users/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(body),
    );
  }
}
