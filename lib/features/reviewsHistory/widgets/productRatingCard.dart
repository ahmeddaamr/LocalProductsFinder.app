import 'package:flutter/material.dart';
import 'package:localproductsfinder/core/const/config.dart';
import 'package:localproductsfinder/core/models/product.dart';
import 'package:localproductsfinder/core/utils/colors.dart';
import 'package:localproductsfinder/core/utils/fonts.dart';
import 'package:localproductsfinder/core/models/ratings.dart';
import 'package:localproductsfinder/features/reviews/reviews_page.dart'; // Assuming you renamed it or alias

class ProductRatingCard extends StatelessWidget {
  final ProductRatings rating;
  final Product product;
  const ProductRatingCard({
    super.key,
    required this.rating,
    required this.product,
  });
  // String get imageUrl => "${config.URI}/image/$category/$productId";
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProductReviewsPage(product:product)),
                );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
              // ✅ Allow text to take up remaining space, then ellipsis if too long
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: MyColors.greenColor,
                    ),
                    overflow: TextOverflow.ellipsis, // ✅ Prevent overflow, show "..."
                  ),
                  if (rating.comment.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        '"${rating.comment}"',
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
              ),
              const SizedBox(width: 8), // ✅ Small space between elements
              Image.network(
                product.imageUrl,
                height: 50,
                width: 50,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.red,
                  );
                },
              ),
              const SizedBox(width: 8), // ✅ Space between image and rating
              Row(
                mainAxisSize:
                    MainAxisSize
                        .min, // ✅ Only take space needed for star + text
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    rating.rating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
