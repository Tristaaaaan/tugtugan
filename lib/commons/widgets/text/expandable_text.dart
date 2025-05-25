import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;

  const ExpandableText({
    required this.text,
    this.trimLines = 3,
    super.key,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _readMore = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: const TextStyle(
            fontSize: 14,
          ),
          maxLines: _readMore ? null : widget.trimLines,
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => setState(() => _readMore = !_readMore),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _readMore ? 'Read less' : 'Read more',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 7),
              Icon(
                Icons.keyboard_arrow_down,
                color: Theme.of(context).colorScheme.primary,
                size: 16,
              )
            ],
          ),
        ),
      ],
    );
  }
}
