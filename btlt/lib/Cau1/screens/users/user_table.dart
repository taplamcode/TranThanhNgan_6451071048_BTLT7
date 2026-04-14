import 'package:flutter/material.dart';
import '../../controllers/user_controller.dart';
import '../../data/models/user_model.dart';
import 'user_edit_form.dart';

class UserTable extends StatelessWidget {
  final List<UserModel> users;
  final UserController controller;

  const UserTable({super.key, required this.users, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('CreatedAt')),
          DataColumn(label: Text('Action Edit')),
          DataColumn(label: Text('Action Delete')),
        ],
        rows: users.map((user) {
          return DataRow(
            cells: [
              DataCell(Text(user.id.toString())),
              DataCell(Text(user.name)),
              DataCell(Text(user.email)),
              DataCell(Text(user.createdAt ?? '')),
              DataCell(
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    controller.deleteUser(user.id ?? '');
                  },
                ),
              ),
              DataCell(
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) =>
                          UserEditForm(user: user, controller: controller),
                    );
                  },
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
