import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tugtugan/commons/widgets/avatars/avatar_placeholder.dart';
import 'package:tugtugan/commons/widgets/avatars/image_avatar.dart';
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
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              user.imageUrl == ""
                  ? UserAvatarPlaceHolder(name: user.fullName)
                  : ImageAvatar(
                      imageUrl: user.imageUrl!,
                      width: 50,
                      height: 50,
                    ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Row(
                                children: List.generate(
                                  5,
                                  (index) {
                                    IconData icon;
                                    Color color;

                                    if (index < rating.floor()) {
                                      icon = Icons.star;
                                      color = Colors.amber;
                                    } else if (index < rating) {
                                      icon = Icons.star_half;
                                      color = Colors.amber;
                                    } else {
                                      icon = Icons.star_border;
                                      color = Colors.grey;
                                    }

                                    return Icon(
                                      icon,
                                      size: 20,
                                      color: color,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          timeago.format(timestamp.toDate(),
                              locale: 'en_short'),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            writtenReview,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
