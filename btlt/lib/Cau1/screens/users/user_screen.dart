import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../../data/repository/user_repository.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final UserRepository repository = UserRepository();
  late Future<List<UserModel>> usersFuture;

  @override
  void initState() {
    super.initState();
    usersFuture = repository.fetchUsers();
  }

  void reloadUsers() {
    setState(() {
      usersFuture = repository.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách người dùng'),
        actions: [
          IconButton(onPressed: reloadUsers, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: FutureBuilder<List<UserModel>>(
        future: usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Khong the tai du lieu: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final users = snapshot.data ?? [];

          if (users.isEmpty) {
            return const Center(child: Text('Khong co user nao'));
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(user.name),
                subtitle: Text('${user.email}\n${user.phone ?? ''}'),
                isThreeLine: true,
              );
            },
          );
        },
      ),
    );
  }
}
