import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:tugtugan/core/appmodels/users.dart';

class ReviewContentTile extends StatelessWidget {
  final String writtenReview;
  final List<String> imageUrl;
  final int rating;
  final Timestamp timestamp;
  final UserData user;
  const ReviewContentTile({
    super.key,
    required this.writtenReview,
    required this.imageUrl,
    required this.rating,
    required this.timestamp,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          user.fullName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          'Rating',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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
