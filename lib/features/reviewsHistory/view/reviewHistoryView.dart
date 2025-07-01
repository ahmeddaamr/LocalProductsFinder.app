import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/reviewsHistory/widget/productRatingCard.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/core/const/config.dart';
import 'package:flutter_application_1/core/models/product.dart';
import 'package:flutter_application_1/core/storage/storage.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/string.dart';
import 'package:flutter_application_1/features/home/widgets/bottom_nav_bar.dart';
import 'package:flutter_application_1/features/recomended_products/widgets/headerWidget.dart';
import 'package:flutter_application_1/core/models/ratings.dart';
// import 'package:flutter_application_1/features/reviewsHistory/widgets/productRatingCard.dart';

class ReviewHistoryPage extends StatelessWidget {
  const ReviewHistoryPage({super.key});

  Future<List<Map<String, dynamic>>> fetchUserRatings() async {
  final token = await readToken();
  final url = Uri.parse('${config.URI}/rating/getall');

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData is List) {
        return jsonData.map<Map<String, dynamic>>((item) {
          final product = Product(
            productId: item['product']['Product ID'] ?? 0,
            name: item['product']['Product Description'] ?? 'Unknown Product',
            category: item['product']['Product Category'] ?? 'Unknown Category',
            subcategory: item['product']['Sub-category'] ?? 'Unknown Subcategory',
            isLocal: item['product']['local'] ?? '',
            rating: (item['product']['average_rating'] != null)
                ? double.tryParse(item['product']['average_rating'].toString()) ?? 0
                : 0,
            ratings_count: (item['product']['rating_count'] != null)
                ? int.tryParse(item['product']['rating_count'].toString()) ?? 0
                : 0,
          );

          final review = ProductRatings(
            productId: item['review']['product_id'] ?? 0,
            rating: (item['review']['rating'] != null)
                ? double.tryParse(item['review']['rating'].toString()) ?? 0
                : 0,
            comment: item['review']['review'] ?? '',
            createdAt: DateTime.tryParse(item['review']['timestamp'] ?? '') ?? DateTime.now(),
          );

          return {
            "product": product,
            "review": review,
          };
        }).toList();
      }
    }

    print("❌ Failed with code: ${response.statusCode}");
    return [];
  } catch (e) {
    print("❌ Error fetching user ratings: $e");
    return [];
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: Column(
        children: [
          buildCustomHeader(
            context: context,
            title: 'Your Reviews',
            onBack: () {
             
                Navigator.pushReplacementNamed(context, Routes.home);
              
            },
          ),
          Expanded(
  child: FutureBuilder<List<Map<String, dynamic>>>(
    future: fetchUserRatings(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text("No reviews found."));
      }

      final combinedList = snapshot.data!;

      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: combinedList.length,
        itemBuilder: (context, index) {
          final product = combinedList[index]['product'] as Product;
          final rating = combinedList[index]['review'] as ProductRatings;

          return ProductRatingCard(
            product: product,
            rating: rating,
          );
        },
      );
    },
  ),
)
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 2,
      ),
      
    );
  }
}
