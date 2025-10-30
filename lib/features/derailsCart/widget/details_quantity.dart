import 'package:flutter/material.dart';

class DetailsQuantity extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const DetailsQuantity({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Quantity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('50 ml', style: TextStyle(fontSize: 16)),
                Text('100% Alcohol free', style: TextStyle(fontSize: 16)),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                _buildButton(Icons.remove, Colors.black, onDecrement),
                const SizedBox(width: 10),
                Text(
                  '$quantity',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                _buildButton(Icons.add, Colors.deepOrangeAccent, onIncrement),
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  static Widget _buildButton(IconData icon, Color color, VoidCallback onTap) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 20),
        onPressed: onTap,
      ),
    );
  }
}
