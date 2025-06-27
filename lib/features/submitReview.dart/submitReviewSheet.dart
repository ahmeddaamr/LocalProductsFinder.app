import 'package:flutter/material.dart';
import 'package:localproductsfinder/features/submitReview.dart/submitReviewForm.dart';
import 'package:localproductsfinder/core/utils/string.dart';

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
        Navigator.pushReplacementNamed(context, Routes.home);
      });
    
  }

