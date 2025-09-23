import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:perfumex/model/modelpr.dart';

class CartData {
  static List<Map<String, dynamic>> cartItems = [];

  static void addToCart(Modelpr product, int quantity) {
    final existingIndex = cartItems.indexWhere(
      (item) => item['product'].id == product.id,
    );

    if (existingIndex != -1) {
      cartItems[existingIndex]['quantity'] += quantity;
    } else {
      cartItems.add({"product": product, "quantity": quantity});
    }

    saveCart();
  }

  static void removeFromCart(Modelpr product) {
    cartItems.removeWhere((item) => item['product'].id == product.id);
    saveCart();
  }

  static void clearCart() {
    cartItems.clear();
    saveCart();
  }

  static double getTotalPrice() {
    return cartItems.fold(0, (total, item) {
      final product = item['product'] as Modelpr;
      final quantity = item['quantity'] as int;
      final price = double.tryParse(product.price) ?? 0;
      return total + (price * quantity);
    });
  }

  static Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();

    final cartJson =
        cartItems.map((item) {
          final product = item['product'] as Modelpr;
          final quantity = item['quantity'];

          return {
            "product": {
              "id": product.id,
              "name": product.name,
              "slug": product.slug,
              "permalink": product.permalink,
              "description": product.description,
              "short_description": product.shortDescription,
              "price": product.price,
              "regular_price": product.regularPrice,
              "sale_price": product.salePrice,
              "on_sale": product.onSale,
              "stock_status": product.stockStatus,
              "images":
                  product.images
                      .map(
                        (img) => {
                          "id": img.id,
                          "src": img.src,
                          "name": img.name,
                          "alt": img.alt,
                        },
                      )
                      .toList(),
              "categories":
                  product.categories
                      .map(
                        (cat) => {
                          "id": cat.id,
                          "name": cat.name,
                          "slug": cat.slug,
                        },
                      )
                      .toList(),
            },
            "quantity": quantity,
          };
        }).toList();

    prefs.setString("cart", jsonEncode(cartJson));
  }

  static Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString("cart");

    if (cartString != null) {
      final List decoded = jsonDecode(cartString);
      cartItems =
          decoded.map((item) {
            final productJson = item['product'];
            final product = Modelpr.fromJson(productJson);
            final quantity = item['quantity'];
            return {"product": product, "quantity": quantity};
          }).toList();
    }
  }
}
