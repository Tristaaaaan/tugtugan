import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/appmodels/users.dart';
import '../../../domain/model/review.dart';
import '../../provider/review_controller.dart';
import 'review_content_tile.dart';

class ReviewContent extends ConsumerWidget {
  final String studioId;

  const ReviewContent({
    super.key,
    required this.studioId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewContent = ref.watch(
      reviewContentControllerProvider(studioId),
    );

    return reviewContent.when(
      initial: () => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error) => Center(child: Text(error.toString())),
      empty: () => const Center(child: Text('No Reviews')),
      loaded: (reviews, users) {
        final reviewList = reviews as List<Review>;
        final userMap = users as Map<String, UserData>;

        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: reviewList
              .where((item) => item.writtenReview?.isNotEmpty ?? false)
              .map((item) {
            final UserData user = userMap[item.userId]!;

            return ReviewContentTile(
              writtenReview: item.writtenReview!,
              imageUrl: item.images,
              rating: item.experienceRating,
              timestamp: Timestamp.fromDate(item.createdAt),
              user: user,
            );
          }).toList(),
        );
      },
    );
  }
}
