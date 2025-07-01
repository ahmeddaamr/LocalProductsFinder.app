import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/product.dart';

class ProductInfoSection extends StatelessWidget {
  // final double averageRating;
  // final int totalReviews;
    final Product product;

  const ProductInfoSection({
    // required this.averageRating,
    // required this.totalReviews,
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          product.imageUrl, // ✅ Load images dynamically on scroll
          height: 150,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator()); // ✅ Show loader while loading
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image, size: 50, color: Colors.red); // ✅ Handle missing images
          },
        ),
        Text(
          product.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 24),
            const SizedBox(width: 8),
            Text(
              product.rating.toStringAsFixed(1),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        Text(
          "   ${product.ratings_count} ratings",
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 12),
        const Divider(thickness: 1),
      ],
    );
  }
}
