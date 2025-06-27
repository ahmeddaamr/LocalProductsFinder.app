import 'package:flutter/material.dart';
import 'package:localproductsfinder/core/utils/string.dart';

class SubmitReviewContent extends StatelessWidget {
  const SubmitReviewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          const SizedBox(height: 20),
          const Text(
            'Thanks!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 12),
          const Text(
            'Your feedback helps others\ndiscover great local products.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          
          const SizedBox(height: 40),
          Image.asset(
            Path.Thanks, 
            height: 200,
          ),
        ],
      ),
    );
  }
}
