import 'dart:math';
import 'package:localproductsfinder/core/const/config.dart';

class Product {
  final String productId;
  final String name;
  final String category;
  final String subcategory;
  final double rating;

  Product({
    required this.productId,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final random = Random();
    double rawRating = 1 + random.nextDouble() * 4;
    double roundedRating = double.parse(rawRating.toStringAsFixed(1));

    return Product(
      productId: (json['Product ID'] ?? '').toString(), // ✅ Prevent null values
      name: json['Product Description'] ?? 'Unknown Product', // ✅ Use default value
      category: json['Product Category'] ?? 'Unknown Category', // ✅ Use default value
      subcategory: json['Sub-Category'] ?? 'Unknown Subcategory', // ✅ Use default value
      rating: roundedRating,
    );
  }

  // String get imageUrl => "http://127.0.0.1:5000/image/$category/$productId"; // ✅ Dynamically construct image URL
  String get imageUrl => "${config.URI}/image/$category/$productId"; // ✅ Dynamically construct image URL
  // String get imageUrl => "https://a3cd-102-46-16-89.ngrok-free.app/image/$category/$productId"; // ✅ Dynamically construct image URL

}
