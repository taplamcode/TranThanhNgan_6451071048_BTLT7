import 'package:flutter/material.dart';
import '../../controllers/user_controller.dart';
import '../../data/models/user_model.dart';

class UserEditForm extends StatefulWidget {
  final UserModel user;
  final UserController controller;

  const UserEditForm({
    super.key,
    required this.user,
    required this.controller,
  });

  @override
  State<UserEditForm> createState() => _UserEditFormState();
}

class _UserEditFormState extends State<UserEditForm> {
  late TextEditingController nameController;
  late TextEditingController emailController;

  bool updateName = false;
  bool updateEmail = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
  }

  void submitPatch() {
    UserModel editedUser = UserModel(
      id: widget.user.id,
      name: nameController.text,
      email: emailController.text,
      createdAt: widget.user.createdAt,
    );

    widget.controller.updateUserPatch(
      user: editedUser,
      updateName: updateName,
      updateEmail: updateEmail,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit User (PATCH)'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            title: const Text('Update name'),
            value: updateName,
            onChanged: (value) {
              setState(() {
                updateName = value ?? false;
              });
            },
          ),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          CheckboxListTile(
            title: const Text('Update email'),
            value: updateEmail,
            onChanged: (value) {
              setState(() {
                updateEmail = value ?? false;
              });
            },
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: submitPatch,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
