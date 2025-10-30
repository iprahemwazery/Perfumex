import 'package:flutter/material.dart';
import 'package:perfumex/features/derailsCart/view/details_cart.dart';
import 'package:perfumex/model/modelpr.dart';

class Carthome extends StatelessWidget {
  final Modelpr product;

  const Carthome({super.key, required this.product});

  String _cleanDescription(String htmlString) {
    String text = htmlString.replaceAll(RegExp(r'<[^>]*>'), '');

    text = text
        .replaceAll(RegExp(r'&nbsp;'), ' ')
        .replaceAll(RegExp(r'&amp;'), '&')
        .replaceAll(RegExp(r'&quot;'), '"')
        .replaceAll(RegExp(r'&#39;'), "'")
        .replaceAll(RegExp(r'&lt;'), '<')
        .replaceAll(RegExp(r'&gt;'), '>');

    return text.trim();
  }

  @override
  Widget build(BuildContext context) {
    final cleanDescription = _cleanDescription(product.description);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsCart(product: product),
          ),
        );
      },
      child: Card(
        color: Colors.grey[200],
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 130,
              child: Image.network(
                product.images.isNotEmpty
                    ? product.images[0].src
                    : "https://via.placeholder.com/100",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 5),

                  Text(
                    cleanDescription.isNotEmpty
                        ? cleanDescription
                        : "No description available",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffBC5B27),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
