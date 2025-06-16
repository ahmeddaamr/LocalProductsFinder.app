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
        return IconButton(
          icon: Icon(
          Icons.star
        ,
            color:  index < selectedRating ? Colors.amber :  Colors.grey ,
            size: 32,
          ),
          onPressed: () => onRatingSelected(index + 1),
        );
      }),
    );
  }
}
