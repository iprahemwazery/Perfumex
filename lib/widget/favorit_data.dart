import 'package:perfumex/model/modelpr.dart';

class FavoriteData {
  static List<Modelpr> favoriteItems = [];

  static void addToFavorite(Modelpr product) {
    if (!favoriteItems.any((item) => item.id == product.id)) {
      favoriteItems.add(product);
    }
  }

  static void removeFromFavorite(Modelpr product) {
    favoriteItems.removeWhere((item) => item.id == product.id);
  }

  static bool isFavorite(Modelpr product) {
    return favoriteItems.any((item) => item.id == product.id);
  }
}
