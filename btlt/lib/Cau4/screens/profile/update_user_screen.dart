import 'package:flutter/material.dart';
import '../../data/models/user_profile_model.dart';
import '../../data/repository/user_profile_repository.dart';

class UpdateUserScreen extends StatefulWidget {
  const UpdateUserScreen({super.key});

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final UserProfileRepository repository = UserProfileRepository();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isLoading = true;
  bool isSubmitting = false;
  String? errorMessage;
  UserProfileModel? loadedUser;
  UserProfileModel? updatedUser;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> loadUserData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final user = await repository.fetchUser(1);

      if (!mounted) {
        return;
      }

      nameController.text = user.name;
      emailController.text = user.email;
      phoneController.text = user.phone;

      setState(() {
        loadedUser = user;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      if (!mounted) {
        return;
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> submitUpdate() async {
    if (loadedUser == null) {
      return;
    }

    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      final request = UserProfileModel(
        id: loadedUser!.id,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
      );

      final result = await repository.updateUser(request);

      if (!mounted) {
        return;
      }

      setState(() {
        updatedUser = result;
      });

      debugPrint(
        'PUT response => id: ${result.id}, name: ${result.name}, email: ${result.email}, phone: ${result.phone}',
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Update successfully')));
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Cap nhat that bai: $e')));
    } finally {
      if (!mounted) {
        return;
      }

      setState(() {
        isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Update User Info')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Khong the tai du lieu user: $errorMessage',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: loadUserData,
                  child: const Text('Thu lai'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Update User Info')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name khong duoc de trong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final email = value?.trim() ?? '';
                  if (email.isEmpty) {
                    return 'Email khong duoc de trong';
                  }
                  if (!email.contains('@')) {
                    return 'Email khong hop le';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Phone khong duoc de trong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: isSubmitting ? null : submitUpdate,
                child: isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Update User'),
              ),
              const SizedBox(height: 20),
              if (updatedUser != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Du lieu moi sau khi update:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('ID: ${updatedUser!.id}'),
                        Text('Name: ${updatedUser!.name}'),
                        Text('Email: ${updatedUser!.email}'),
                        Text('Phone: ${updatedUser!.phone}'),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
