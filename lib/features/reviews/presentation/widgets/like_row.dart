import 'package:flutter/material.dart';

import 'like_option_tile.dart';

class LikeOptionsRow extends StatefulWidget {
  const LikeOptionsRow({super.key});

  @override
  State<LikeOptionsRow> createState() => _LikeOptionsRowState();
}

class _LikeOptionsRowState extends State<LikeOptionsRow> {
  String? selected; // can be 'like', 'dislike', or null

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        LikeOption(
          icon: Icons.thumb_up_rounded,
          text: 'Yes',
          isSelected: selected == 'Yes',
          onTap: () {
            setState(() {
              selected = selected == 'Yes' ? null : 'Yes';
            });
          },
        ),
        const SizedBox(
          width: 50,
        ),
        LikeOption(
          icon: Icons.thumb_down,
          text: 'No',
          isSelected: selected == 'No',
          onTap: () {
            setState(() {
              selected = selected == 'No' ? null : 'No';
            });
          },
        ),
      ],
    );
  }
}
