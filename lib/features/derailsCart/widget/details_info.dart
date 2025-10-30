import 'package:flutter/material.dart';
import 'package:perfumex/features/auth/data/html_cleaner.dart';
import 'package:perfumex/model/modelpr.dart';

class DetailsInfo extends StatelessWidget {
  final Modelpr product;
  const DetailsInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                product.name.isNotEmpty ? product.name : "منتج بدون اسم",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '\$${product.price.isNotEmpty ? product.price : "0"}',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          product.description.isNotEmpty
              ? removeHtmlTags(product.description)
              : "لا يوجد وصف متاح لهذا المنتج.",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            height: 1.4,
          ),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
