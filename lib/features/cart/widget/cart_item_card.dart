import 'package:flutter/material.dart';
import 'package:perfumex/model/modelpr.dart';
import 'package:perfumex/features/auth/data/cart_data.dart';

class CartItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onRemove;

  const CartItemCard({super.key, required this.item, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final Modelpr? product = item['product'] as Modelpr?;
    final int quantity = item['quantity'] ?? 1;

    if (product == null) return const SizedBox.shrink();

    final double price = double.tryParse(product.price) ?? 0;
    final double totalItemPrice = price * quantity;

    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Image.network(
          product.images.isNotEmpty
              ? product.images[0].src
              : "https://via.placeholder.com/100",
          width: 60,
          fit: BoxFit.cover,
        ),
        title: Text(product.name),
        subtitle: Text("العدد: $quantity"),
        trailing: Column(
          children: [
            const Text(
              "السعر",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Text(
              "\$${totalItemPrice.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("تأكيد المسح"),
                content: const Text("هل تريد فعلاً مسح هذا المنتج من السلة؟"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("إلغاء"),
                  ),
                  TextButton(
                    onPressed: () {
                      CartData.removeFromCart(product);
                      onRemove();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "مسح",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
