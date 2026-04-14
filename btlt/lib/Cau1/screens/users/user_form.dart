import 'package:flutter/material.dart';
import '../../controllers/user_controller.dart';
import '../../data/models/user_model.dart';

class UserForm extends StatefulWidget {
  final UserController controller;

  const UserForm({super.key, required this.controller});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController createdAtController = TextEditingController();

  void submit() {
    UserModel user = UserModel(
      name: nameController.text,
      email: emailController.text,
      createdAt: createdAtController.text,
    );

    widget.controller.createUser(user);

    nameController.clear();
    emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: createdAtController,
            decoration: const InputDecoration(labelText: 'CreateAt',hintText: '2026-01-25T20:44:29.482Z'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: submit,
            child: const Text('Add User'),
          ),
        ],
      ),
    );
  }
}
