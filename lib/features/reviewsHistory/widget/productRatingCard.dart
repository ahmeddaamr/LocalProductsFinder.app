import 'package:flutter/material.dart';
// import 'package:flutter_application_1/core/const/config.dart';
import 'package:flutter_application_1/core/models/product.dart';
// import 'package:flutter_application_1/core/utils/colors.dart';
// import 'package:flutter_application_1/core/utils/fonts.dart';
import 'package:flutter_application_1/core/models/ratings.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/features/reviews/reviews_page.dart'; // Assuming you renamed it or alias

class ProductRatingCard extends StatelessWidget {
  final ProductRatings rating;
  final Product product;

  const ProductRatingCard({
    super.key,
    required this.rating,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProductReviewsPage(product: product)),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.green, width: 0.8), // ✅ Border أخضر
        ),
        elevation: 3,
        color: MyColors.whiteColor,
        child: Padding(
          padding: const EdgeInsets.all(16), // ✅ زيادة Padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // ✅ صورة المنتج أو البائع
                 ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: Image.network(
    product.imageUrl,
    height: 70,
    width: 70,
    fit: BoxFit.contain, // ✅ عرض الصورة كاملة بدون قص
    errorBuilder: (context, error, stackTrace) => const Icon(
      Icons.broken_image,
      size: 60,
      color: Colors.red,
    ),
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;
      return const SizedBox(
        height: 70,
        width: 70,
        child: Center(child: CircularProgressIndicator()),
      );
    },
  ),
),

                  const SizedBox(width: 12),
                  // ✅ اسم المنتج والتعليق
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (rating.comment.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              '"${rating.comment}"',
                              style: const TextStyle(
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                                color: Colors.black54,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // ✅ التقييم أسفل الكارت وموجود في النص
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 22),
                    const SizedBox(width: 4),
                    Text(
                      rating.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
