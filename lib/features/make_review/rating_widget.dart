import 'package:flutter/material.dart';

class StarRatingRow extends StatelessWidget {
  final int selectedRating;
  final void Function(int) onRatingSelected;

  const StarRatingRow({
    super.key,
    required this.selectedRating,
    required this.onRatingSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return SizedBox(
          width: 52,
          height: 50,
          child: IconButton(
            icon: Icon(
              Icons.star,
              color: index < selectedRating ? Colors.amber : Colors.grey,
              size: 40,
            ),
            onPressed: () => onRatingSelected(index + 1),
          ),
        );
      }),
    );
  }
}
