import 'package:flutter/material.dart';
import 'package:perfumex/widget/favorit_data.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final favorites = FavoriteData.favoriteItems;

    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body:
          favorites.isEmpty
              ? const Center(child: Text("لا يوجد منتجات مفضلة"))
              : ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final product = favorites[index];
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
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            FavoriteData.removeFromFavorite(product);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
