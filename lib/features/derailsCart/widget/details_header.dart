import 'package:flutter/material.dart';
import 'package:perfumex/features/auth/data/favorit_data.dart';
import 'package:perfumex/model/modelpr.dart';

class DetailsHeader extends StatelessWidget {
  final Modelpr product;

  const DetailsHeader({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, size: 32, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        ValueListenableBuilder<List<Modelpr>>(
          valueListenable: FavoriteData.favoriteItemsNotifier,
          builder: (context, favorites, _) {
            final isFavorite = FavoriteData.isFavorite(product);

            return IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 30,
                color: Colors.red,
              ),
              onPressed: () {
                if (isFavorite) {
                  FavoriteData.removeFromFavorite(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("تمت الإزالة من المفضلة ❌"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  FavoriteData.addToFavorite(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("تمت الإضافة إلى المفضلة ❤️"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
