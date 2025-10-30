import 'package:flutter/material.dart';
import 'package:perfumex/model/modelpr.dart';
import 'package:perfumex/features/auth/data/cart_data.dart';
import 'package:perfumex/features/cart/view/cart_page.dart';

class DetailsAddButton extends StatelessWidget {
  final Modelpr product;
  final int quantity;

  const DetailsAddButton({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          CartData.addToCart(product, quantity);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("تمت إضافة المنتج إلى السلة 🛒"),
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CartPage()),
          );
        },
        child: const Text(
          '+ Add to Cart',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
