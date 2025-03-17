import 'package:flutter/material.dart';
// import 'package:localproductsfinder/core/utils/colors.dart';
// import 'package:localproductsfinder/core/utils/string.dart';
import 'package:localproductsfinder/core/models/product.dart';  // ✅ Import common Product model


class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.green, width: 0.8),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image.network(
                product.imageUrl, // ✅ Load images dynamically on scroll
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator()); // ✅ Show loader while loading
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 50, color: Colors.red); // ✅ Handle missing images
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 16),
                  Text(product.rating.toString(), style: const TextStyle(fontSize: 12)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement Add Review Logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: const Text(
                  "Add Review",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
