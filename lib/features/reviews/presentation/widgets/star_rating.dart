import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final int maxRating;
  final ValueChanged<int> onRatingSelected;

  const StarRating({
    super.key,
    this.rating = 0,
    this.maxRating = 5,
    required this.onRatingSelected,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      key: key,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        final starIndex = index + 1;
        final isFilled = starIndex <= rating;

        return GestureDetector(
          key: ValueKey('star_$starIndex'), // Each star gets a key
          onTap: () => onRatingSelected(starIndex),
          child: Icon(
            isFilled ? Icons.star : Icons.star_border,
            color: isFilled ? Colors.amber : Colors.grey,
            size: 38,
          ),
        );
      }),
    );
  }
}
