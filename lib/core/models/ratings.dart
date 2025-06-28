// import 'dart:convert';
// import 'package:localproductsfinder/core/const/config.dart';
// import 'package:localproductsfinder/core/models/product.dart';
// import 'package:http/http.dart' as http;

class ProductRatings{
  final int productId;
  final String? userId;
  final double rating;
  final String comment;
  final DateTime createdAt;

  ProductRatings({
    required this.productId,
    this.userId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory ProductRatings.fromJson(Map<String, dynamic> json) {
    return ProductRatings(
      productId: json['product_id'] ?? json['productId'] ?? 0,
      userId: json['user_id']?.toString(),
      rating: (json['rating'] is int)
          ? (json['rating'] as int).toDouble()
          : (json['rating'] ?? 0.0),
      comment: json['review'] ,
      createdAt: DateTime.tryParse(json['timestamp'] ?? json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  static List<ProductRatings> parseResponse(dynamic response) {
    if (response is List) {
      return response.map((item) => ProductRatings.fromJson(item)).toList();
    } else if (response is Map<String, dynamic> && response.containsKey('ratings')) {
      return (response['ratings'] as List).map((item) => ProductRatings.fromJson(item)).toList();
    } else {
      return [];
    }
  }
}