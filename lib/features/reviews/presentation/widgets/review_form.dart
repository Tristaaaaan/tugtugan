import 'package:flutter/material.dart';
import 'package:tugtugan/commons/widgets/buttons/regular_button.dart';

import 'feedback_section.dart';
import 'header_section.dart';
import 'recommendation_section.dart';
import 'review_with_rating.dart';

class ReviewForm extends StatelessWidget {
  const ReviewForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Leave a Review'),
        const SizedBox(height: 18),
        const ReviewWithRating(
          key: Key('experience_rating'),
          title: "Experience",
          description: "How was your experience with this studio?",
        ),
        const SizedBox(height: 10),
        const ReviewWithRating(
          key: Key('instrument_rating'),
          title: "Instrument",
          description: "How was the instrument in this studio?",
        ),
        const SizedBox(height: 10),
        const Divider(thickness: .5),
        const SizedBox(height: 10),
        const RecommendationSection(),
        const SizedBox(height: 10),
        const Divider(thickness: .5),
        const SizedBox(height: 10),
        const FeedbackSection(),
        const SizedBox(height: 16),
        RegularButton(
          width: double.infinity,
          withIcon: false,
          text: "Submit Review",
          backgroundColor: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.surface,
          buttonKey: "submit_review",
        ),
      ],
    );
  }
}
