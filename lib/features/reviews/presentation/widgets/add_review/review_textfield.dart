import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _ReviewTextFieldState extends State<ReviewTextField> {
  final int maxChars = 250;
  late final TextEditingController _controller;
  int remaining = 250;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()
      ..addListener(() {
        final text = _controller.text;
        setState(() {
          remaining = maxChars - text.length;
        });
        widget.onChanged(text); // ✅ Update parent/provider
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: const Border(
              bottom: BorderSide(color: Colors.grey),
            ),
          ),
          child: TextField(
            controller: _controller,
            maxLength: maxChars,
            maxLines: null,
            textAlignVertical: TextAlignVertical.top,
            cursorColor: Colors.black,
            style: const TextStyle(fontSize: 12),
            inputFormatters: [
              LengthLimitingTextInputFormatter(maxChars),
              SpaceSanitizerFormatter(),
            ],
            decoration: const InputDecoration(
              hintText: 'Tell us your experience with this studio',
              hintStyle: TextStyle(color: Colors.black45, fontSize: 12),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              counterText: '',
              contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 36),
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 12,
          child: Text(
            '$remaining/$maxChars',
            style: const TextStyle(fontSize: 8, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}

class SpaceSanitizerFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'\s+'), ' ').trimLeft();

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class ReviewTextField extends StatefulWidget {
  final void Function(String) onChanged;

  const ReviewTextField({
    super.key,
    required this.onChanged,
  });

  @override
  State<ReviewTextField> createState() => _ReviewTextFieldState();
}
