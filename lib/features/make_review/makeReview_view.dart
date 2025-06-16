import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/make_review/makeReview_widgets.dart';
import 'package:flutter_application_1/features/make_review/rating_widget.dart';

class MakeReviewPage extends StatefulWidget {
  final String productTitle;
  final String productImageUrl;

  const MakeReviewPage({
    Key? key,
    required this.productTitle,
    required this.productImageUrl,
  }) : super(key: key);

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
        
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildReviewHeader(
              context: context,
              title: 'Review',
            ),

            const SizedBox(height: 10),

            buildProductImageAndTitle(
              productImageUrl: widget.productImageUrl,
              productTitle: widget.productTitle,
            ),

            const SizedBox(height: 24),
            buildLabel("Rate the product"),
            // Star Rating Row
        StarRatingRow(
        selectedRating: selectedRating,
        onRatingSelected: (value) {
          setState(() {
            selectedRating = value;
          },);
        },),

            SizedBox(height: 20,),

            buildLabel("Comment"),
            buildReviewTextField(
              hintText: "Enter here ",
              controller: commentController,
            ),

            const SizedBox(height: 24),

            buildReviewButton(
              label: "Submit Review",
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
