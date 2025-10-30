import 'package:flutter/material.dart';

class Hederbar extends StatelessWidget {
  const Hederbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Builder(
            builder:
                (context) => GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Image.asset(
                    'assets/images/Menu.png',
                    height: 50,
                    width: 50,
                  ),
                ),
          ),
        ),

        const SizedBox(height: 6),

        const Text(
          'perfume \nPalace2099',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          'Featured Collection',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
