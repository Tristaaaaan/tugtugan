import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegularTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final bool? numbersOnly;
  final String? title;
  final String hintText;
  final bool? withTitle;
  final bool? withSuffixIcon;
  final Function? onSuffixIconPressed;
  const RegularTextField({
    super.key,
    required this.controller,
    required this.icon,
    this.title,
    required this.hintText,
    this.numbersOnly = false,
    this.withTitle = true,
    this.withSuffixIcon = false,
    this.onSuffixIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (withTitle!)
          Text(
            title!,
            style: const TextStyle(fontSize: 14),
          ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    keyboardType: numbersOnly! ? TextInputType.number : null,
                    inputFormatters: numbersOnly!
                        ? [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ]
                        : null,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                ),
                if (withSuffixIcon!)
                  GestureDetector(
                    onTap: () => onSuffixIconPressed?.call(),
                    child: Icon(
                      Icons.send,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
