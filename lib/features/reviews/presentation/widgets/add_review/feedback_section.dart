import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/review_provider.dart';
import 'review_textfield.dart';

class FeedbackSection extends ConsumerWidget {
  const FeedbackSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Care to share more?",
          style: TextStyle(fontSize: 22),
        ),
        const SizedBox(height: 5),
        const Text(
          "How was your overall experience?",
          style: TextStyle(fontSize: 16),
        ),
        ReviewTextField(
          onChanged: (text) =>
              ref.read(writtenReviewProvider.notifier).state = text,
        ),
      ],
    );
  }
}
