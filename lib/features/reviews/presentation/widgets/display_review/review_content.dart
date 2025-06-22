import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      initial: () => const Center(
        child: CircularProgressIndicator(),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error) => Center(
        child: Text(error.toString()),
      ),
      empty: () => const Center(
        child: Text('No Reviews'),
      ),
      loaded: (review) {
        return Column(
          children: [
            for (final item in review!)
              if (item.writtenReview !=
                  null) // Only include items with non-null reviews
                ReviewContentTile(
                  writtenReview:
                      item.writtenReview!, // The ! asserts it's non-null
                  imageUrl: item.images, // The ! asserts it's non-null
                  rating: item.experienceRating,
                  timestamp: Timestamp.fromDate(item.createdAt),
                ),
          ],
        );
      },
    );
  }
}
