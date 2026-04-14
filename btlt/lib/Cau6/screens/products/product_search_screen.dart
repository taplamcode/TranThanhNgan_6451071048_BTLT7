import 'dart:async';
import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../data/repository/product_search_repository.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  final ProductSearchRepository repository = ProductSearchRepository();
  final TextEditingController searchController = TextEditingController();

  List<ProductModel> products = [];
  bool isLoading = false;
  String? errorMessage;
  Timer? debounceTimer;

  @override
  void dispose() {
    debounceTimer?.cancel();
    searchController.dispose();
    super.dispose();
  }

  Future<void> onKeywordChanged(String value) async {
    debounceTimer?.cancel();

    debounceTimer = Timer(const Duration(milliseconds: 400), () {
      searchProducts(value.trim());
    });
  }

  Future<void> searchProducts(String keyword) async {
    if (keyword.isEmpty) {
      setState(() {
        products = [];
        errorMessage = null;
        isLoading = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await repository.searchProducts(keyword);

      if (!mounted) {
        return;
      }

      setState(() {
        products = result;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Products')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: onKeywordChanged,
              decoration: const InputDecoration(
                labelText: 'Nhap tu khoa tim kiem',
                hintText: 'Vi du: phone',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 12),
            if (isLoading) const LinearProgressIndicator(),
            if (errorMessage != null) ...[
              const SizedBox(height: 12),
              Text('Loi tim kiem: $errorMessage', textAlign: TextAlign.center),
            ],
            const SizedBox(height: 12),
            Expanded(
              child: products.isEmpty
                  ? const Center(child: Text('Nhap tu khoa de tim san pham'))
                  : ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final item = products[index];

                        return ListTile(
                          title: Text(item.title),
                          subtitle: Text(
                            'Price: \$${item.price.toStringAsFixed(2)}',
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
