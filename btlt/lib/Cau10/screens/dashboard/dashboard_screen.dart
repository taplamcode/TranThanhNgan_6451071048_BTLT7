import 'package:flutter/material.dart';
import '../../data/models/dashboard_models.dart';
import '../../data/repository/dashboard_repository.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardRepository repository = DashboardRepository();
  late Future<DashboardData> dashboardFuture;

  @override
  void initState() {
    super.initState();
    dashboardFuture = loadDashboard();
  }

  Future<DashboardData> loadDashboard() async {
    final results = await Future.wait<dynamic>([
      repository.fetchUser(),
      repository.fetchPost(),
      repository.fetchProduct(),
    ]);

    return DashboardData(
      user: results[0] as UserSummary,
      post: results[1] as PostSummary,
      product: results[2] as ProductSummary,
    );
  }

  void reloadDashboard() {
    setState(() {
      dashboardFuture = loadDashboard();
    });
  }

  Widget buildSection({required String title, required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Multi APIs'),
        actions: [
          IconButton(
            onPressed: reloadDashboard,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<DashboardData>(
        future: dashboardFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Khong the tai dashboard: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Khong co du lieu dashboard'));
          }

          final data = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildSection(
                  title: 'User',
                  children: [
                    Text('ID: ${data.user.id}'),
                    Text('Name: ${data.user.name}'),
                    Text('Email: ${data.user.email}'),
                  ],
                ),
                buildSection(
                  title: 'Post',
                  children: [
                    Text('ID: ${data.post.id}'),
                    Text('Title: ${data.post.title}'),
                    Text('Body: ${data.post.body}'),
                  ],
                ),
                buildSection(
                  title: 'Product',
                  children: [
                    Text('ID: ${data.product.id}'),
                    Text('Title: ${data.product.title}'),
                    Text('Price: \$${data.product.price.toStringAsFixed(2)}'),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
