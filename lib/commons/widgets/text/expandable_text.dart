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
          maxLines: _readMore ? null : widget.trimLines,
        ),
        InkWell(
          onTap: () => setState(() => _readMore = !_readMore),
          child: Text(
            _readMore ? 'Read less' : 'Read more',
            style: const TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
