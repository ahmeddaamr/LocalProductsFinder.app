import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localproductsfinder/core/const/config.dart';
import 'package:localproductsfinder/core/utils/colors.dart';
import 'package:localproductsfinder/core/utils/fonts.dart';
import 'package:localproductsfinder/features/recomended_products/widgets/product_card.dart';
import 'package:localproductsfinder/core/utils/string.dart';
import 'package:localproductsfinder/features/home/widgets/bottom_nav_bar.dart';
import 'package:localproductsfinder/features/recomended_products/widgets/headerWidget.dart';
import 'package:localproductsfinder/core/models/product.dart';

class RecommendedProductsPage extends StatelessWidget {
  final int productId;

  const RecommendedProductsPage({super.key, required this.productId});

  // ✅ Fix: Use `http.get` instead of `http.MultipartRequest` for GET request.
  Future<List<Map<String, dynamic>>> recommend(int productId) async {
    var url = Uri.parse('${config.URI}/recommend/$productId');

    try {
      var response = await http.get(url); // ✅ Correct GET request method
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(
          jsonResponse,
        ); // ✅ Return proper list
      } else {
        print("❌ Failed to get recommendations: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("❌ Error getting recommendations: $e");
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
            title: 'Recommended Similar Products',
            onBack: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, Routes.camera);
              }
            },
          ),
          Expanded(
            // ✅ Fix: Use `FutureBuilder` correctly
            child:FutureBuilder<List<Map<String, dynamic>>>(
              future: recommend(
                productId,
              ), // ✅ Remove `await` (pass future directly)
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  ); // ✅ Show loading
                } else if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No recommendations available."),
                  ); // ✅ Handle empty state
                }

                List<Map<String, dynamic>> recommendedProducts =
                    snapshot.data!; // ✅ Extract API data

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: recommendedProducts.length,
                  itemBuilder: (context, index) {
                    final product = Product(
                      productId:
                          int.tryParse(
                            recommendedProducts[index]["Product ID"]
                                    ?.toString() ??
                                '',
                          ) ??
                          0,
                      name:
                          recommendedProducts[index]["Product Description"] ??
                          'Unknown Product',
                      category:
                          recommendedProducts[index]["Product Category"] ??
                          'Unknown Category',
                      subcategory:
                          recommendedProducts[index]["Sub-Category"] ??
                          'Unknown Subcategory',
                      isLocal:
                          recommendedProducts[index]["Local"] ??
                          "cannot identify",
                      rating:
                          double.tryParse(
                            recommendedProducts[index]["average_rating"]
                                    ?.toString() ??
                                '',
                          ) ??
                          0,
                      ratings_count:
                          int.tryParse(
                            recommendedProducts[index]["rating_count"]
                                    ?.toString() ??
                                '',
                          ) ??
                          0,
                    );
                    return ProductCard(
                      // imageUrl: product.imageUrl,
                      // title: product.name,
                      // ratee: product.rating,
                      product: product,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 2,
        productId: productId, // Pass productId to BottomNavBar if needed
      ),
    );
  }
}