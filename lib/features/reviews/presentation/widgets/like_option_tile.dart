import 'package:flutter/material.dart';

class LikeOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  const LikeOption({
    super.key,
    required this.icon,
    required this.text,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Colors.green : Colors.black45;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 38, color: color),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(fontSize: 16, color: color),
          ),
        ],
      ),
    );
  }
}
