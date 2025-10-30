import 'package:flutter/material.dart';
import 'package:perfumex/features/cart/widget/cart_item_card.dart';
import 'package:perfumex/features/cart/widget/cart_total.dart';
import 'package:perfumex/features/auth/data/cart_data.dart';
import 'package:perfumex/features/cart/widget/custom_app_bar.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    CartData.loadCart().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "My Cart", parentContext: context),
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
                        return CartItemCard(
                          item: item,
                          onRemove: () => setState(() {}),
                        );
                      },
                    ),
          ),
          if (CartData.cartItems.isNotEmpty) const CartTotal(),
        ],
      ),
    );
  }
}
