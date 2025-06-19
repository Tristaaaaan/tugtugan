import 'package:flutter/material.dart';

import 'star_rating.dart';

class ReviewWithRating extends StatefulWidget {
  final String title;
  final String description;
  final void Function(int) onChanged;

  const ReviewWithRating({
    super.key,
    required this.title,
    required this.description,
    required this.onChanged,
  });

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
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.description,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        StarRating(
          key: widget.key,
          rating: selectedRating,
          onRatingSelected: (rating) {
            setState(() {
              selectedRating = rating;
            });
            widget.onChanged(rating);
          },
        ),
      ],
    );
  }
}
