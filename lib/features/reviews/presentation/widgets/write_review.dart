import 'package:flutter/material.dart';

import 'review_form.dart';

void showReviewSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5, // 50% of screen height
        minChildSize: 0.4, // Minimum when collapsed
        maxChildSize: 0.9, // Maximum when expanded
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(16.0),
            child: const ReviewForm(),
          );
        },
      );
    },
  );
}
