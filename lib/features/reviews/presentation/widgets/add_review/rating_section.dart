import 'package:flutter/widgets.dart';
import 'package:tugtugan/features/reviews/presentation/widgets/add_review/review_with_rating.dart';

class RatingSection extends StatelessWidget {
  final String title;
  final String description;
  final void Function(int) onChanged;

  const RatingSection({
    required Key key,
    required this.title,
    required this.description,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReviewWithRating(
      key: key,
      title: title,
      description: description,
      onChanged: onChanged,
    );
  }
}
