import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/string.dart';
import 'package:flutter_application_1/features/reviews/product_info_section.dart';
import 'package:flutter_application_1/features/reviews/review_card.dart';
import 'package:flutter_application_1/features/make_review/makeReview_view.dart';

class ProductReviewsPage extends StatelessWidget {
  final List<Map<String, dynamic>> dummyReviews = [
    {
      "user": "Lora Stevia",
      "rating": 4,
      "comment":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    },
    {
      "user": "Lora Stevia",
      "rating": 5,
      "comment":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    },
    {
      "user": "Lora Stevia",
      "rating": 3,
      "comment":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    },
    {
      "user": "Lora Stevia",
      "rating": 1,
      "comment": "Lorem Ipsum is simply dummy text.",
    },
  ];

  double _calculateAverageRating() {
    if (dummyReviews.isEmpty) return 0;
    double sum = dummyReviews.fold(0, (acc, review) => acc + review["rating"]);
    return sum / dummyReviews.length;
  }

  @override
  Widget build(BuildContext context) {
    double averageRating = _calculateAverageRating();
    int totalReviews = dummyReviews.length;

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
            averageRating: averageRating,
            totalReviews: totalReviews,
          ),
        
          Padding(
            padding: const EdgeInsets.only(left: 16 , top: 12 , bottom: 3),
            child: Text(
              "Users Reviews",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
         
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: dummyReviews.length,
              itemBuilder: (context, index) {
                final review = dummyReviews[index];
                return ReviewCard(
                  userName: review["user"],
                  rating: review["rating"],
                  comment: review["comment"],
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
                  productTitle: "V Super Soda Diet Cola Can",
                  productImageUrl: 'lib/assets/images/spiro.png',
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
