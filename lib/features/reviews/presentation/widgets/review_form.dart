import 'package:flutter/material.dart';
import 'package:tugtugan/features/reviews/presentation/widgets/like_row.dart';
import 'package:tugtugan/features/reviews/presentation/widgets/review_textfield.dart';
import 'package:tugtugan/features/reviews/presentation/widgets/review_with_rating.dart';

class ReviewForm extends StatelessWidget {
  const ReviewForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('Leave a Review',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 18),
        const Text(
          "Instruments",
          style: TextStyle(fontSize: 24),
        ),
        const ReviewWithRating(
          key: Key('experience_rating'),
        ),
        const ReviewWithRating(
          key: Key('instrument_rating'),
        ),
        const Text(
          "How was you overall experience?",
          style: TextStyle(fontSize: 16),
        ),
        const Text(
          "Would you recommend this studio to a friend?",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 24,
        ),
        const LikeOptionsRow(),
        const SizedBox(height: 10),
        const Divider(thickness: .5),
        const SizedBox(height: 10),
        const Text(
          "Care to share more?",
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          "How was your overall experience?",
          style: TextStyle(fontSize: 16),
        ),
        const ReviewTextField(),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close modal
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
