import 'package:flutter/widgets.dart';

import 'review_textfield.dart';

class FeedbackSection extends StatelessWidget {
  const FeedbackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Care to share more?",
          style: TextStyle(fontSize: 22),
        ),
        SizedBox(height: 5),
        Text(
          "How was your overall experience?",
          style: TextStyle(fontSize: 16),
        ),
        ReviewTextField(),
      ],
    );
  }
}
