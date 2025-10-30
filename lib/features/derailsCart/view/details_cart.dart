import 'package:flutter/material.dart';
import 'package:perfumex/features/derailsCart/widget/details_add_button.dart';
import 'package:perfumex/features/derailsCart/widget/details_header.dart';
import 'package:perfumex/features/derailsCart/widget/details_image.dart';
import 'package:perfumex/features/derailsCart/widget/details_info.dart';
import 'package:perfumex/features/derailsCart/widget/details_quantity.dart';
import 'package:perfumex/model/modelpr.dart';

class DetailsCart extends StatefulWidget {
  final Modelpr product;
  const DetailsCart({super.key, required this.product});

  @override
  State<DetailsCart> createState() => _DetailsCartState();
}

class _DetailsCartState extends State<DetailsCart> {
  int quantity = 1;

  void _increment() => setState(() => quantity++);
  void _decrement() => setState(() {
    if (quantity > 1) quantity--;
  });

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailsHeader(product: product),
              DetailsImage(product: product),
              DetailsInfo(product: product),
              DetailsQuantity(
                quantity: quantity,
                onIncrement: _increment,
                onDecrement: _decrement,
              ),
              DetailsAddButton(product: product, quantity: quantity),
            ],
          ),
        ),
      ),
    );
  }
}
