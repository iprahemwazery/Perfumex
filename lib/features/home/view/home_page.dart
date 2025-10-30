import 'package:flutter/material.dart';
import 'package:perfumex/features/home/widget/drawerd.dart';
import 'package:perfumex/features/home/widget/productSection.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawerd(),
      body: ProductSection(),
    );
  }
}
