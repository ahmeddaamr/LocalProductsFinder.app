import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/submitReview.dart/submitReviewForm.dart';

void showSubmitReviewSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,

    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),

    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.55,
        child: const SubmitReviewContent(),
      );
      },
      ).whenComplete(() {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
    
  }

