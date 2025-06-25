import 'package:flutter/material.dart';

class ProductInfoSection extends StatelessWidget {
  final double averageRating;
  final int totalReviews;

  const ProductInfoSection({
    required this.averageRating,
    required this.totalReviews,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("lib/assets/images/spiro.png", height: 120),
        const Text(
          "Spiro",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 24),
            const SizedBox(width: 8),
            Text(
              averageRating.toStringAsFixed(1),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        Text(
          "   $totalReviews ratings",
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 12),
        const Divider(thickness: 1),
      ],
    );
  }
}
