import 'dart:math';
import 'package:flutter/material.dart';
import 'package:perfumex/core/network/auth_repo.dart';
import 'package:perfumex/model/modelpr.dart';
import 'package:perfumex/features/home/widget/card_home.dart';
import 'package:perfumex/features/home/widget/hederBar.dart';

class ProductSection extends StatefulWidget {
  const ProductSection({super.key});

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  bool isLoading = false;
  List<Modelpr> products = [];
  List<Modelpr> featuredProducts = [];
  AuthRepo authRepo = AuthRepo();

  Future<void> getProducts() async {
    setState(() => isLoading = true);
    try {
      final fetchedProducts = await authRepo.getProducts();
      final random = Random();
      final shuffled = List<Modelpr>.from(fetchedProducts)..shuffle(random);
      featuredProducts = shuffled.take(6).toList();

      setState(() {
        products = fetchedProducts;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: getProducts,
                color: const Color(0xffBC5B27),
                backgroundColor: Colors.white,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  children: [
                    const SizedBox(height: 50),

                    const Hederbar(),
                    const SizedBox(height: 15),

                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: featuredProducts.length,
                        itemBuilder: (context, index) {
                          final product = featuredProducts[index];
                          return Container(
                            width: 180,
                            margin: const EdgeInsets.only(right: 10),
                            child: Carthome(product: product),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Best Seller',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio: 0.65,
                          ),
                      itemBuilder: (context, index) {
                        return Carthome(product: products[index]);
                      },
                    ),
                  ],
                ),
              ),
    );
  }
}
