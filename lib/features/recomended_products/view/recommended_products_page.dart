import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localproductsfinder/core/const/config.dart';
import 'package:localproductsfinder/core/utils/colors.dart';
import 'package:localproductsfinder/core/utils/fonts.dart';
import 'package:localproductsfinder/features/recomended_products/widgets/product_card.dart';
import 'package:localproductsfinder/core/utils/string.dart';

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
        return List<Map<String, dynamic>>.from(jsonResponse); // ✅ Return proper list
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
      appBar: AppBar(
        backgroundColor: MyColors.whiteColor,
        title: Text(
          "Recommended Similar Products",
          style: TextStyle(
            fontFamily: MyFonts.montserratFont,
            color: MyColors.fontColor,
            fontSize: 15,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp, color: MyColors.arrowColor),
          onPressed: () => Navigator.pushReplacementNamed(context, Routes.home),
        ),
      ),

      // ✅ Fix: Use `FutureBuilder` correctly
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: recommend(productId), // ✅ Remove `await` (pass future directly)
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // ✅ Show loading
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No recommendations available.")); // ✅ Handle empty state
          }

          List<Map<String, dynamic>> recommendedProducts = snapshot.data!; // ✅ Extract API data

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: recommendedProducts.length,
            itemBuilder: (context, index) {
              return ProductCard(
                imageUrl: '${config.URI}/image/${recommendedProducts[index]["Product Category"]}/${recommendedProducts[index]["Product ID"]}', // ✅ Use dynamic image
                title: recommendedProducts[index]["Product Description"]!,
              );
            },
          );
        },
      ),
    );
  }
}
