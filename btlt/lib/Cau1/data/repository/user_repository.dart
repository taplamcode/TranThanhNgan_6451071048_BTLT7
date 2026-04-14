import 'dart:convert';
import '../models/user_model.dart';
import '../services/user_api_service.dart';

class UserRepository {
  final UserApiService apiService = UserApiService();

  Future<List<UserModel>> fetchUsers() async {
    final response = await apiService.getUsers();

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);

      List<UserModel> users = [];

      for (var item in jsonList) {
        users.add(UserModel.fromJson(item));
      }

      return users;
    } else {
      throw Exception(
        'Failed to load users. Status code: ${response.statusCode}',
      );
    }
  }

  Future<void> addUser(UserModel user) async {
    await apiService.createUser(user.toJson());
  }

  Future<void> editUserPut(UserModel user) async {
    await apiService.updateUser(user.id ?? '', user.toJson());
  }

  Future<void> editUserPatch({
    required String id,
    required Map<String, dynamic> body,
  }) async {
    await apiService.patchUser(id, body);
  }

  Future<void> removeUser(String id) async {
    await apiService.deleteUser(id);
  }
}
