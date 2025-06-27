import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final double rate; 

  const RatingWidget({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        if (rate >= index + 1) {
          return const Icon(Icons.star, color: Colors.amber, size: 18);
        } else if (rate > index && rate < index + 1) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 18);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 18);
        }
      }),
    );
  }
}
