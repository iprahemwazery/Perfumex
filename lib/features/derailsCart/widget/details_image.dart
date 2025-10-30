import 'package:flutter/material.dart';
import 'package:perfumex/model/modelpr.dart';

class DetailsImage extends StatelessWidget {
  final Modelpr product;
  const DetailsImage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        product.images.isNotEmpty
            ? product.images[0].src
            : "https://via.placeholder.com/300x300?text=No+Image",
        height: 270,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder:
            (context, error, stackTrace) => Container(
              height: 270,
              color: Colors.grey[200],
              alignment: Alignment.center,
              child: const Icon(
                Icons.broken_image,
                size: 80,
                color: Colors.grey,
              ),
            ),
      ),
    );
  }
}
