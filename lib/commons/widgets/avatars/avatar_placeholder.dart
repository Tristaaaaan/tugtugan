import 'package:flutter/material.dart';

class UserAvatarPlaceHolder extends StatelessWidget {
  final String name;

  const UserAvatarPlaceHolder({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Theme.of(context).colorScheme.tertiaryContainer,
      ),
      child: Center(
        child: Text(
          initials(name),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
    );
  }
}

String initials(String name) {
  final letters =
      name.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '').split('');

  return (letters.length >= 2)
      ? letters.take(2).join()
      : letters.join().padRight(2, 'A');
}
