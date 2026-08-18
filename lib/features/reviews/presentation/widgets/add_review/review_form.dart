import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../commons/widgets/buttons/loading_state_notifier.dart';
import '../../../../../commons/widgets/buttons/regular_button.dart';
import '../../../../../core/appmodels/review_model.dart';

import '../../provider/review_provider.dart';
import 'feedback_section.dart';
import 'header_section.dart';
import 'recommendation_section.dart';
import 'review_with_rating.dart';

class ReviewForm extends ConsumerWidget {
  final String studioId;
  const ReviewForm({super.key, required this.studioId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Leave a Review'),
        const SizedBox(height: 18),
        ReviewWithRating(
          key: const Key('experience_rating'),
          title: "Experience",
          description: "How was your experience with this studio?",
          onChanged: (rating) =>
              ref.read(experienceRatingProvider.notifier).state = rating,
        ),
        const SizedBox(height: 10),
        ReviewWithRating(
          key: const Key('instrument_rating'),
          title: "Instrument",
          description: "How was the instrument in this studio?",
          onChanged: (rating) =>
              ref.read(instrumentRatingProvider.notifier).state = rating,
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
          onTap: () async {
            if (ref.read(experienceRatingProvider) == 0) {
              return;
            }
            final isLoading = ref.read(regularButtonLoadingProvider.notifier);
            isLoading.setLoading("submitReview", true);

            try {
              final ReviewModel reviewData = ReviewModel(
                userId: auth.currentUser!.uid,
                studioId: studioId,
                experienceRating: ref.read(experienceRatingProvider),
                instrumentRating: ref.read(instrumentRatingProvider),
                wouldRecommend: ref.read(wouldRecommendProvider.notifier).state,
                writtenReview: ref.read(writtenReviewProvider),
                createdAt: Timestamp.now(),
              );

              await ref.read(reviewRepositoryProvider).addReview(reviewData);
            } catch (e) {
              developer.log("Error submitting review: $e");
            } finally {
              ref.read(instrumentRatingProvider.notifier).state = 0;
              ref.read(experienceRatingProvider.notifier).state = 0;
              ref.read(wouldRecommendProvider.notifier).state = null;
              ref.read(writtenReviewProvider.notifier).state = '';
              isLoading.setLoading("submitReview", false);
              if (context.mounted) {
                Navigator.pop(context);
              }
            }
          },
          width: double.infinity,
          withIcon: false,
          text: "Submit Review",
          backgroundColor: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.surface,
          buttonKey: "submitReview",
        ),
      ],
    );
  }
}
