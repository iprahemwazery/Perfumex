import 'package:flutter/material.dart';
import 'package:perfumex/model/modelpr.dart';

class FavoriteData {
  // ValueNotifier للقائمة لتحديث الواجهة تلقائيًا
  static final ValueNotifier<List<Modelpr>> favoriteItemsNotifier =
      ValueNotifier([]);

  static List<Modelpr> get favoriteItems => favoriteItemsNotifier.value;

  static void addToFavorite(Modelpr product) {
    if (!favoriteItems.any((item) => item.id == product.id)) {
      favoriteItemsNotifier.value = [...favoriteItems, product];
    }
  }

  static void removeFromFavorite(Modelpr product) {
    favoriteItemsNotifier.value =
        favoriteItems.where((item) => item.id != product.id).toList();
  }

  static bool isFavorite(Modelpr product) {
    return favoriteItems.any((item) => item.id == product.id);
  }
}
