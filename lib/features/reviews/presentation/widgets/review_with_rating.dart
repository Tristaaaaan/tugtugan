import 'package:flutter/widgets.dart';

import 'star_rating.dart';

class ReviewWithRating extends StatefulWidget {
  const ReviewWithRating({super.key});

  @override
  State<ReviewWithRating> createState() => _ReviewWithRatingState();
}

class _ReviewWithRatingState extends State<ReviewWithRating> {
  int selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rate this studio',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        StarRating(
          key: widget.key,
          rating: selectedRating,
          onRatingSelected: (rating) {
            setState(() {
              selectedRating = rating;
            });
          },
        ),
      ],
    );
  }
}
