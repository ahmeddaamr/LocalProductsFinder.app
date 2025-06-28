import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localproductsfinder/core/const/config.dart';
import 'package:localproductsfinder/core/storage/storage.dart';
import 'package:localproductsfinder/core/storage/storage.dart' as Storage;
import 'package:localproductsfinder/core/utils/colors.dart';
import 'package:localproductsfinder/features/make_review/makeReview_widgets.dart';
import 'package:localproductsfinder/features/make_review/rating_widget.dart';
import 'package:localproductsfinder/features/submitReview.dart/submitReviewSheet.dart';
import 'package:localproductsfinder/core/models/product.dart';

class MakeReviewPage extends StatefulWidget {
  final Product product;

  const MakeReviewPage({Key? key, required this.product}) : super(key: key);

  @override
  State<MakeReviewPage> createState() => _MakeReviewPageState();
}

class _MakeReviewPageState extends State<MakeReviewPage> {
  int selectedRating = 0;
  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(color: MyColors.homeBackgroundColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  buildReviewHeader(context: context, title: 'Review'),
                  const SizedBox(height: 10),
                  buildProductImageAndTitle(
                    productImageUrl: widget.product.imageUrl,
                    productTitle: widget.product.name,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLabel("Rate the product"),
                  StarRatingRow(
                    selectedRating: selectedRating,
                    onRatingSelected: (value) {
                      setState(() {
                        selectedRating = value;
                      });
                    },
                  ),
                  SizedBox(height: 40),
                  buildLabel("Comment"),
                  buildReviewTextField(
                    hintText: "Enter here ",
                    controller: commentController,
                  ),
                  const SizedBox(height: 30),
                  buildReviewButton(
                    label: "Submit Review",
                    onTap: () async {
                      //// THIS IS THE RATING AND COMMENT THAT WILL BE SUBMITTED "store it in the database"
                      final int rating = selectedRating;
                      final String comment = commentController.text.trim();
                      //TODO: Implement the logic to submit the review
                      //  print('Rating: $rating');
                      //  print('Comment: $comment');
                      try {
                        // Assuming you have a function to submit the review

                        // await submitReview(widget.product.id, rating, comment);
                        final response = await http.post(
                          Uri.parse(
                            '${config.URI}/rating/add/${widget.product.productId}',
                          ),
                          headers: {
                            'Content-Type': 'application/json',
                            "Authorization":
                                'Bearer ${await Storage.readToken()}',
                          },
                          body: jsonEncode({
                            'rating': rating,
                            'comment': comment,
                          }),
                        );
                        if (response.statusCode == 201) {
                          // Handle success
                          print('Review submitted successfully');
                          showSubmitReviewSheet(context);
                        } else {
                          // Handle error
                          throw Exception(
                            'Failed to submit review : ${response.headers['error']}',
                          );
                        }
                        // Show success message or navigate back
                      } catch (e) {
                        // Handle error
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to submit review: $e'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
