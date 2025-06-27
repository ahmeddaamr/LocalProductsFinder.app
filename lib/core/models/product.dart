import 'dart:math';
import 'package:localproductsfinder/core/const/config.dart';

class Product {
  final int productId;
  final String name;
  final String category;
  final String subcategory;
  final double rating;
  final int ratings_count; // ✅ Ensure ratings_count is an integer
  final String isLocal; // ✅ Default value for isLocal
  Product({
    required this.productId,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.rating,
    required this.isLocal,
    required this.ratings_count, // ✅ Ensure ratings_count is an integer
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final random = Random();
    double rawRating = 1 + random.nextDouble() * 4;
    double roundedRating = double.parse(rawRating.toStringAsFixed(1));

    return Product(
      productId: json['Product ID'] != null ? int.parse(json['Product ID'].toString()): 0, // ✅ Prevent null values
      name: json['Product Description'] ?? 'Unknown Product', // ✅ Use default value
      category: json['Product Category'] ?? 'Unknown Category', // ✅ Use default value
      subcategory: json['Sub-Category'] ?? 'Unknown Subcategory', // ✅ Use default value
      isLocal: json['local'] ?? "Cannot identify", // ✅ Use default value for isLocal
      rating: json['average_rating'] != null
          ? double.parse(json['average_rating'].toStringAsFixed(1)) // ✅ Ensure rating is a double
          : 0,
      ratings_count: json['rating_count'] != null
          ? int.parse(json['rating_count'].toString()) // ✅ Ensure ratings_count is an integer
          : 0, // ✅ Use default value for ratings_count
    );
  }
  String get imageUrl => "${config.URI}/image/$category/$productId"; // ✅ Dynamically construct image URL

}
