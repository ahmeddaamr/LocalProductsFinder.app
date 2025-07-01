import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/string.dart';
import 'package:flutter_application_1/features/reviews/product_info_section.dart';
import 'package:flutter_application_1/features/reviews/review_card.dart';
import 'package:flutter_application_1/features/make_review/makeReview_view.dart';
import 'package:flutter_application_1/core/models/product.dart';
import 'package:flutter_application_1/core/models/ratings.dart';
import 'package:flutter_application_1/core/const/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ProductReviewsPage extends StatelessWidget {
  final Product product;
  const ProductReviewsPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  Future<List<ProductRatings>> getProductRatings(productId) async {
    final response = await http.get(Uri.parse('${config.URI}/rating/get/$productId'));
    final data = jsonDecode(response.body);
    return ProductRatings.parseResponse(data);
  }
@override
  Widget build(BuildContext context) {
    // double averageRating = _calculateAverageRating();
    // int totalReviews = dummyReviews.length;
    // Future <List<ProductRatings>> reviews = getProductRatings(product.productId);
    // double averageRating = product.rating ;
    // int totalReviews = product.ratings_count;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          SizedBox(height: 50,),
          Align(
            
            alignment: Alignment.topLeft,
            child :
          IconButton(
            
            icon: Icon(
              Icons.arrow_back_ios_new_sharp,
              size: 22,
              color: MyColors.arrowColor,
            ),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, Routes.home);
              }
            },
          ),),
          ProductInfoSection(
            // averageRating: averageRating,
            // totalReviews: totalReviews,
            product: product,
          ),
        
          Padding(
            padding: const EdgeInsets.only(left: 16 , top: 12 , bottom: 3),
            child: Text(
              "Users Reviews",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
         
          Expanded(
            child: FutureBuilder<List<ProductRatings>>(
              future: getProductRatings(product.productId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No reviews yet.'));
                }
                final reviews = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    final review = reviews[index];
                    return ReviewCard(
                      // userName: review.userId.toString(),
                      // rating: review.rating.round(),
                      // comment: review.comment,
                      productRating: review,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MakeReviewPage(
                  // Replace with actual product data
                  // productTitle: "V Super Soda Diet Cola Can",
                  // productImageUrl: 'lib/assets/images/spiro.png',
                  product: product,
                ),
              ),
            );
          },
          child: const Text(
            "Leave a Review",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
