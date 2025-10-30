import 'package:flutter/material.dart';
import 'package:perfumex/features/auth/data/cart_data.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final BuildContext parentContext; // عشان نقدر نفتح Dialog من هنا

  const CustomAppBar({
    super.key,
    required this.title,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.black,
      actions: [
        IconButton(
          icon: const Icon(Icons.delete_forever, color: Colors.red),
          onPressed: () {
            if (CartData.cartItems.isNotEmpty) {
              showDialog(
                context: parentContext,
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
                          CartData.clearCart();
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
