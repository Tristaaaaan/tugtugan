import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ReviewContentTile extends StatelessWidget {
  final String writtenReview;
  final String imageUrl;
  final int rating;
  final Timestamp timestamp;
  const ReviewContentTile({
    super.key,
    required this.writtenReview,
    required this.imageUrl,
    required this.rating,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Row(
                      children: [],
                    )
                  ],
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
