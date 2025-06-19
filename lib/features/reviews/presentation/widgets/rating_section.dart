import 'package:flutter/widgets.dart';
import 'package:tugtugan/features/reviews/presentation/widgets/review_with_rating.dart';

class RatingSection extends StatelessWidget {
  final String title;
  final String description;

  const RatingSection({
    required Key key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReviewWithRating(
      key: key!,
      title: title,
      description: description,
    );
  }
}
