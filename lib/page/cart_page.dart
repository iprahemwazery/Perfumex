import 'package:flutter/material.dart';
import 'package:perfumex/model/modelpr.dart';
import 'package:perfumex/page/cart_data.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    CartData.loadCart().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              if (CartData.cartItems.isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("تأكيد المسح"),
                      content: const Text("هل تريد مسح كل المنتجات من السلة؟"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("إلغاء"),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              CartData.clearCart();
                            });
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "مسح الكل",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child:
                CartData.cartItems.isEmpty
                    ? const Center(child: Text("Cart is empty"))
                    : ListView.builder(
                      itemCount: CartData.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = CartData.cartItems[index];
                        final Modelpr? product = item['product'] as Modelpr?;
                        final int quantity = item['quantity'] ?? 1;

                        if (product == null) {
                          return const SizedBox.shrink();
                        }

                        final double price =
                            double.tryParse(product.price) ?? 0;
                        final double totalItemPrice = price * quantity;

                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: Image.network(
                              (product.images.isNotEmpty)
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
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                    content: const Text(
                                      "هل تريد فعلاً مسح هذا المنتج من السلة؟",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed:
                                            () => Navigator.of(context).pop(),
                                        child: const Text("إلغاء"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            CartData.removeFromCart(product);
                                          });
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
                      },
                    ),
          ),
          if (CartData.cartItems.isNotEmpty)
            SafeArea(
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.black12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${CartData.getTotalPrice().toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
