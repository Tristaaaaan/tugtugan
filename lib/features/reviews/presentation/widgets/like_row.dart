import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/review_provider.dart';
import 'like_option_tile.dart';

class LikeOptionsRow extends ConsumerStatefulWidget {
  const LikeOptionsRow({super.key});

  @override
  ConsumerState<LikeOptionsRow> createState() => _LikeOptionsRowState();
}

class _LikeOptionsRowState extends ConsumerState<LikeOptionsRow> {
  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(wouldRecommendProvider);

    return Row(
      children: [
        LikeOption(
          icon: Icons.thumb_up_rounded,
          text: 'Yes',
          isSelected: selected == true, // ✅ Safe nullable check
          onTap: () {
            ref.read(wouldRecommendProvider.notifier).state =
                selected == true ? null : true;
          },
        ),
        const SizedBox(width: 50),
        LikeOption(
          icon: Icons.thumb_down,
          text: 'No',
          isSelected: selected == false, // ✅ Safe nullable check
          onTap: () {
            ref.read(wouldRecommendProvider.notifier).state =
                selected == false ? null : false;
          },
        ),
      ],
    );
  }
}
