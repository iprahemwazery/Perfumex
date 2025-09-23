class Modelpr {
  final int id;
  final String name;
  final String slug;
  final String permalink;
  final String description;
  final String shortDescription;
  final String price;
  final String regularPrice;
  final String salePrice;
  final bool onSale;
  final String stockStatus;
  final List<ProductImage> images;
  final List<ProductCategory> categories;

  Modelpr({
    required this.id,
    required this.name,
    required this.slug,
    required this.permalink,
    required this.description,
    required this.shortDescription,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.onSale,
    required this.stockStatus,
    required this.images,
    required this.categories,
  });

  factory Modelpr.fromJson(Map<String, dynamic> json) {
    return Modelpr(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      slug: json['slug'] ?? "",
      permalink: json['permalink'] ?? "",
      description: json['description'] ?? "",
      shortDescription: json['short_description'] ?? "",
      price: json['price'] ?? "0",
      regularPrice: json['regular_price'] ?? "0",
      salePrice: json['sale_price'] ?? "0",
      onSale: json['on_sale'] ?? false,
      stockStatus: json['stock_status'] ?? "",

      images:
          (json['images'] is List)
              ? (json['images'] as List)
                  .map((img) => ProductImage.fromJson(img))
                  .toList()
              : [],

      categories:
          (json['categories'] is List)
              ? (json['categories'] as List)
                  .map((cat) => ProductCategory.fromJson(cat))
                  .toList()
              : [],
    );
  }
}

class ProductImage {
  final int id;
  final String src;
  final String name;
  final String alt;

  ProductImage({
    required this.id,
    required this.src,
    required this.name,
    required this.alt,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      src: json['src'] ?? "",
      name: json['name'] ?? "",
      alt: json['alt'] ?? "",
    );
  }
}

class ProductCategory {
  final int id;
  final String name;
  final String slug;

  ProductCategory({required this.id, required this.name, required this.slug});

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'],
      name: json['name'] ?? "",
      slug: json['slug'] ?? "",
    );
  }
}
