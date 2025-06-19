import 'package:flutter/widgets.dart';

import 'like_row.dart';

class RecommendationSection extends StatelessWidget {
  const RecommendationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Would you recommend this studio?",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 16),
        LikeOptionsRow(),
      ],
    );
  }
}
