import 'dart:convert';
import '../models/user_profile_model.dart';
import '../services/user_profile_api_service.dart';

class UserProfileRepository {
  final UserProfileApiService apiService = UserProfileApiService();

  Future<UserProfileModel> fetchUser(int userId) async {
    final response = await apiService.getUser(userId);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return UserProfileModel.fromJson(json);
    }

    throw Exception('Failed to load user. Status code: ${response.statusCode}');
  }

  Future<UserProfileModel> updateUser(UserProfileModel user) async {
    final response = await apiService.updateUser(user.id, user.toJson());

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return UserProfileModel.fromJson(json);
    }

    throw Exception(
      'Failed to update user. Status code: ${response.statusCode}',
    );
  }
}
