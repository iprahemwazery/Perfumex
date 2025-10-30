import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  final int categoryId;
  final String title;

  const ProductsPage({
    super.key,
    required this.categoryId,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text("Products for category ID: $categoryId")),
    );
  }
}
