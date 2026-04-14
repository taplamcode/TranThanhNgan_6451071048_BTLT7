import 'package:flutter/material.dart';
import '../data/models/user_model.dart';
import '../data/repository/user_repository.dart';

class UserController extends ChangeNotifier {
  final UserRepository repository = UserRepository();

  List<UserModel> users = [];
  bool isLoading = false;

  Future<void> loadUsers() async {
    isLoading = true;
    notifyListeners();

    users = await repository.fetchUsers();

    isLoading = false;
    notifyListeners();
  }

  Future<void> createUser(UserModel user) async {
    await repository.addUser(user);
    await loadUsers();
  }

  /// Form edit đầy đủ → PUT
  Future<void> updateUserPut(UserModel user) async {
    await repository.editUserPut(user);
    await loadUsers();
  }

  Future<void> updateUserPatch({
    required UserModel user,
    required bool updateName,
    required bool updateEmail,
  }) async {
    Map<String, dynamic> patchBody = user.toPatchJson(
      updateName: updateName,
      updateEmail: updateEmail,
    );

    if (patchBody.isEmpty) {
      return;
    }

    await repository.editUserPatch(
      id: user.id!,
      body: patchBody,
    );

    await loadUsers();
  }

  Future<void> deleteUser(String id) async {
    users.removeWhere((user) => user.id == id);
    notifyListeners();

    await repository.removeUser(id);
  }

}
